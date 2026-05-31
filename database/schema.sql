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

SET @sql = (
    SELECT IF(
        COUNT(*) = 0,
        'CREATE INDEX idx_products_category ON products (category)',
        'DO 0'
    )
    FROM information_schema.statistics
    WHERE table_schema = @schema_name
      AND table_name = 'products'
      AND index_name = 'idx_products_category'
);
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql = (
    SELECT IF(
        COUNT(*) = 0,
        'CREATE INDEX idx_products_price_stock ON products (price, stock)',
        'DO 0'
    )
    FROM information_schema.statistics
    WHERE table_schema = @schema_name
      AND table_name = 'products'
      AND index_name = 'idx_products_price_stock'
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

UPDATE products SET category = 'Electronics' WHERE name = 'USB-C Charger';

UPDATE products SET category = 'Electronics' WHERE name IN ('Wireless Headphones', 'Smart Watch', 'Bluetooth Speaker', 'Wireless Earbuds Pro', 'USB-C Fast Charger', 'Mechanical Keyboard', 'HD Webcam', 'USB-C Charger');
UPDATE products SET category = 'Fashion' WHERE name IN ('Laptop Backpack', 'Cotton Casual Shirt', 'Classic Denim Jeans', 'Slim Leather Wallet', 'Urban Sneakers', 'Analog Wrist Watch');
UPDATE products SET category = 'Home & Living' WHERE name IN ('Ceramic Coffee Mug', 'Desk Table Lamp', 'Soft Cushion Pillow', 'Cotton Bed Sheet Set', 'Nonstick Fry Pan', 'Storage Basket Set');
UPDATE products SET category = 'Sports' WHERE name IN ('ProFit Yoga Mat', 'StrideX Running Shoes', 'Fitness Dumbbell Set', 'Steel Water Bottle', 'Resistance Band Kit');
UPDATE products SET category = 'Beauty & Care' WHERE name IN ('Herbal Face Wash', 'Aloe Moisturizing Cream', 'Daily Care Shampoo', 'Vitamin C Sunscreen', 'Fresh Eau de Parfum');
UPDATE products SET category = 'Grocery' WHERE name IN ('Organic Green Tea', 'Pure Honey Jar', 'Roasted Almond Pack');
UPDATE products SET category = 'Books & Stationery' WHERE name IN ('Premium Notebook', 'Gel Pen Set', 'Desk Organizer');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Wireless Headphones', 'Bluetooth headphones with long battery life.', 2499.00, 25, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Wireless Headphones');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Smart Watch', 'Fitness tracking and mobile notifications.', 3999.00, 18, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Smart Watch');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Bluetooth Speaker', 'Portable wireless speaker with clear sound for daily music and calls.', 1599.00, 20, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Bluetooth Speaker');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Laptop Backpack', 'Water-resistant backpack with laptop storage.', 1299.00, 40, 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Laptop Backpack');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Cotton Casual Shirt', 'Comfortable everyday shirt for a clean casual look.', 799.00, 35, 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Cotton Casual Shirt');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Classic Denim Jeans', 'Durable denim jeans with a comfortable everyday fit.', 1499.00, 22, 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Classic Denim Jeans');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Ceramic Coffee Mug', 'Durable ceramic mug for tea, coffee, and daily use.', 299.00, 50, 'Home & Living'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Ceramic Coffee Mug');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Desk Table Lamp', 'Compact table lamp for study, work desk, and bedroom lighting.', 699.00, 26, 'Home & Living'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Desk Table Lamp');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Soft Cushion Pillow', 'Soft cushion pillow for sofa, bed, and home comfort.', 499.00, 32, 'Home & Living'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Soft Cushion Pillow');

INSERT INTO products (name, description, price, stock, category)
SELECT 'ProFit Yoga Mat', 'Non-slip sports yoga mat for home workouts and fitness training.', 899.00, 25, 'Sports'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'ProFit Yoga Mat');

