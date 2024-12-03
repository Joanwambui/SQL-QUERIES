WITH ranked_salary AS (
  SELECT 
    name,
    salary,
    department_id,
    DENSE_RANK() OVER (
      PARTITION BY department_id ORDER BY salary DESC) AS ranking
  FROM employee
)

SELECT 
  d.department_name,
  rs.name,
  rs.salary
FROM ranked_salary AS rs
INNER JOIN department AS d
  ON rs.department_id = d.department_id
WHERE rs.ranking <= 3
ORDER BY d.department_id, rs.salary DESC, rs.name ASC;

#Normal rank grouped by category
SELECT candy_name, candy_category, calories, RANK() OVER (PARTITION BY candy_category ORDER BY calories DESC) AS rank_in_category
FROM candy_nutrition
