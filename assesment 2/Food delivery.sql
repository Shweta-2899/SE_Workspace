CREATE DATABASE IF NOT EXISTS food_delivery;
USE food_delivery;

DROP VIEW IF EXISTS restaurant_sales_summary;
DROP TRIGGER IF EXISTS after_order_insert;
DROP PROCEDURE IF EXISTS add_order;

DROP TABLE IF EXISTS order_audit;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    cuisine_type VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    category VARCHAR(50) NOT NULL,
    CONSTRAINT fk_menu_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id),
    CONSTRAINT chk_menu_price CHECK (price > 0)
) ENGINE=InnoDB;

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    restaurant_id INT NOT NULL,
    item_id INT NOT NULL,
    quantity INT NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_order_restaurant
        FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id),
    CONSTRAINT fk_order_item
        FOREIGN KEY (item_id)
        REFERENCES menu_items(item_id),
    CONSTRAINT chk_quantity CHECK (quantity > 0),
    CONSTRAINT chk_total CHECK (total_amount >= 0)
) ENGINE=InnoDB;

CREATE TABLE order_audit (
    audit_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    action VARCHAR(20) NOT NULL DEFAULT 'INSERT',
    log_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
) ENGINE=InnoDB;

INSERT INTO restaurants (name, city, cuisine_type)
VALUES
('Spice Garden', 'Ahmedabad', 'Indian'),
('Pizza Palace', 'Surat', 'Italian'),
('Dragon Bowl', 'Vadodara', 'Chinese');

INSERT INTO menu_items
(restaurant_id, item_name, price, category)
VALUES
(1, 'Paneer Tikka', 220.00, 'Starter'),
(1, 'Veg Biryani', 180.00, 'Main Course'),
(1, 'Masala Dosa', 100.00, 'Breakfast'),
(1, 'Gulab Jamun', 70.00, 'Dessert'),
(1, 'Butter Naan', 40.00, 'Bread'),
(2, 'Margherita Pizza', 250.00, 'Main Course'),
(2, 'Farmhouse Pizza', 350.00, 'Main Course'),
(2, 'Garlic Bread', 120.00, 'Starter'),
(2, 'Chocolate Brownie', 100.00, 'Dessert'),
(2, 'Cold Coffee', 90.00, 'Beverage'),
(3, 'Veg Manchurian', 160.00, 'Starter'),
(3, 'Hakka Noodles', 190.00, 'Main Course'),
(3, 'Fried Rice', 170.00, 'Main Course'),
(3, 'Spring Rolls', 130.00, 'Starter'),
(3, 'Ice Cream', 80.00, 'Dessert');

INSERT INTO orders
(customer_name, restaurant_id, item_id, quantity, total_amount, order_date)
VALUES
('Aarav Patel', 1, 1, 2, 440.00, '2026-10-01 12:15:00'),
('Diya Shah', 1, 2, 1, 180.00, '2026-10-01 13:00:00'),
('Rohan Mehta', 1, 3, 2, 200.00, '2026-10-02 09:30:00'),
('Isha Desai', 1, 4, 3, 210.00, '2026-10-02 20:00:00'),
('Kabir Joshi', 1, 5, 4, 160.00, '2026-10-03 14:10:00'),
('Anaya Trivedi', 2, 6, 2, 500.00, '2026-10-03 19:00:00'),
('Vivaan Patel', 2, 7, 1, 350.00, '2026-10-04 19:30:00'),
('Sara Khan', 2, 8, 2, 240.00, '2026-10-04 17:45:00'),
('Reyansh Shah', 2, 9, 1, 100.00, '2026-10-05 21:00:00'),
('Myra Joshi', 2, 10, 2, 180.00, '2026-10-05 16:30:00'),
('Arjun Mehta', 3, 11, 2, 320.00, '2026-10-06 12:00:00'),
('Kiara Patel', 3, 12, 1, 190.00, '2026-10-06 13:15:00'),
('Advik Shah', 3, 13, 2, 340.00, '2026-10-07 14:00:00'),
('Saanvi Desai', 3, 14, 3, 390.00, '2026-10-07 18:00:00'),
('Dhruv Trivedi', 3, 15, 2, 160.00, '2026-10-08 20:30:00');

CREATE VIEW restaurant_sales_summary AS
SELECT
    r.name AS restaurant_name,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_revenue
FROM restaurants r
LEFT JOIN orders o
    ON r.restaurant_id = o.restaurant_id
GROUP BY r.restaurant_id, r.name;

DELIMITER //

CREATE PROCEDURE add_order(
    IN p_customer_name VARCHAR(100),
    IN p_restaurant_id INT,
    IN p_item_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_price DECIMAL(10,2);
    DECLARE v_total DECIMAL(10,2);
    DECLARE v_item_restaurant INT;
    DECLARE v_restaurant_count INT DEFAULT 0;
    DECLARE v_item_count INT DEFAULT 0;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SELECT COUNT(*)
    INTO v_restaurant_count
    FROM restaurants
    WHERE restaurant_id = p_restaurant_id;

    IF v_restaurant_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Restaurant does not exist';
    END IF;

    IF p_customer_name IS NULL
       OR TRIM(p_customer_name) = '' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer name is required';
    END IF;

    IF p_quantity IS NULL OR p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;

    SELECT COUNT(*)
    INTO v_item_count
    FROM menu_items
    WHERE item_id = p_item_id;

    IF v_item_count = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Menu item does not exist';
    END IF;

    SELECT price, restaurant_id
    INTO v_price, v_item_restaurant
    FROM menu_items
    WHERE item_id = p_item_id;

    IF v_item_restaurant <> p_restaurant_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT =
            'Menu item does not belong to this restaurant';
    END IF;

    SET v_total = v_price * p_quantity;

    INSERT INTO orders
    (customer_name, restaurant_id, item_id, quantity, total_amount, order_date)
    VALUES
    (p_customer_name, p_restaurant_id, p_item_id, p_quantity, v_total, NOW());

    COMMIT;
END //

CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    INSERT INTO order_audit
    (order_id, restaurant_id, action, log_time)
    VALUES
    (NEW.order_id, NEW.restaurant_id, 'INSERT', NOW());
END //

DELIMITER ;

SELECT
    o.order_id,
    o.customer_name,
    r.name AS restaurant_name,
    m.item_name,
    m.category,
    o.quantity,
    o.total_amount,
    o.order_date
FROM orders o
INNER JOIN restaurants r
    ON o.restaurant_id = r.restaurant_id
INNER JOIN menu_items m
    ON o.item_id = m.item_id
ORDER BY o.order_id;

SELECT * FROM restaurant_sales_summary;

CALL add_order('Neha Patel', 1, 2, 2);

SELECT * FROM order_audit;

SELECT
    m.category,
    SUM(o.total_amount) AS category_revenue
FROM orders o
INNER JOIN menu_items m
    ON o.item_id = m.item_id
GROUP BY m.category
ORDER BY category_revenue DESC;

SELECT SUM(total_amount) AS overall_revenue
FROM orders;
