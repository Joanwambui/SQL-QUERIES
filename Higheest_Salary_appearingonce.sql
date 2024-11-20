CREATE TABLE employee2(id INT,first_name VARCHAR(50),last_name VARCHAR(50),age INT,sex VARCHAR(1),employee_title VARCHAR(50),department VARCHAR(50),salary INT,target INT,bonus INT,email VARCHAR(100),city VARCHAR(50),address VARCHAR(100),manager_id INT);

INSERT INTO employee2 (id, first_name, last_name, age, sex, employee_title, department, salary, target, bonus, email, city, address, 
manager_id)VALUES(5, 'Max', 'George', 26, 'M', 'Sales', 'Sales', 1300, 200, 150, 'Max@company.com', 'California', '2638 Richards Avenue', 1),
(13, 'Katty', 'Bond', 56, 'F', 'Manager', 'Management', 150000, 0, 300, 'Katty@company.com', 'Arizona', NULL, 1),
(11, 'Richerd', 'Gear', 57, 'M', 'Manager', 'Management', 250000, 0, 300, 'Richerd@company.com', 'Alabama', NULL, 1),
(10, 'Jennifer', 'Dion', 34, 'F', 'Sales', 'Sales', 1000, 200, 150, 'Jennifer@company.com', 'Alabama', NULL, 13),
(19, 'George', 'Joe', 50, 'M', 'Manager', 'Management', 250000, 0, 300, 'George@company.com', 'Florida', '1003 Wyatt Street', 1),
(18, 'Laila', 'Mark', 26, 'F', 'Sales', 'Sales', 1000, 200, 150, 'Laila@company.com', 'Florida', '3655 Spirit Drive', 11),
(20, 'Sarrah', 'Bicky', 31, 'F', 'Senior Sales', 'Sales', 2000, 200, 150, 'Sarrah@company.com', 'Florida', '1176 Tyler Avenue', 19);

SELECT *
FROM employee2

--Find the highest salary among salaries that appears only once.
SELECT 
    id, 
    salary, 
    IsUnique
FROM (
    SELECT 
        id, 
        salary, 
        CASE 
            WHEN COUNT(salary) OVER (PARTITION BY salary) = 1 THEN 1
            ELSE 0
        END AS IsUnique
    FROM 
        employee2
) AS Subquery
WHERE IsUnique = 1
ORDER BY salary DESC;


with cte as (
SELECT salary, COUNT(*) as salary_count
FROM employee2
GROUP BY salary)

SELECT MAX(salary) AS Max_Salary
FROM cte
WHERE salary_count = 1

