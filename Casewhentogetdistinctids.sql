SELECT *
FROM employee_details

SELECT *
FROM bonus

;WITH cte AS (
    SELECT 
        e.id, 
        e.age, 
        e.salary, 
        b.bonus_amount, 
        b.bonus_date, 
        CASE 
            WHEN b.bonus_amount IS NOT NULL THEN 1 
            ELSE 0 
        END AS has_bonus
    FROM employee_details e
    FULL OUTER JOIN bonus b
    ON e.id = b.worker_ref_id
)
SELECT 
    COUNT(DISTINCT id) AS count_id, 
    has_bonus
FROM cte
GROUP BY has_bonus;





/*Find the number of employees who received the bonus and who didn't.
Bonus values in employee table are corrupted so you should use values from the bonus table.
Be aware of the fact that employee can receive more than one bonus. 
Output value inside has_bonus column (1 if they had bonus, 0 if not) along with the corresponding number of employees for each.*/
 
