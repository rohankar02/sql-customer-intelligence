/* 
1. TOP CUSTOMERS 
Goal: Find the customers who have spent the most money.
*/
SELECT 
    customer_id, 
    COUNT(order_id) as total_orders,
    SUM(order_amount) as total_spent,
    AVG(order_amount) as average_order_value
FROM orders
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;


/* 
2. REVENUE SEGMENTATION (Tiering)
Goal: Put customers into Gold, Silver, and Bronze buckets based on spend.
*/
SELECT 
    customer_id,
    total_spent,
    CASE 
        WHEN total_spent > 5000 THEN 'Gold'
        WHEN total_spent > 2000 THEN 'Silver'
        ELSE 'Bronze'
    END as customer_tier
FROM (
    SELECT customer_id, SUM(order_amount) as total_spent
    FROM orders
    GROUP BY customer_id
) t
ORDER BY total_spent DESC;


/* 
3. REPEAT CUSTOMER BEHAVIOR
Goal: See how many days it takes for a customer to come back.
*/
WITH ordered_sales AS (
    SELECT 
        customer_id, 
        order_date,
        LAG(order_date) OVER (PARTITION BY customer_id ORDER BY order_date) as last_order_date
    FROM orders
)
SELECT 
    customer_id,
    AVG(JULIANDAY(order_date) - JULIANDAY(last_order_date)) as avg_days_between_orders
FROM ordered_sales
WHERE last_order_date IS NOT NULL
GROUP BY customer_id
ORDER BY avg_days_between_orders ASC;


/* 
4. RETENTION COHORTS (Monthly)
Goal: Tracking when customers first joined and if they returned.
*/
WITH first_orders AS (
    SELECT customer_id, MIN(STRFTIME('%Y-%m', order_date)) as cohort_month
    FROM orders
    GROUP BY customer_id
)
SELECT 
    f.cohort_month,
    STRFTIME('%Y-%m', o.order_date) as activity_month,
    COUNT(DISTINCT o.customer_id) as returning_customers
FROM first_orders f
JOIN orders o ON f.customer_id = o.customer_id
GROUP BY 1, 2
ORDER BY 1, 2;
