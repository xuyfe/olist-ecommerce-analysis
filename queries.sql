-- complete table of delivered orders
CREATE OR REPLACE VIEW sale_per_customer AS (
SELECT 
	c.customer_id,
	o.order_id,
	p.product_id,
	s.seller_id,
	r.review_id,
	r.review_score,
	s.seller_zip_code_prefix,
	s.seller_city,
	s.seller_state,
	c.customer_zip_code_prefix,
	c.customer_city,
	c.customer_state,
	c.customer_region,
	pc.product_category_name_english,
	pc.product_category,
	op.payment_type,
	op.payment_installments,
	ot.price,
	ot.freight_value,
	op.payment_value AS sales_value,
	(DATE(o.order_delivered_customer_date) - DATE(o.order_purchase_timestamp)) AS delivery_days,
	(DATE(o.order_delivered_customer_date) - DATE(o.order_estimated_delivery_date)) AS delayed_days
FROM customers c
	INNER JOIN orders o ON c.customer_id = o.customer_id
	LEFT JOIN order_reviews r ON r.order_id = o.order_id
	INNER JOIN order_payments op ON op.order_id = o.order_id
	INNER JOIN order_items ot ON o.order_id = ot.order_id
	INNER JOIN sellers s ON s.seller_id = ot.seller_id
	INNER JOIN products p ON ot.product_id = p.product_id
	INNER JOIN product_categories pc ON p.product_category_name = pc.product_category_name
WHERE o.order_status = 'delivered'
GROUP BY 
	c.customer_id, 
	o.order_id, 
	p.product_id, 
	s.seller_id,
	r.review_id,
	ot.price, 
	ot.freight_value, 
	op.payment_value,
	op.payment_type,
	op.payment_installments,
	pc.product_category_name_english, 
	pc.product_category,
	o.order_delivered_customer_date,
	o.order_purchase_timestamp,
	o.order_estimated_delivery_date
);

------------------------------------------------------------
--------------- Customers and Orders -----------------------
------------------------------------------------------------

-- calculate total number of customers with orders over time
-- CREATE OR REPLACE VIEW num_cust_over_time AS 
(SELECT
	COUNT(DISTINCT(c.customer_id)) as num_customers,
	DATE(o.order_purchase_timestamp) as date
FROM customers c
	INNER JOIN orders o ON c.customer_id = o.customer_id
GROUP BY date
ORDER BY date);

-- calculate the total number of delivered orders over time
-- CREATE OR REPLACE VIEW num_order_over_time AS 
(SELECT
	COUNT(DISTINCT(order_id)) as num_orders,
	DATE(order_purchase_timestamp) as date
FROM orders
WHERE order_status = 'delivered'
GROUP BY date
ORDER BY date);

-- calculate the total number of canceled orders over time
-- CREATE OR REPLACE VIEW num_cancel_over_time AS 
(SELECT
	COUNT(DISTINCT(order_id)) as num_orders,
	DATE(order_purchase_timestamp) as date
FROM orders
WHERE order_status = 'canceled'
GROUP BY date
ORDER BY date);

------------------------------------------------------------
-------------------------- Sales ---------------------------
------------------------------------------------------------

-- identify top 10 cities with highest average sales value and number of orders
SELECT 
	customer_city,
	COUNT(order_id) as num_orders,
	ROUND(AVG(sales_value), 2) as avg_sales_value
FROM sale_per_customer
GROUP BY customer_city
ORDER BY num_orders DESC
LIMIT 10;
-- the cities with the highest number of orders
-- also had very low average sales values


SELECT 
	customer_city,
	COUNT(order_id) as num_orders,
	ROUND(AVG(sales_value), 2) as avg_sales_value
FROM sale_per_customer
GROUP BY customer_city
ORDER BY avg_sales_value DESC
LIMIT 10;
-- the cities with the highest sales value
-- interestingly had very low number of orders
-- (between 1 and 2)


-- identify top 10 states with highest average sales value and number of orders
SELECT 
	customer_state,
	COUNT(order_id) as num_orders,
	ROUND(AVG(sales_value), 2) as avg_sales_value
FROM sale_per_customer
GROUP BY customer_state
ORDER BY num_orders DESC
LIMIT 10;
-- similarly to the cities, the states
-- with the highest number of orders
-- also had very low average sales value 
-- per customer (rarely exceeding 150)


