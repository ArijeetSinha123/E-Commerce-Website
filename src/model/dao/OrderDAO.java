package model.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import model.CartItem;
import model.Order;
import util.DBConnection;

public class OrderDAO {
    private static final Set<String> VALID_STATUSES = new HashSet<>(
            Arrays.asList("PLACED", "PROCESSING", "SHIPPED", "DELIVERED", "CANCELLED"));

    public int createOrder(int userId, Map<Integer, CartItem> cart) throws SQLException {
        String orderSql = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, 'PLACED')";
        String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
        String stockSql = "UPDATE products SET stock = stock - ? WHERE id = ? AND stock >= ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
                    PreparedStatement itemStmt = conn.prepareStatement(itemSql);
                    PreparedStatement stockStmt = conn.prepareStatement(stockSql)) {

                orderStmt.setInt(1, userId);
                orderStmt.setBigDecimal(2, calculateTotal(cart));
                orderStmt.executeUpdate();

                int orderId;
                try (ResultSet keys = orderStmt.getGeneratedKeys()) {
                    if (!keys.next()) {
                        throw new SQLException("Order id was not generated.");
                    }
                    orderId = keys.getInt(1);
                }

                for (CartItem item : cart.values()) {
                    int productId = item.getProduct().getId();
                    int quantity = item.getQuantity();

                    stockStmt.setInt(1, quantity);
                    stockStmt.setInt(2, productId);
                    stockStmt.setInt(3, quantity);

                    if (stockStmt.executeUpdate() != 1) {
                        throw new SQLException("Insufficient stock for product id " + productId);
                    }

                    itemStmt.setInt(1, orderId);
                    itemStmt.setInt(2, productId);
                    itemStmt.setInt(3, quantity);
                    itemStmt.setBigDecimal(4, item.getProduct().getPrice());
                    itemStmt.addBatch();
                }
                itemStmt.executeBatch();

                conn.commit();
                return orderId;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public List<Order> findByUserId(int userId) throws SQLException {
        String sql = "SELECT o.id, o.user_id, u.name AS customer_name, o.total_amount, o.status, o.created_at "
                + "FROM orders o JOIN users u ON o.user_id = u.id WHERE o.user_id = ? ORDER BY o.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            return readOrders(stmt);
        }
    }

    public List<Order> findAll() throws SQLException {
        String sql = "SELECT o.id, o.user_id, u.name AS customer_name, o.total_amount, o.status, o.created_at "
                + "FROM orders o JOIN users u ON o.user_id = u.id ORDER BY o.created_at DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            return readOrders(stmt);
        }
    }

    public boolean updateStatus(int orderId, String status) throws SQLException {
        status = normalizeStatus(status);

        String findSql = "SELECT status FROM orders WHERE id = ?";
        String updateSql = "UPDATE orders SET status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement findStmt = conn.prepareStatement(findSql);
                    PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {

                findStmt.setInt(1, orderId);

                String oldStatus;
                try (ResultSet rs = findStmt.executeQuery()) {
                    if (!rs.next()) {
                        conn.rollback();
                        return false;
                    }
                    oldStatus = rs.getString("status");
                }

                updateStmt.setString(1, status);
                updateStmt.setInt(2, orderId);
                boolean updated = updateStmt.executeUpdate() == 1;

                if (updated && "CANCELLED".equals(status) && !"CANCELLED".equals(oldStatus)) {
                    restoreOrderStock(conn, orderId);
                }

                conn.commit();
                return updated;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public boolean cancelByUser(int orderId, int userId) throws SQLException {
        String sql = "UPDATE orders SET status = 'CANCELLED' "
                + "WHERE id = ? AND user_id = ? AND status IN ('PLACED', 'PROCESSING')";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, orderId);
                stmt.setInt(2, userId);

                boolean cancelled = stmt.executeUpdate() == 1;
                if (cancelled) {
                    restoreOrderStock(conn, orderId);
                }

                conn.commit();
                return cancelled;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public int countOrders() throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders";

        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            rs.next();
            return rs.getInt(1);
        }
    }

    private List<Order> readOrders(PreparedStatement stmt) throws SQLException {
        List<Order> orders = new ArrayList<>();

        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setCustomerName(rs.getString("customer_name"));
                order.setTotalAmount(rs.getBigDecimal("total_amount"));
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                orders.add(order);
            }
        }

        return orders;
    }

    private BigDecimal calculateTotal(Map<Integer, CartItem> cart) {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : cart.values()) {
            total = total.add(item.getSubtotal());
        }
        return total;
    }

    public static boolean isValidStatus(String status) {
        return status != null && VALID_STATUSES.contains(status.trim().toUpperCase());
    }

    private String normalizeStatus(String status) {
        if (!isValidStatus(status)) {
            throw new IllegalArgumentException("Invalid order status.");
        }
        return status.trim().toUpperCase();
    }

    private void restoreOrderStock(Connection conn, int orderId) throws SQLException {
        String sql = "UPDATE products p "
                + "JOIN order_items oi ON p.id = oi.product_id "
                + "SET p.stock = p.stock + oi.quantity "
                + "WHERE oi.order_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            stmt.executeUpdate();
        }
    }
}