INSERT INTO products (name, description, price, stock, category)
SELECT 'StrideX Running Shoes', 'Lightweight running shoes for jogging, gym sessions, and outdoor fitness.', 2499.00, 18, 'Sports'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'StrideX Running Shoes');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Fitness Dumbbell Set', 'Pair of dumbbells for home gym strength training and workouts.', 1299.00, 16, 'Sports'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Fitness Dumbbell Set');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Herbal Face Wash', 'Gentle face wash for fresh and clean everyday skin care.', 349.00, 30, 'Beauty & Care'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Herbal Face Wash');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Aloe Moisturizing Cream', 'Lightweight moisturizing cream for soft and healthy-looking skin.', 449.00, 28, 'Beauty & Care'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Aloe Moisturizing Cream');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Daily Care Shampoo', 'Gentle shampoo for clean, fresh, and manageable hair.', 399.00, 24, 'Beauty & Care'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Daily Care Shampoo');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Wireless Earbuds Pro', 'Compact earbuds with crisp audio, touch controls, and pocket charging case.', 2199.00, 34, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Wireless Earbuds Pro');

INSERT INTO products (name, description, price, stock, category)
SELECT 'USB-C Fast Charger', 'Dual-port fast charger for phones, tablets, and everyday travel.', 899.00, 45, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'USB-C Fast Charger');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Mechanical Keyboard', 'Tactile keyboard with RGB lighting for work, gaming, and study desks.', 3499.00, 14, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Mechanical Keyboard');

INSERT INTO products (name, description, price, stock, category)
SELECT 'HD Webcam', 'Sharp webcam for video classes, meetings, and creator desks.', 1799.00, 0, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'HD Webcam');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Slim Leather Wallet', 'Premium slim wallet with clean stitching and everyday card storage.', 699.00, 38, 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Slim Leather Wallet');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Urban Sneakers', 'Comfortable sneakers for daily outfits, walking, and casual weekends.', 1899.00, 21, 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Urban Sneakers');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Analog Wrist Watch', 'Minimal analog watch with a clean dial and comfortable strap.', 1599.00, 19, 'Fashion'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Analog Wrist Watch');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Cotton Bed Sheet Set', 'Soft cotton bedsheet set with pillow covers for everyday comfort.', 1199.00, 27, 'Home & Living'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Cotton Bed Sheet Set');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Nonstick Fry Pan', 'Durable nonstick fry pan for quick breakfasts and daily cooking.', 999.00, 23, 'Home & Living'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Nonstick Fry Pan');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Storage Basket Set', 'Woven storage baskets for shelves, wardrobes, and tidy rooms.', 749.00, 31, 'Home & Living'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Storage Basket Set');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Steel Water Bottle', 'Insulated bottle that keeps drinks cool during workouts and travel.', 649.00, 42, 'Sports'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Steel Water Bottle');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Resistance Band Kit', 'Portable resistance bands for stretching, mobility, and strength training.', 799.00, 20, 'Sports'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Resistance Band Kit');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Vitamin C Sunscreen', 'Light sunscreen for daily outdoor protection and a smooth skin feel.', 599.00, 26, 'Beauty & Care'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Vitamin C Sunscreen');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Fresh Eau de Parfum', 'Everyday fragrance with fresh notes for office and evening wear.', 1299.00, 17, 'Beauty & Care'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Fresh Eau de Parfum');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Organic Green Tea', 'Refreshing green tea packs for calm mornings and light evenings.', 299.00, 60, 'Grocery'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Organic Green Tea');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Pure Honey Jar', 'Natural honey jar for breakfast bowls, tea, and home recipes.', 499.00, 36, 'Grocery'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Pure Honey Jar');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Roasted Almond Pack', 'Crunchy roasted almonds for snacking, gifting, and pantry storage.', 549.00, 33, 'Grocery'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Roasted Almond Pack');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Premium Notebook', 'Hardcover ruled notebook for class notes, planning, and journaling.', 249.00, 55, 'Books & Stationery'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Premium Notebook');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Gel Pen Set', 'Smooth gel pen set for writing, sketching, and office work.', 199.00, 70, 'Books & Stationery'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Gel Pen Set');

INSERT INTO products (name, description, price, stock, category)
SELECT 'Desk Organizer', 'Compact organizer for pens, notes, cables, and study desk essentials.', 449.00, 28, 'Books & Stationery'
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Desk Organizer');





