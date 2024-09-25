WITH cte AS (
    SELECT *, CAST('2023-01-01' AS DATE) AS CurrentDate
    FROM customers
)
SELECT Customer_id 
FROM cte
WHERE DATEDIFF(YEAR, birth_date, CurrentDate) -1  >= 55
ORDER BY customer_id 

OR

SELECT customer_id
FROM customers
WHERE DATEDIFF(YEAR, birth_date, '2023-01-01') - 1 >= 55
ORDER BY customer_id;
