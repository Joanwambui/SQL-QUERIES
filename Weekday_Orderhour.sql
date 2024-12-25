Calculate the average net earnings per order grouped by weekday (in text format, e.g., Monday) and hour from customer_placed_order_datetime. 
The net earnings are computed as: order_total + tip_amount - discount_amount - refunded_amount. Round the result to 2 decimals.

SELECT 
    DATENAME(WEEKDAY, [customer_placed_order_datetime]) AS Weekday, 
    DATEPART(HOUR, [customer_placed_order_datetime]) AS OrderHour,
    ROUND(SUM(order_total + tip_amount - discount_amount - refunded_amount), 2) AS net_earnings
FROM 
    doordash_delivery_
WHERE 
    DATENAME(WEEKDAY, [customer_placed_order_datetime]) NOT IN ('Saturday', 'Sunday')
GROUP BY 
    DATENAME(WEEKDAY, [customer_placed_order_datetime]),
    DATEPART(HOUR, [customer_placed_order_datetime])
ORDER BY weekday, OrderHour


