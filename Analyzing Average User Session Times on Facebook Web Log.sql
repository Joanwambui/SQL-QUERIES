WITH session_pairs AS (
    SELECT
        user_id,
        timestamp AS load_time,
        LEAD(timestamp) OVER (PARTITION BY user_id ORDER BY timestamp) AS exit_time,
        action,
        LEAD(action) OVER (PARTITION BY user_id ORDER BY timestamp) AS next_action
    FROM facebook_web_log
    WHERE action IN ('page_load', 'page_exit')
),
valid_sessions AS (
    SELECT
        user_id,
        load_time,
        exit_time,
        DATEDIFF(second, load_time, exit_time) AS session_time  -- Calculate duration in seconds
    FROM session_pairs
    WHERE action = 'page_load' AND next_action = 'page_exit'
)
SELECT
    user_id,
    ROUND(AVG(session_time * 1.0), 1) AS avg_session_time  -- Multiply by 1.0 to implicitly convert to float for averaging
FROM valid_sessions
GROUP BY user_id
HAVING AVG(session_time) IS NOT NULL;