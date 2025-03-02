SELECT 
    E.id AS employee_id, 
    E.department,
    E.salary AS employee_salary, 
    M.id AS manager_id, 
    M.salary AS manager_salary,
    AVG(E.salary) OVER (PARTITION BY E.department) AS department_avg_salary
FROM employee_o E
LEFT JOIN employee_o M
ON e.manager_id = m.id AND e.id != e.manager_id
ORDER BY employee_id

--Write a query that compares each employee's salary to their manager's and the average department salary (excluding the manager's salary).
--Display the department, employee ID,
--employee's salary, manager's salary, and department average salary. Order by department, then by employee salary (highest to lowest).