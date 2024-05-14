with cte as (
SELECT *, ROW_NUMBER() OVER (
ORDER BY salary DESC) rowcount
FROM employees)

SELECT salary AS second_highest_salary
FROM cte
WHERE rowcount = 2