-- Create and select database
CREATE DATABASE IF NOT EXISTS foodapp_db;
USE foodapp_db;

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_date DATETIME NOT NULL
);

-- Insert 12 sample orders across 4 restaurants
INSERT INTO orders
    (restaurant_id, customer_name, total_amount, order_date)
VALUES
    (1, 'Aarav Patel', 1200.00, '2026-10-10 10:30:00'),
    (2, 'Diya Shah', 2500.00, '2026-10-11 12:15:00'),
    (3, 'Rohan Mehta', 1800.00, '2026-10-12 13:00:00'),
    (4, 'Anaya Joshi', 3200.00, '2026-10-13 14:20:00'),
    (1, 'Vivaan Desai', 2200.00, '2026-10-14 09:45:00'),
    (2, 'Ishita Patel', 3000.00, '2026-10-14 11:30:00'),
    (3, 'Arjun Shah', 2700.00, '2026-10-14 15:00:00'),
    (4, 'Sara Mehta', 2100.00, '2026-10-14 16:45:00'),
    (1, 'Krish Joshi', 1900.00, '2026-10-15 08:30:00'),
    (2, 'Myra Desai', 1800.00, '2026-10-15 09:15:00'),
    (3, 'Reyansh Patel', 2400.00, '2026-10-15 10:00:00'),
    (4, 'Kiara Shah', 2800.00, '2026-10-15 10:45:00');

-- Query 1: Total revenue and average order value per restaurant
SELECT
    restaurant_id,
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_order_value
FROM orders
GROUP BY restaurant_id;

-- Query 2: Restaurants with total revenue exceeding Rs 5,000
SELECT
    restaurant_id,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY restaurant_id
HAVING SUM(total_amount) > 5000;

-- Query 3: Retrieve the 5 most recent orders
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 5;