SELECT 
	customer_state,
	COUNT(order_id) as num_orders,
	ROUND(AVG(sales_value), 2) as avg_sales_value
FROM sale_per_customer
GROUP BY customer_state
ORDER BY avg_sales_value DESC
LIMIT 10;
-- similary, the states with the highest average
-- sales value per customer also had comparably low
-- total number of orders (rarely exceeding 1000)

-- calculate average sales by category
-- CREATE OR REPLACE VIEW sales_per_cat AS
(SELECT
	product_category,
	COUNT(order_id) as num_orders,
	ROUND(AVG(price), 2) as avg_price,
	ROUND(AVG(freight_value), 2) as avg_freight_value,
	ROUND(AVG(sales_value), 2) AS avg_sales_value
FROM sale_per_customer
GROUP BY product_category
ORDER BY avg_sales_value DESC
);


-- avg sales value by payment type
SELECT 
	payment_type,
	COUNT(order_id) as num_orders, 
	ROUND(AVG(sales_value), 2) as avg_sales_value
FROM sale_per_customer
GROUP BY payment_type
ORDER BY avg_sales_value DESC;
-- over 70% of orders were payed with a credit card,
-- and sales by credit card also had an average sales value
-- over 10% higher than sales by boleto.

-- relationship between freight value on delivery time and sales value
-- CREATE OR REPLACE VIEW freight_delivery_sales AS 
(SELECT
	customer_state,
	customer_region,
	ROUND(AVG(price), 2) as avg_price,
	ROUND(AVG(freight_value), 2) as avg_freight_value,
	ROUND(AVG(sales_value), 2) as avg_sales_value,
	ROUND(AVG(delivery_days), 2) as avg_delivery_days,
	ROUND(AVG(delayed_days), 2) as avg_delayed_days
FROM sale_per_customer
GROUP BY 
	customer_state,
	customer_region
);


-- investigate what product categories are most popular per state
SELECT
	customer_state,
	product_category,
	COUNT(product_category) as num_orders
FROM sale_per_customer
GROUP BY customer_state, product_category
ORDER BY customer_state, num_orders DESC;
-- electronic products are the most popular
-- for the majority of states

------------------------------------------------------------
----------------------- Payments ---------------------------
------------------------------------------------------------

-- credit installments by state
SELECT
	customer_state,
	ROUND(AVG(payment_installments), 2) as avg_credit_installments
FROM sale_per_customer
WHERE
	payment_type = 'credit_card'
GROUP BY 
	customer_state
ORDER BY avg_credit_installments DESC
LIMIT 10;


-- credit installments by category and region
SELECT
	customer_region,
	ROUND(AVG(payment_installments), 2) as avg_credit_installments
FROM sale_per_customer
WHERE
	payment_type = 'credit_card'
GROUP BY 
	customer_region
ORDER BY avg_credit_installments DESC;


-- credit installments by category
SELECT
	product_category,
	ROUND(AVG(payment_installments), 2) as avg_credit_installments
FROM sale_per_customer
WHERE
	payment_type = 'credit_card'
GROUP BY 
	product_category
ORDER BY avg_credit_installments DESC;


------------------------------------------------------------
------------------------- Reviews --------------------------
------------------------------------------------------------

-- average ratings by category
SELECT
	product_category,
	ROUND(AVG(review_score), 2) as avg_rating
FROM sale_per_customer
GROUP BY product_category
ORDER BY avg_rating DESC;
-- all categories seem to have similar average ratings,
-- at around 4/5


------------------------------------------------------------
----------------------- Shippings --------------------------
------------------------------------------------------------
SELECT
	product_category,
	ROUND(AVG(delayed_days), 2) as avg_delayed_days
FROM sale_per_customer
GROUP BY product_category
ORDER BY avg_delayed_days ASC;
-- all product categories have negative delays, meaning
-- orders are delivered earlier than estimated. However,
-- fashion products seem to be delivered the fastest.

SELECT
	customer_state,
	customer_region,
	ROUND(AVG(delayed_days), 2) as avg_delayed_days
FROM sale_per_customer
GROUP BY customer_state, customer_region
ORDER BY avg_delayed_days ASC;
-- the state AC in the Northern region has the fastest deliveries
-- (most negative delayed days), while the AL state in the Northeast
-- has the slowest deliveries. Nevertheless, all states and regions have
-- negative average delayments, so most orders arrive before expected.

