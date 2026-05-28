package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Admin;
import util.DBConnection;

public class AdminDAO {

    public Admin login(String email, String password) throws SQLException {
        String sql = "SELECT id, name, email, password, force_password_change FROM admins WHERE email = ? AND password = ? AND active = TRUE";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Admin admin = new Admin();
                    admin.setId(rs.getInt("id"));
                    admin.setName(rs.getString("name"));
                    admin.setEmail(rs.getString("email"));
                    admin.setPassword(rs.getString("password"));
                    admin.setForcePasswordChange(rs.getBoolean("force_password_change"));
                    return admin;
                }
            }
        }

        return null;
    }

    public boolean changePassword(int adminId, String currentPassword, String newPassword) throws SQLException {
        String sql = "UPDATE admins SET password = ?, force_password_change = FALSE WHERE id = ? AND password = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newPassword);
            stmt.setInt(2, adminId);
            stmt.setString(3, currentPassword);

            return stmt.executeUpdate() == 1;
        }
    }
}
