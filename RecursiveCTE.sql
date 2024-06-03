-- Start by defining the recursive CTE
WITH cte (n) AS (
    SELECT 20
    UNION ALL
    SELECT n - 1 
    FROM cte 
    WHERE n > 1
)
-- Use the CTE to generate the desired pattern
SELECT REPLICATE('* ', n) AS Pattern 
FROM cte;
