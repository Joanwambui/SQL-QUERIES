IF OBJECT_ID('tempdb..#temp_prime') IS NOT NULL
BEGIN 
    DROP TABLE #temp_prime
END 
DECLARE @max INT = 1000
;WITH cte_prime_numbers AS
(
    SELECT 2 as num
    UNION ALL
    SELECT num + 1 FROM cte_prime_numbers WHERE num < @max
)
SELECT a.num into #temp_prime 
FROM cte_prime_numbers a
WHERE NOT EXISTS (
    SELECT 1
    FROM cte_prime_numbers b
    WHERE b.num < a.num AND a.num % b.num = 0
)
ORDER BY a.num
option (maxrecursion 1000)
select string_agg(num,'&') from #temp_prime
