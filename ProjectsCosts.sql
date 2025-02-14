with cte as (
    select lp.title, lp.budget, sum(le.salary) as total_cost, DATEDIFF(day, start_date, end_date) as duration, ceiling(sum(le.salary) * ((DATEDIFF(day, start_date, end_date) * 1.0) / 365)) as prorated_employee_expense
    from linkedin_projects lp
    join linkedin_emp_projects lep on lp.id = lep.project_id
    join linkedin_employees le on le.id = lep.emp_id
    group by lp.title, lp.budget, start_date, end_date
)
    
select title, budget, prorated_employee_expense
from 
    
where prorated_employee_expense > budget
