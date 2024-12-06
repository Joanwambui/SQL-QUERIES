SELECT 
    T.bear_id,
    P.bear_name, 
    SUM(T.distance_km) AS total_distance_traveled
FROM 
    tracking T
INNER JOIN 
    polar_bears P
ON 
    T.bear_id = P.bear_id
WHERE 
    strftime('%m', T.date) = '12' -- Filter for December
    AND strftime('%Y', T.date) = '2024' -- Filter for the year 2024
GROUP BY 
    T.bear_id, P.bear_name
ORDER BY 
    total_distance_traveled DESC
LIMIT 3; -- Get the top 3 results
