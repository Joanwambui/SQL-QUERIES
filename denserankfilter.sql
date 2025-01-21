SELECT *
FROM employee_data


Identify the second-highest salary in each department.

---Your output should include the department, the second highest salary, and the employee ID.
--Do not remove duplicate salaries when ordering salaries, and apply the rankings without a gap in the rank. For example, 
--if multiple employees share the same highest salary, the second-highest salary will be the next salary that is lower than the highest salaries.
with cte as (
SELECT
    department,
    salary,
    employee_id,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank
FROM
    employee_data)
SELECT     department,
    salary,
    employee_id
FROM cte 
WHERE rank = 2


