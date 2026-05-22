package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import model.Product;
import util.DBConnection;

public class ProductDAO {

    public List<Product> findAll(String search) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT id, name, description, price, stock, image_url FROM products";
        boolean hasSearch = search != null && !search.trim().isEmpty();

        if (hasSearch) {
            sql += " WHERE name LIKE ? OR description LIKE ?";
        }

        sql += " ORDER BY id DESC";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            if (hasSearch) {
                String keyword = "%" + search.trim() + "%";
                stmt.setString(1, keyword);
                stmt.setString(2, keyword);
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }
        }

        return products;
    }

    public Product findById(int id) throws SQLException {
        String sql = "SELECT id, name, description, price, stock, image_url FROM products WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapProduct(rs);
                }
            }
        }

        return null;
    }

    public boolean save(Product product) throws SQLException {
        String sql = "INSERT INTO products (name, description, price, stock, image_url) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            setProductFields(stmt, product);
            return stmt.executeUpdate() == 1;
        }
    }

    public boolean update(Product product) throws SQLException {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, stock = ?, image_url = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            setProductFields(stmt, product);
            stmt.setInt(6, product.getId());
            return stmt.executeUpdate() == 1;
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            return stmt.executeUpdate() == 1;
        }
    }

    public boolean existsInOrders(int id) throws SQLException {
        String sql = "SELECT COUNT(*) FROM order_items WHERE product_id = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);

            try (ResultSet rs = stmt.executeQuery()) {
                rs.next();
                return rs.getInt(1) > 0;
            }
        }
    }

    public int countProducts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM products";

        try (Connection conn = DBConnection.getConnection();
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery(sql)) {

            rs.next();
            return rs.getInt(1);
        }
    }

    private void setProductFields(PreparedStatement stmt, Product product) throws SQLException {
        stmt.setString(1, product.getName());
        stmt.setString(2, product.getDescription());
        stmt.setBigDecimal(3, product.getPrice());
        stmt.setInt(4, product.getStock());
        stmt.setString(5, product.getImageUrl());
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setStock(rs.getInt("stock"));
        product.setImageUrl(rs.getString("image_url"));
        return product;
    }
}
