SELECT 
       EXTRACT(YEAR FROM transaction_date) AS year,
       product_id,
       spend AS current_year_spend,
       LAG(spend) OVER (PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend,
  ---     SUM(spend) OVER (PARTITION BY product_id, EXTRACT(YEAR FROM transaction_date)) AS sum_transaction_amount,
       ROUND(spend * 100.0 / LAG(spend) OVER (PARTITION BY product_id ORDER BY EXTRACT(YEAR FROM transaction_date)) - 100.0,2) AS yoy_rate
FROM user_transactions;
