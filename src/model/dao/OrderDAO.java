package model.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import model.CartItem;
import model.Order;
import util.DBConnection;

public class OrderDAO {

    public int createOrder(int userId, Map<Integer, CartItem> cart) throws SQLException {
        String orderSql = "INSERT INTO orders (user_id, total_amount, status) VALUES (?, ?, 'PLACED')";
        String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
                    PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {

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
                    itemStmt.setInt(1, orderId);
                    itemStmt.setInt(2, item.getProduct().getId());
                    itemStmt.setInt(3, item.getQuantity());
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
        String sql = "UPDATE orders SET status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            return stmt.executeUpdate() == 1;
        }
    }

    public boolean cancelByUser(int orderId, int userId) throws SQLException {
        String sql = "UPDATE orders SET status = 'CANCELLED' "
                + "WHERE id = ? AND user_id = ? AND status IN ('PLACED', 'PROCESSING')";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() == 1;
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
}
