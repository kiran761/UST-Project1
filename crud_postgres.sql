-- Create database if it doesn't exist and set encoding
CREATE DATABASE IF NOT EXISTS postgres
    WITH 
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    CONNECTION LIMIT = -1;
\c postgres;

-- Drop table if exists for cleanup and compatibility
DROP TABLE IF EXISTS customer_postgres CASCADE;
DROP TABLE IF EXISTS order_postgres CASCADE;

-- Create customer_postgres table with different attributes
CREATE TABLE customer_postgres (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(20),
    registration_date DATE NOT NULL DEFAULT CURRENT_DATE,
    address VARCHAR(255)
);

-- Create order_postgres table with different attributes
CREATE TABLE order_postgres (
    order_id SERIAL PRIMARY KEY,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) DEFAULT 'pending',
    customer_id INT,
    shipping_address VARCHAR(255),
    CONSTRAINT fk_customer
        FOREIGN KEY (customer_id) 
        REFERENCES customer_postgres (customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Optional: Insert data or indexes as needed
