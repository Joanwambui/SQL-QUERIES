SELECT first_name
FROM users
WHERE user_id IN (
    SELECT user_id
    FROM user_time
    WHERE media_time_minutes > (
        SELECT AVG(media_time_minutes)
        FROM user_time
    )
)
ORDER BY first_name;