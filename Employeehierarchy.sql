SELECT *
FROM employee_detail

WITH cte AS (
SELECT a.first_name, b.first_name AS manager_name, a.salary AS Employee_salary, b.salary AS Manager_salary
FROM employee_detail a
INNER JOIN employee_detail b
ON a.manager_id = b.id)

SELECT first_name, Employee_salary
FROM cte
WHERE Employee_salary > Manager_salary
