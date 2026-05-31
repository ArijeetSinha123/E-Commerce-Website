package model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import model.Product;
import util.DBConnection;

public class ProductDAO {

    public List<Product> findAll(String search) throws SQLException {
        return findAll(search, null, null, null, null, null);
    }

    public List<Product> findAll(String search, String category, BigDecimal minPrice, BigDecimal maxPrice,
            String stockFilter, String sort) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT id, name, description, price, stock, category FROM products";
        boolean hasSearch = search != null && !search.trim().isEmpty();
        List<String> where = new ArrayList<>();
        List<Object> values = new ArrayList<>();

        if (hasSearch) {
            where.add("(name LIKE ? OR description LIKE ? OR category LIKE ?)");
            String keyword = "%" + search.trim() + "%";
            values.add(keyword);
            values.add(keyword);
            values.add(keyword);
        }

        if (category != null && !category.trim().isEmpty() && !"All".equalsIgnoreCase(category.trim())) {
            where.add("category = ?");
            values.add(category.trim());
        }

        if (minPrice != null) {
            where.add("price >= ?");
            values.add(minPrice);
        }

        if (maxPrice != null) {
            where.add("price <= ?");
            values.add(maxPrice);
        }

        if ("in".equalsIgnoreCase(stockFilter)) {
            where.add("stock > 0");
        } else if ("out".equalsIgnoreCase(stockFilter)) {
            where.add("stock <= 0");
        }

        if (!where.isEmpty()) {
            sql += " WHERE " + String.join(" AND ", where);
        }

        sql += " ORDER BY " + resolveSort(sort);

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            for (int i = 0; i < values.size(); i++) {
                Object value = values.get(i);
                if (value instanceof BigDecimal) {
                    stmt.setBigDecimal(i + 1, (BigDecimal) value);
                } else {
                    stmt.setString(i + 1, value.toString());
                }
            }

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    products.add(mapProduct(rs));
                }
            }
        }

        return products;
    }

    private String resolveSort(String sort) {
        if ("price_asc".equals(sort)) {
            return "price ASC, name ASC";
        }
        if ("price_desc".equals(sort)) {
            return "price DESC, name ASC";
        }
        if ("name_asc".equals(sort)) {
            return "name ASC";
        }
        if ("name_desc".equals(sort)) {
            return "name DESC";
        }
        return "id DESC";
    }

    public Product findById(int id) throws SQLException {
        String sql = "SELECT id, name, description, price, stock, category FROM products WHERE id = ?";

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
        String sql = "INSERT INTO products (name, description, price, stock, category) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            setProductFields(stmt, product);
            return stmt.executeUpdate() == 1;
        }
    }

    public boolean update(Product product) throws SQLException {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, stock = ?, category = ? WHERE id = ?";

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
        stmt.setString(5, product.getCategory());
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setDescription(rs.getString("description"));
        product.setPrice(rs.getBigDecimal("price"));
        product.setStock(rs.getInt("stock"));
        product.setCategory(rs.getString("category"));
        return product;
    }
}
