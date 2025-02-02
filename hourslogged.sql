with cte as (
SELECT *, LEAD (timestamp) over (PARTITION BY cust_id ORDER BY timestamp) as lead_func
FROM cust_tracking
),

cte2 AS (
SELECT *
FROM cte
WHERE state = 1),

cte3 AS (
SELECT *, DATEDIFF(SECOND,timestamp,lead_func) / 3600.0 as diffinhours
FROM cte2)

SELECT cust_id,SUM(diffinhours) AS Hours
FROM cte3
GROUP BY cust_id

--Given the users' sessions logs on a particular day, calculate how many hours each user was active that day.
WITH session_durations AS (
    SELECT 
        t1.cust_id,
        CAST(DATEDIFF(SECOND, t1.timestamp, t2.timestamp) AS FLOAT) / 3600 AS active_hours
    FROM cust_tracking t1
    JOIN cust_tracking t2 
        ON t1.cust_id = t2.cust_id 
        AND t1.state = 1 
        AND t2.state = 0 
        AND t2.timestamp > t1.timestamp
    WHERE NOT EXISTS (
        SELECT 1 
        FROM cust_tracking t3
        WHERE t3.cust_id = t1.cust_id 
        AND t3.state = 0 
        AND t3.timestamp > t1.timestamp 
        AND t3.timestamp < t2.timestamp
    )
)
SELECT cust_id, ROUND(SUM(active_hours), 2) AS total_active_hours
FROM session_durations
GROUP BY cust_id;
