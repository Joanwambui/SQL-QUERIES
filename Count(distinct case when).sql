SELECT 
    PU.language, 
    COUNT(DISTINCT CASE WHEN device IN ('macbook pro', 'iphone 5s', 'ipad air') THEN PE.user_id END) AS Total_no_of_apple_users, 
    COUNT(DISTINCT PE.user_id) AS users_with_any_device
FROM playbook_events PE
JOIN playbook_users PU
ON PE.user_id = PU.user_id
GROUP BY PU.language
ORDER BY users_with_any_device DESC