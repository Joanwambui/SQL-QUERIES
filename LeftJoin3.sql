with top_scores as
( select s.hacker_id, h.name, c.challenge_id from submissions s 
left join challenges c on c.challenge_id = s.challenge_id 
left join difficulty d on d.difficulty_level = c.difficulty_level 
left join hackers h on h.hacker_id = s.hacker_id where d.score = s.score )

select t.hacker_id, t.name 
from top_scores t group by t.hacker_id, t.name 
having count(t.challenge_id) > 1 
order by count(t.challenge_id) desc, t.hacker_id asc

'''
Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! 
Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.
'''