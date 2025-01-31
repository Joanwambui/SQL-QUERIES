--Given the users' sessions logs on a particular day, calculate how many hours each user was active that day.

WITH session_data AS (
    SELECT 
        cust_id,
        timestamp AS session_start,
        LEAD(timestamp) OVER (PARTITION BY cust_id ORDER BY timestamp) AS session_end
    FROM cust_tracking
    WHERE state = 1
)

SELECT 
    cust_id,
    CAST(SUM(DATEDIFF(SECOND, session_start, session_end)) / 3600.0 AS DECIMAL(10,2)) AS active_hours
FROM session_data
WHERE session_end IS NOT NULL
GROUP BY cust_id
ORDER BY active_hours DESC;
