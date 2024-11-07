SELECT 
    post_date,
    SUM(CASE WHEN FP.post_keywords LIKE '%spam%' THEN 1 ELSE 0 END ) * 100 / COUNT(*)
FROM facebook_posts FP
INNER JOIN facebook_post_views FPV
ON FP.post_id = FPV.post_id
GROUP BY post_date