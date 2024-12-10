WITH cte AS (
    SELECT 
        friend_name,
        COUNT(resolution) AS resolution_count,
        COUNT(CASE WHEN is_completed = 1 THEN 1 END) AS resolutions_completed_count
    FROM resolutions
    GROUP BY friend_name
)
SELECT 
    friend_name, 
    resolution_count, 
    resolutions_completed_count, 
    CASE 
        WHEN (CAST(resolutions_completed_count AS FLOAT) / resolution_count) > 0.75 THEN 'Green'
        WHEN (CAST(resolutions_completed_count AS FLOAT) / resolution_count) BETWEEN 0.5 AND 0.75 THEN 'Yellow'
        ELSE 'Red'
    END AS completion_status
FROM cte;
