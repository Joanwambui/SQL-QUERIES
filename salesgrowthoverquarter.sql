--Write a query to return Territory and corresponding Sales Growth.
--Compare growth between periods Q4-2021 vs Q3-2021.
--If Territory (say T123) has Sales worth $100 in Q3-2021 and Sales worth $110 in Q4-2021,
--then the Sales Growth will be 10% [ i.e. = ((110 - 100)/100) * 100 ]

--Output the ID of the Territory and the Sales Growth. Only output these territories that had any sales in both quarters.

with cte as (
SELECT 
    f.cust_id,
    f.prod_sku_id,
    f.order_date,
    f.order_value,
    f.order_id,
	m.territory_id,
    CONCAT('Q', ((MONTH(f.order_date) - 1) / 3 + 1), ' ', YEAR(f.order_date)) AS order_quarter
FROM 
    fct_customer_sale f
JOIN map_customer_territories m
ON f.cust_id = m.cust_id
),

cte1 AS (

SELECT territory_id,order_quarter,SUM(order_value) as sales
FROM cte
WHERE order_quarter = 'Q3 2021'
GROUP BY territory_id,order_quarter
),

cte2 AS (
SELECT territory_id,order_quarter,SUM(order_value) as sales
FROM cte
WHERE order_quarter = 'Q4 2021'
GROUP BY territory_id,order_quarter
)

SELECT 
    a.territory_id,
    ((CAST(b.sales AS DECIMAL(10, 2)) - CAST(a.sales AS DECIMAL(10, 2))) / CAST(a.sales AS DECIMAL(10, 2))) * 100 AS sales_growth_percentage
FROM 
    cte1 a
JOIN 
    cte2 b ON a.territory_id = b.territory_id;

---Solution 2

WITH QuarterlySales AS (
    SELECT 
        mt.territory_id,
        DATEPART(QUARTER, fcs.order_date) AS quarter,
        DATEPART(YEAR, fcs.order_date) AS year,
        SUM(fcs.order_value) AS total_sales
    FROM 
        fct_customer_sale fcs
    JOIN 
        map_customer_territories mt ON fcs.cust_id = mt.cust_id
    WHERE 
        fcs.order_date BETWEEN '2021-07-01' AND '2021-12-31'
    GROUP BY 
        mt.territory_id, 
        DATEPART(QUARTER, fcs.order_date), 
        DATEPART(YEAR, fcs.order_date)
)

SELECT 
    q4.territory_id,
    (q4.total_sales - q3.total_sales) * 100.0 / q3.total_sales AS sales_growth_percentage
FROM 
    QuarterlySales q4
JOIN 
    QuarterlySales q3 
    ON q4.territory_id = q3.territory_id
    AND q4.year = 2021 AND q4.quarter = 4
    AND q3.year = 2021 AND q3.quarter = 3
WHERE 
    q3.total_sales > 0;

