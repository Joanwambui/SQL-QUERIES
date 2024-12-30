--Find all the users who were active for 3 consecutive days or more.
WITH cte AS (
    SELECT 
        user_id,
        LAG(date) OVER (PARTITION BY user_id ORDER BY date ASC) AS prev_date,
        date AS present_date,
        LEAD(date) OVER (PARTITION BY user_id ORDER BY date ASC) AS next_date
    FROM sf_events
)
SELECT DISTINCT user_id
FROM cte
WHERE 
    DATEDIFF(DAY, prev_date, present_date) = 1
    AND DATEDIFF(DAY, present_date, next_date) = 1;


