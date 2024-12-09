WITH cte AS (
    SELECT 
        M.dish_name,
        E.event_name,
        ROUND(CAST(M.calories AS FLOAT) / CAST(M.weight_g AS FLOAT), 2) AS calculated_calorie_density,
        RANK() OVER (PARTITION BY M.event_id ORDER BY M.calories DESC) AS rankposition
    FROM 
        menu M
    INNER JOIN 
        events E
    ON 
        M.event_id = E.event_id
)
SELECT 
    dish_name, 
    event_name, 
    calculated_calorie_density
FROM 
    cte
WHERE 
   rankposition <= 3;
