WITH user_activity AS (
    SELECT 
        user_id,
        date,
        LAG(date) OVER (PARTITION BY user_id ORDER BY date ASC) AS previous_date,
        DATEDIFF(day, LAG(date) OVER (PARTITION BY user_id ORDER BY date ASC), date) AS date_diff
    FROM sf_events
),
consecutive_days AS (
    SELECT 
        user_id,
        date,
        CASE 
            WHEN date_diff = 1 THEN 1 ELSE 0 
        END AS is_consecutive
    FROM user_activity
),
streaks AS (
    SELECT 
        user_id,
        date,
        SUM(is_consecutive) OVER (PARTITION BY user_id ORDER BY date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS consecutive_days
    FROM consecutive_days
)
SELECT DISTINCT user_id
FROM streaks
WHERE consecutive_days = 3
ORDER BY user_id;


--Find all the users who were active for 3 consecutive days or more.
