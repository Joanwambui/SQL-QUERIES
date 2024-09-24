CREATE TABLE employeej (
    employee_id INT PRIMARY KEY,
    position VARCHAR(255),
    managers_id INT
);

INSERT INTO employeej (employee_id, position, managers_id)
VALUES 
(1, 'Manager', NULL),  -- Manager without a manager (top-level)
(2, 'Manager', 1),     -- Manager who reports to Manager ID 1
(3, 'Employee', 2),    -- Employee who reports to Manager ID 2
(4, 'Employee', 2),    -- Another Employee who reports to Manager ID 2
(5, 'Employee', 1),    -- Employee who reports directly to Manager ID 1
(6, 'Manager', 1),     -- Another Manager reporting to Manager ID 1
(7, 'Employee', 6);    -- Employee who reports to Manager ID 6

SELECT *
FROM employeej

SELECT  *
from employeej

SELECT m.employee_id AS manager_id, m.position AS manager_position, COUNT(*) AS direct_reports
FROM employeej e
INNER JOIN employeej m ON e.managers_id = m.employee_id
WHERE m.position LIKE '%Manager%'
GROUP BY m.employee_id, m.position;
