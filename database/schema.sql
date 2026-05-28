CREATE DATABASE IF NOT EXISTS ecommerce_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ecommerce_db;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    active BOOLEAN NOT NULL DEFAULT TRUE,
    force_password_change BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    category VARCHAR(60) NOT NULL DEFAULT 'Electronics',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(30) NOT NULL DEFAULT 'PLACED',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(id),
    CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(id)
);

SET @schema_name = DATABASE();

SET @sql = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE admins ADD COLUMN active BOOLEAN NOT NULL DEFAULT TRUE',
        'DO 0'
    )
    FROM information_schema.columns
    WHERE table_schema = @schema_name
      AND table_name = 'admins'
      AND column_name = 'active'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE products ADD COLUMN image_url VARCHAR(255)',
        'DO 0'
    )
    FROM information_schema.columns
    WHERE table_schema = @schema_name
      AND table_name = 'products'
      AND column_name = 'image_url'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE products ADD COLUMN category VARCHAR(60) NOT NULL DEFAULT ''Electronics''',
        'DO 0'
    )
    FROM information_schema.columns
    WHERE table_schema = @schema_name
      AND table_name = 'products'
      AND column_name = 'category'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(
        COUNT(*) = 0,
        'ALTER TABLE admins ADD COLUMN force_password_change BOOLEAN NOT NULL DEFAULT FALSE',
        'DO 0'
    )
    FROM information_schema.columns
    WHERE table_schema = @schema_name
      AND table_name = 'admins'
      AND column_name = 'force_password_change'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

INSERT INTO admins (name, email, password, active, force_password_change)
SELECT 'Admin', 'admin@example.com', 'admin123', TRUE, TRUE
WHERE NOT EXISTS (SELECT 1 FROM admins WHERE email = 'admin@example.com');

UPDATE admins
SET force_password_change = TRUE
WHERE email = 'admin@example.com'
  AND password = 'admin123';

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Wireless Headphones', 'Bluetooth headphones with long battery life.', 2499.00, 25, NULL, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Wireless Headphones');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Smart Watch', 'Fitness tracking and mobile notifications.', 3999.00, 18, NULL, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Smart Watch');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Bluetooth Speaker', 'Portable wireless speaker with clear sound for daily music and calls.', 1599.00, 20, NULL, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Bluetooth Speaker');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Laptop Backpack', 'Water-resistant backpack with laptop storage.', 1299.00, 40, NULL, 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Laptop Backpack');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Cotton Casual Shirt', 'Comfortable everyday shirt for a clean casual look.', 799.00, 35, NULL, 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Cotton Casual Shirt');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Classic Denim Jeans', 'Durable denim jeans with a comfortable everyday fit.', 1499.00, 22, NULL, 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Classic Denim Jeans');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Ceramic Coffee Mug', 'Durable ceramic mug for tea, coffee, and daily use.', 299.00, 50, NULL, 'Home & Living'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Ceramic Coffee Mug');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Desk Table Lamp', 'Compact table lamp for study, work desk, and bedroom lighting.', 699.00, 26, NULL, 'Home & Living'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Desk Table Lamp');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Soft Cushion Pillow', 'Soft cushion pillow for sofa, bed, and home comfort.', 499.00, 32, NULL, 'Home & Living'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Soft Cushion Pillow');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'ProFit Yoga Mat', 'Non-slip sports yoga mat for home workouts and fitness training.', 899.00, 25, NULL, 'Sports'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'ProFit Yoga Mat');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'StrideX Running Shoes', 'Lightweight running shoes for jogging, gym sessions, and outdoor fitness.', 2499.00, 18, NULL, 'Sports'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'StrideX Running Shoes');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Fitness Dumbbell Set', 'Pair of dumbbells for home gym strength training and workouts.', 1299.00, 16, NULL, 'Sports'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Fitness Dumbbell Set');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Herbal Face Wash', 'Gentle face wash for fresh and clean everyday skin care.', 349.00, 30, NULL, 'Beauty & Care'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Herbal Face Wash');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Aloe Moisturizing Cream', 'Lightweight moisturizing cream for soft and healthy-looking skin.', 449.00, 28, NULL, 'Beauty & Care'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Aloe Moisturizing Cream');

INSERT INTO products (name, description, price, stock, image_url, category)
SELECT 'Daily Care Shampoo', 'Gentle shampoo for clean, fresh, and manageable hair.', 399.00, 24, NULL, 'Beauty & Care'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Daily Care Shampoo');
