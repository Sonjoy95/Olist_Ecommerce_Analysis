-- 1. Customers Table (Links unique IDs to specific order IDs)
CREATE TABLE customers (
    customer_id VARCHAR PRIMARY KEY,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix INT,
    customer_city VARCHAR,
    customer_state VARCHAR
);

-- 2. Orders Table (The heart of retention analysis)
CREATE TABLE orders (
    order_id VARCHAR PRIMARY KEY,
    customer_id VARCHAR REFERENCES customers(customer_id),
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

-- 3. Order Items (To calculate revenue/AOV later)
CREATE TABLE order_items (
    order_id VARCHAR REFERENCES orders(order_id),
    order_item_id INT,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date TIMESTAMP,
    price DECIMAL,
    freight_value DECIMAL,
    PRIMARY KEY (order_id, order_item_id)
);

-- 4. Payments (To see how people pay)
CREATE TABLE payments (
    order_id VARCHAR REFERENCES orders(order_id),
    payment_sequential INT,
    payment_type VARCHAR,
    payment_installments INT,
    payment_value DECIMAL
);
-- Data sanity check --
SELECT 
    c.customer_unique_id, 
    COUNT(o.order_id) as total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- Create a permanent table for cohort data
CREATE TABLE cohort_retention_results AS
WITH cohort_data AS (
    SELECT 
        c.customer_unique_id,
        MIN(o.order_purchase_timestamp) OVER(PARTITION BY c.customer_unique_id) AS first_purchase_date,
        o.order_purchase_timestamp
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
),
retention_index AS (
    SELECT 
        customer_unique_id,
        DATE_TRUNC('month', first_purchase_date) AS cohort_month,
        DATE_TRUNC('month', order_purchase_timestamp) AS order_month,
        (EXTRACT(YEAR FROM order_purchase_timestamp) - EXTRACT(YEAR FROM first_purchase_date)) * 12 +
        (EXTRACT(MONTH FROM order_purchase_timestamp) - EXTRACT(MONTH FROM first_purchase_date)) AS cohort_index
    FROM cohort_data
)
SELECT 
    cohort_month,
    cohort_index,
    COUNT(DISTINCT customer_unique_id) AS active_customers
FROM retention_index
GROUP BY 1, 2
ORDER BY 1, 2;