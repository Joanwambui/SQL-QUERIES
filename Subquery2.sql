

SELECT salesperson
FROM
  (SELECT salesperson,
          ROUND(AVG(sales_amount), 2) AS avg_sales,
          DENSE_RANK() OVER (ORDER BY ROUND(AVG(sales_amount), 2) DESC) AS rank
   FROM SalesData
   GROUP BY salesperson) AS ranked_sales
WHERE rank = 1;
