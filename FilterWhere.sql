with cte as (
SELECT 
  age.age_bucket, 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'send') AS send_sum, 
    SUM(activities.time_spent) FILTER (WHERE activities.activity_type = 'open') AS open_sum
FROM activities
INNER JOIN age_breakdown AS age 
  ON activities.user_id = age.user_id 
WHERE activities.activity_type IN ('send', 'open') 
GROUP BY age.age_bucket)

SELECT age_bucket, ROUND(send_sum/(send_sum+open_sum) * 100.0,2) AS send_perc, ROUND(open_sum/(send_sum+open_sum) * 100.0,2) AS open_perc 
FROM cte