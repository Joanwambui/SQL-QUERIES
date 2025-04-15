

SELECT salesperson
FROM
  (SELECT salesperson,
          ROUND(AVG(sales_amount), 2) AS avg_sales,
          DENSE_RANK() OVER (ORDER BY ROUND(AVG(sales_amount), 2) DESC) AS rank
   FROM SalesData
   GROUP BY salesperson) AS ranked_sales
WHERE rank = 1;


SELECT 
    d.company_name,
    AVG(employee_total_cost) AS avg_cost_per_employee
FROM (
    SELECT 
        f.company_id,
        f.employee_id,
        SUM(f.booking_cost) AS employee_total_cost
    FROM fct_corporate_bookings f
    WHERE strftime('%Y-%m', f.travel_date) BETWEEN '2024-01' AND '2024-03'
    GROUP BY f.company_id, f.employee_id
) employee_costs
JOIN dim_companies d 
  ON d.company_id = employee_costs.company_id
GROUP BY d.company_name
ORDER BY avg_cost_per_employee DESC
LIMIT 5;
