WITH cte as (
    SELECT
            s.hacker_id,
            h.name,
            s.challenge_id,
            MAX(s.score) as mxscore
    FROM submissions s
    JOIN hackers h
    on h.hacker_id=s.hacker_id
    GROUP BY s.hacker_id, h.name, s.challenge_id
)
SELECT hacker_id, name, sum(mxscore) as total_score
from cte
GROUP BY hacker_id, name
having sum(mxscore) > 0
order by total_score desc, hacker_id;


'''
The total score of a hacker is the sum of their maximum scores for all of the challenges. 
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
Exclude all hackers with a total score of  from your result.
'''