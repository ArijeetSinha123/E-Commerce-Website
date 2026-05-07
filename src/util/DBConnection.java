package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/ecommerce_db";
    private static final String DEFAULT_USER = "root";
    private static final String DEFAULT_PASSWORD = "";

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        String url = getConfig("DB_URL", DEFAULT_URL);
        String user = getConfig("DB_USER", DEFAULT_USER);
        String password = getConfig("DB_PASSWORD", DEFAULT_PASSWORD);

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC driver not found. Add mysql-connector-j.jar to WEB-INF/lib.", e);
        }

        return DriverManager.getConnection(url, user, password);
    }

    private static String getConfig(String key, String defaultValue) {
        String value = System.getenv(key);

        if (value == null || value.trim().isEmpty()) {
            value = System.getProperty(key);
        }

        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
        }

        return value;
    }
}
