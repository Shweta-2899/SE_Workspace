-- Create and select database
CREATE DATABASE IF NOT EXISTS foodapp_db;
USE foodapp_db;

-- Remove previous procedure and tables for a clean test
DROP PROCEDURE IF EXISTS place_order;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- Create customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    wallet_balance DECIMAL(10,2) NOT NULL
) ENGINE=InnoDB;

-- Create orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    restaurant_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
) ENGINE=InnoDB;

-- Insert sample customers
INSERT INTO customers (customer_name, wallet_balance)
VALUES
('Aarav Patel', 5000.00),
('Diya Shah', 2000.00),
('Rohan Mehta', 1000.00);

-- Create stored procedure
DELIMITER //

CREATE PROCEDURE place_order(
    IN p_customer_id INT,
    IN p_restaurant_id INT,
    IN p_amount DECIMAL(10,2)
)
BEGIN
    DECLARE v_wallet_balance DECIMAL(10,2) DEFAULT NULL;

    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_wallet_balance = NULL;

    START TRANSACTION;

    -- Lock customer wallet while processing the order
    SELECT wallet_balance
    INTO v_wallet_balance
    FROM customers
    WHERE customer_id = p_customer_id
    FOR UPDATE;

    -- Check customer, amount, and wallet balance
    IF v_wallet_balance IS NULL OR p_amount <= 0 THEN

        ROLLBACK;

        SELECT 'Order failed: invalid customer or amount'
            AS result;

    ELSEIF v_wallet_balance < p_amount THEN

        ROLLBACK;

        SELECT 'Order failed: insufficient wallet balance'
            AS result;

    ELSE

        -- Deduct amount from customer wallet
        UPDATE customers
        SET wallet_balance = wallet_balance - p_amount
        WHERE customer_id = p_customer_id;

        -- Insert order record
        INSERT INTO orders
            (customer_id, restaurant_id, amount)
        VALUES
            (p_customer_id, p_restaurant_id, p_amount);

        -- Save both changes
        COMMIT;

        SELECT 'Order placed successfully'
            AS result;

    END IF;
END //

DELIMITER ;

-- TEST 1: Valid order
-- Customer 1 has Rs. 5000; order amount is Rs. 1200
CALL place_order(1, 1, 1200.00);

-- Check wallet balance after successful order
SELECT * FROM customers WHERE customer_id = 1;

-- Check inserted order
SELECT * FROM orders;

-- TEST 2: Insufficient wallet balance
-- Customer 1 now has Rs. 3800; order amount is Rs. 6000
CALL place_order(1, 2, 6000.00);

-- Verify wallet remains unchanged after rollback
SELECT * FROM customers WHERE customer_id = 1;

-- Verify failed order was not inserted
SELECT * FROM orders;

-- Final verification of all customers and orders
SELECT * FROM customers;
SELECT * FROM orders;