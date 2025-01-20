/*
Write a query to calculate the distribution of comments by the count of users that joined Meta/Facebook between 2018 and 2020,
for the month of January 2020.

The output should contain a count of comments and the corresponding number of users that made that number of comments in Jan-2020.
For example, you'll be counting how many users made 1 comment, 2 comments, 3 comments, 4 comments, etc in Jan-2020.
Your left column in the output will be the number of comments while your right column in the output will be the number of users.
Sort the output from the least number of comments to highest.
*/



WITH validusers AS (
    SELECT id AS user_id, joined_at
    FROM fb_users
    WHERE YEAR(joined_at) BETWEEN 2018 AND 2020
),
validcomments AS (
    SELECT 
        fc.user_id,
        COUNT(fc.body) AS comment_count
    FROM fb_comments fc
    INNER JOIN validusers vu
        ON fc.user_id = vu.user_id
    WHERE fc.created_at >= '2020-01-01' 
      AND fc.created_at < '2020-02-01'
      AND fc.created_at >= vu.joined_at
    GROUP BY fc.user_id
),
CommentDistribution AS (
    SELECT 
        comment_count, 
        COUNT(user_id) AS user_count
    FROM validcomments
    GROUP BY comment_count
)
SELECT 
    comment_count,
    user_count
FROM CommentDistribution
ORDER BY comment_count ASC;
