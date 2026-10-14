-- E-commerce Sales & Customer Analysis using SQL
-- Database: SQLite
-- Dataset: Simulated e-commerce data

-- 1. Count total customers
SELECT COUNT(*) AS total_customers
FROM customers;

-- 2. Count total products
SELECT COUNT(*) AS total_products
FROM products;

-- 3. Count total orders
SELECT COUNT(*) AS total_orders
FROM orders;

-- 4. Count total order items
SELECT COUNT(*) AS total_order_items
FROM order_items;

-- 5. Calculate revenue from completed orders
SELECT
    SUM(oi.quantity * oi.unit_price) AS completed_revenue
FROM order_items AS oi
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed';

-- 6. Revenue by product
SELECT
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items AS oi
JOIN products AS p
    ON oi.product_id = p.product_id
JOIN orders AS o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'Completed'
GROUP BY p.product_id, p.product_name
ORDER BY total_revenue DESC;

-- 7. Order count by status
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- 8. Completed orders per customer
SELECT
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS completed_orders
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 'Completed'
GROUP BY c.customer_id, c.customer_name
ORDER BY completed_orders DESC, c.customer_name ASC;

-- 9. Top 5 customers by completed-order spending
SELECT
    c.customer_name,
    c.country,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'Completed'
GROUP BY
    c.customer_id,
    c.customer_name,
    c.country
ORDER BY total_spent DESC
LIMIT 5;