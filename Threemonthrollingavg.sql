SELECT year_month,
       AVG(sum_purchase_amt) OVER (ORDER BY year_month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS three_month_rolling_avg
FROM (
    SELECT FORMAT(created_at, 'yyyy-MM') AS year_month, SUM(purchase_amt) AS sum_purchase_amt
    FROM amazon_purchases
    WHERE purchase_amt >= 0
    GROUP BY FORMAT(created_at, 'yyyy-MM')
) AS subquery
ORDER BY year_month;
