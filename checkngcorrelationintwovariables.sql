WITH restaurant_metrics AS (
    SELECT 
        restaurant_id,
        AVG(order_total - discount_amount - refunded_amount) AS avg_net_order_total,
        AVG(DATEDIFF(MINUTE, placed_order_with_restaurant_datetime, delivered_to_consumer_datetime)) AS avg_delivery_time
    FROM delivery_details
    WHERE placed_order_with_restaurant_datetime IS NOT NULL 
        AND delivered_to_consumer_datetime IS NOT NULL
    GROUP BY restaurant_id
)

, stats AS (
    SELECT 
        COUNT(*) AS n,
        SUM(avg_net_order_total) AS sum_x,
        SUM(avg_delivery_time) AS sum_y,
        SUM(avg_net_order_total * avg_net_order_total) AS sum_x2,
        SUM(avg_delivery_time * avg_delivery_time) AS sum_y2,
        SUM(avg_net_order_total * avg_delivery_time) AS sum_xy
    FROM restaurant_metrics
)

SELECT 
    ROUND(
        (sum_xy - sum_x * sum_y / n) / 
        (SQRT(n * sum_x2 - sum_x * sum_x) * SQRT(n * sum_y2 - sum_y * sum_y)), 
        2
    ) AS correlation_value
FROM stats;
