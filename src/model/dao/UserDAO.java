package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.User;
import util.DBConnection;

public class UserDAO {

    public boolean register(User user) throws SQLException {
        String sql = "INSERT INTO users (name, email, password) VALUES (?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());

            return stmt.executeUpdate() == 1;
        } catch (SQLIntegrityConstraintViolationException e) {
            return false;
        }
    }

    public User login(String email, String password) throws SQLException {
        String sql = "SELECT id, name, email, password FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    return user;
                }
            }
        }

        return null;
    }

    public List<User> findAll() throws SQLException {
        String sql = "SELECT id, name, email, password FROM users ORDER BY id DESC";
        List<User> users = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                users.add(mapUser(rs));
            }
        }

        return users;
    }

    public User findById(int id) throws SQLException {
        String sql = "SELECT id, name, email, password FROM users WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapUser(rs);
                }
            }
        }

        return null;
    }

    public boolean update(User user) throws SQLException {
        String sql = "UPDATE users SET name = ?, email = ?, password = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setInt(4, user.getId());

            return stmt.executeUpdate() == 1;
        } catch (SQLIntegrityConstraintViolationException e) {
            return false;
        }
    }

    public boolean delete(int id) throws SQLException {
        String itemSql = "DELETE oi FROM order_items oi "
                + "JOIN orders o ON oi.order_id = o.id "
                + "WHERE o.user_id = ? AND o.status = 'CANCELLED'";
        String orderSql = "DELETE FROM orders WHERE user_id = ? AND status = 'CANCELLED'";
        String userSql = "DELETE FROM users WHERE id = ?";

        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement itemStmt = conn.prepareStatement(itemSql);
                    PreparedStatement orderStmt = conn.prepareStatement(orderSql);
                    PreparedStatement userStmt = conn.prepareStatement(userSql)) {

                itemStmt.setInt(1, id);
                itemStmt.executeUpdate();

                orderStmt.setInt(1, id);
                orderStmt.executeUpdate();

                userStmt.setInt(1, id);
                boolean deleted = userStmt.executeUpdate() == 1;

                conn.commit();
                return deleted;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                conn.setAutoCommit(true);
            }
        }
    }

    public boolean hasActiveOrders(int id) throws SQLException {
        String sql = "SELECT COUNT(*) FROM orders WHERE user_id = ? AND status <> 'CANCELLED'";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                rs.next();
                return rs.getInt(1) > 0;
            }
        }
    }

    public int countUsers() throws SQLException {
        String sql = "SELECT COUNT(*) FROM users";

        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            rs.next();
            return rs.getInt(1);
        }
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setName(rs.getString("name"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        return user;
    }
}
