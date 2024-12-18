

WITH cte AS (
    SELECT 
        DATENAME(WEEKDAY, customer_placed_order_datetime) AS order_weekday, -- Extract weekday
        DATEPART(HOUR, customer_placed_order_datetime) AS order_hour,      -- Extract hour
        (order_total + tip_amount - discount_amount - refunded_amount) AS net_earnings
    FROM 
        doordash_delivery
)
SELECT 
    order_weekday AS weekday, 
    order_hour, 
    AVG(net_earnings) AS avg_net_earnings -- Calculate average after grouping
FROM 
    cte
GROUP BY 
    order_weekday, 
    order_hour
ORDER BY 
    order_weekday, 
    order_hour;
