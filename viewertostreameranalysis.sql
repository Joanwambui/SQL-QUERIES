--From users who had their first session as a viewer, how many streamer sessions have they had?
--Return the user id and number of sessions in descending order.
--In case there are users with the same number of sessions, order them by ascending user id.

with cte1 AS (
SELECT *
FROM twitch_sessions),

cte2 as (
SELECT user_id AS userid,session_start AS sessionstart, session_end AS sessionend,session_id AS sessionid,session_type AS sessiontype
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY session_start ASC) as row_num
    FROM twitch_sessions
) sub
WHERE row_num = 1
)

SELECT a.user_id,COUNT(a.session_type) AS Streamercount
FROM cte1 AS a
INNER JOIN cte2 as b
ON a.user_id = b.userid
WHERE a.session_type = 'streamer'
GROUP BY user_id
ORDER BY user_id ASC

---solution2

WITH FirstSession AS (
    SELECT user_id,
           MIN(session_start) AS first_session_time
    FROM twitch_sessions
    WHERE session_type = 'viewer'
    GROUP BY user_id
)
SELECT ts.user_id,
       COUNT(*) AS streamer_sessions_count
FROM twitch_sessions ts
JOIN FirstSession fs
  ON ts.user_id = fs.user_id
WHERE ts.session_type = 'streamer'
GROUP BY ts.user_id
ORDER BY streamer_sessions_count DESC, ts.user_id ASC;
