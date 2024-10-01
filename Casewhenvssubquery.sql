WITH cte AS (
    SELECT 
        customer_id,
        transaction_id,
        amount,
        DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY transaction_id) AS RNK
    FROM Purchases
)

SELECT 
    customer_id,
    transaction_id,
    amount,
    CASE 
        WHEN RNK = 3 THEN amount * 0.67  -- Applying discount when RNK is 3
        ELSE amount  -- Keeping original amount when RNK is not 3
    END AS discounted_amount
FROM cte
WHERE RNK = 3  -- Filtering to only get rows where RNK is 3
ORDER BY customer_id ASC;


SELECT customer_id, transaction_id, amount, amount * 0.67 AS discounted_amount
FROM (
    SELECT customer_id, transaction_id, amount, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY transaction_id) AS rn
    FROM purchases
) t
WHERE rn = 3
ORDER BY customer_id ASC;