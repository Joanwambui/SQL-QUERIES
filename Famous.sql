--A table named “famous” has two columns called user id and follower id. It represents each user ID has a particular follower ID. 
--These follower IDs are also users of #Facebook / #Meta. Then, find the famous percentage of each user. 
--Famous Percentage = number of followers a user has / total number of users on the platform.

WITH distinct_users AS (
    SELECT user_id AS users FROM famous
    UNION
    SELECT follower_id AS users FROM famous
),
follower_count AS (
    SELECT user_id, COUNT(follower_id) AS followers
    FROM famous
    GROUP BY user_id
)
SELECT 
    f.user_id,
    (f.followers * 100.0) / (SELECT COUNT(*) FROM distinct_users) AS famous_percentage
FROM 
    follower_count f;
