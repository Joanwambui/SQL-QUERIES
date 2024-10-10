WITH transaction_leads AS (
    SELECT 
        user_id, 
        created_at, 
        LEAD(created_at) OVER (PARTITION BY user_id ORDER BY created_at DESC) AS next_created_at, 
        LEAD(user_id) OVER (PARTITION BY user_id ORDER BY created_at DESC) AS next_user_id
    FROM amazon_transactions
),
userl AS (
SELECT 
    user_id, 
    created_at, 
    next_created_at, 
    next_user_id, 
    DATEDIFF(day,  next_created_at, created_at) AS days_diff
FROM 
    transaction_leads
WHERE 
    next_created_at IS NOT NULL 
    AND DATEDIFF(day,  next_created_at, created_at) <= 7)
    
SELECT DISTINCT(user_id)
FROM userl

