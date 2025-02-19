with cte as (
SELECT DISTINCT s.user_id,s.session_date, o.order_value
FROM sessions s
JOIN order_summary o
ON s.user_id = o.user_id
WHERE s.session_date = o.order_date)

SELECT user_id,session_date,COUNT(order_value) AS total_number_of_orders,SUM(order_value) AS total_order_value
FROM cte
GROUP BY user_id,session_date



--Identify users who started a session and placed an order on the same day. For these users, calculate the total number of orders and the total order value for that day.
--Your output should include the user, the session date, the total number of orders, and the total order value for that day.
SELECT 
    o.user_id,
    CAST(o.order_date AS DATE) AS order_date,
    COUNT(o.order_id) AS total_orders,
    SUM(o.order_value) AS total_order_value
FROM 
    (SELECT DISTINCT user_id, CAST(session_date AS DATE) AS session_date FROM sessions) s
JOIN 
    order_summary o
ON 
    s.user_id = o.user_id
AND 
    s.session_date = CAST(o.order_date AS DATE)
GROUP BY 
    o.user_id, CAST(o.order_date AS DATE)
ORDER BY 
    o.user_id, CAST(o.order_date AS DATE);
