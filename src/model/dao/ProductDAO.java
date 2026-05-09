package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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

        sql += " ORDER BY created_at DESC";

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
