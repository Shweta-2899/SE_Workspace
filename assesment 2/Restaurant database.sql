-- Create database
CREATE DATABASE IF NOT EXISTS foodapp_db;

-- Select database
USE foodapp_db;

-- Create restaurants table
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(50),
    cuisine_type VARCHAR(50),
    rating DECIMAL(3,1)
);

-- Insert restaurant records
INSERT INTO restaurants (name, city, cuisine_type, rating)
VALUES
('Spice Garden', 'Rajkot', 'Indian', 4.5),
('Pizza Palace', 'Ahmedabad', 'Italian', 4.2),
('Dragon House', 'Surat', 'Chinese', 3.9),
('Burger Hub', 'Rajkot', 'Fast Food', 4.0),
('South Delight', 'Ahmedabad', 'South Indian', 4.7),
('Tandoori Treat', 'Surat', 'North Indian', 4.3);

-- Update restaurant rating
UPDATE restaurants
SET rating = 4.4
WHERE name = 'Dragon House';

-- Delete one restaurant record
DELETE FROM restaurants
WHERE name = 'Burger Hub';

-- Display all restaurants in descending rating order
SELECT *
FROM restaurants
ORDER BY rating DESC;