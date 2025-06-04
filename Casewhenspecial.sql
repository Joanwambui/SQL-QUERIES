WITH cte AS (
    SELECT COUNT(*) AS YTotal
    FROM customers
    WHERE has_member_card = 'Y'
),
    
cte2 AS (
    SELECT COUNT(*) AS Total
    FROM customers
)

    
SELECT (YTotal * 100.0 / Total) AS PercentageWithCard
FROM cte, cte2;


SELECT 
    ROUND(CAST(COUNT(CASE WHEN has_member_card = 'Y' THEN 1 END) AS DECIMAL) / COUNT(*) * 100, 2) AS Percentage_with_Membership
FROM customers
WHERE kroger_id IS NOT NULL;
