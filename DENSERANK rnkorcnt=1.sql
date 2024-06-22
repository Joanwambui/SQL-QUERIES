WITH ChallengeCounts AS ( SELECT H.hacker_id, H.name, COUNT(C.challenge_id) AS Total_Challenge 
FROM Hackers AS H JOIN Challenges AS C ON H.hacker_id = C.hacker_id GROUP BY H.hacker_id, H.name ),

RankedChallengeCounts AS ( SELECT cc.hacker_id, cc.name, cc.Total_Challenge, RANK() OVER (ORDER BY cc.Total_Challenge DESC) AS rnk, COUNT(*) OVER (PARTITION BY cc.Total_Challenge) AS cnt 
FROM ChallengeCounts AS cc )

SELECT hacker_id, name, Total_Challenge 
FROM RankedChallengeCounts 
WHERE rnk = 1 OR cnt = 1 
ORDER BY Total_Challenge DESC, hacker_id ASC;


'''
Julia asked her students to create some coding challenges. 
Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
Sort your results by the total number of challenges in descending order. 
If more than one student created the same number of challenges, then sort the result by hacker_id. 
If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, 
then exclude those students from the result.
'''