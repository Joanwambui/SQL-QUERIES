WITH TransactionData AS (
    SELECT
        transaction_id,
        merchant_id,
        credit_card_id,
        transaction_timestamp,
        amount,
        LAG(transaction_timestamp) OVER (PARTITION BY credit_card_id ORDER BY transaction_timestamp) AS previous_timestamp,
        LAG(amount) OVER (PARTITION BY credit_card_id ORDER BY transaction_timestamp) AS previous_amount,
        amount - LAG(amount) OVER (PARTITION BY credit_card_id ORDER BY transaction_timestamp) AS diff_amount,
        EXTRACT(EPOCH FROM (transaction_timestamp - LAG(transaction_timestamp) OVER (PARTITION BY credit_card_id ORDER BY transaction_timestamp))) / 60 AS datediff_minutes
    FROM
        transactions
)
SELECT 
    transaction_id, 
    amount, 
    diff_amount, 
    datediff_minutes
FROM 
    TransactionData
WHERE 
    diff_amount = 0 AND datediff_minutes <= 10;

'''
Sometimes, payment transactions are repeated by accident; it could be due to user error, API failure or a retry error that causes a credit card to be charged twice.

Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. Count such repeated payments.
'''