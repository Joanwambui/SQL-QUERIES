---salary multiplesof10000
SELECT *
FROM employees 
WHERE salary % 10000 = 0