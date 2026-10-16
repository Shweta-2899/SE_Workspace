-- Create and select database
CREATE DATABASE IF NOT EXISTS foodapp_db;
USE foodapp_db;

-- Drop existing objects to allow the script to run again
DROP VIEW IF EXISTS restaurant_menu_summary;
DROP TABLE IF EXISTS menu_items;
DROP TABLE IF EXISTS restaurants;

-- Create restaurants table
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50)
);

-- Create menu_items table with foreign key
CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    item_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    category VARCHAR(50),
    FOREIGN KEY (restaurant_id)
        REFERENCES restaurants(restaurant_id)
);

-- Insert 5 restaurants
INSERT INTO restaurants (name, city)
VALUES
('Spice Garden', 'Rajkot'),
('Pizza Palace', 'Ahmedabad'),
('Dragon House', 'Surat'),
('Burger Hub', 'Rajkot'),
('South Delight', 'Ahmedabad');

-- Insert 12 menu items
-- South Delight (restaurant_id 5) has no menu items
INSERT INTO menu_items
    (restaurant_id, item_name, price, category)
VALUES
(1, 'Paneer Tikka', 250.00, 'Starter'),
(1, 'Veg Biryani', 180.00, 'Main Course'),
(1, 'Dal Fry', 150.00, 'Main Course'),
(2, 'Margherita Pizza', 220.00, 'Pizza'),
(2, 'Farmhouse Pizza', 320.00, 'Pizza'),
(2, 'Garlic Bread', 120.00, 'Starter'),
(3, 'Veg Hakka Noodles', 190.00, 'Main Course'),
(3, 'Spring Rolls', 140.00, 'Starter'),
(3, 'Manchurian', 200.00, 'Main Course'),
(4, 'Veg Burger', 130.00, 'Burger'),
(4, 'French Fries', 100.00, 'Sides'),
(4, 'Cheese Burger', 180.00, 'Burger');

-- Query 1: INNER JOIN
-- Show restaurants that have menu items
SELECT
    r.name AS restaurant_name,
    m.item_name,
    m.price
FROM restaurants r
INNER JOIN menu_items m
    ON r.restaurant_id = m.restaurant_id;

-- Query 2: LEFT JOIN
-- Show all restaurants, including those without menu items
SELECT
    r.name AS restaurant_name,
    m.item_name,
    m.price,
    m.category
FROM restaurants r
LEFT JOIN menu_items m
    ON r.restaurant_id = m.restaurant_id;

-- Query 3: Create summary VIEW
CREATE VIEW restaurant_menu_summary AS
SELECT
    r.restaurant_id,
    r.name AS restaurant_name,
    COUNT(m.item_id) AS total_menu_items,
    AVG(m.price) AS average_item_price
FROM restaurants r
LEFT JOIN menu_items m
    ON r.restaurant_id = m.restaurant_id
GROUP BY r.restaurant_id, r.name;

-- Display the VIEW results
SELECT * FROM restaurant_menu_summary;