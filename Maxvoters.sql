WITH cte AS (
    SELECT voter, COUNT(voter) AS CountOfVoter 
    FROM voting_results 
    GROUP BY voter
),
cte1 AS (
    SELECT candidate, voter 
    FROM voting_results 
),
cte2 AS (
    SELECT 
        C.voter, 
        C.CountOfVoter, 
        D.candidate,
        ROUND(COUNT(D.candidate) * 1.0 / C.CountOfVoter, 3) AS CandidateProportion
    FROM 
        cte AS C 
    INNER JOIN 
        cte1 AS D ON C.voter = D.voter
    GROUP BY 
        C.voter, C.CountOfVoter, D.candidate
)

SELECT TOP 1
    candidate
FROM 
    cte2 
GROUP BY 
    candidate
HAVING 
    SUM(CandidateProportion) = (SELECT MAX(TotalProportion) 
                                 FROM (SELECT SUM(CandidateProportion) AS TotalProportion 
                                       FROM cte2 
                                       GROUP BY candidate) AS subquery);


SELECT candidate
FROM
  (SELECT candidate,
          ROUND(SUM(vote_value), 3) AS n_votes,
          DENSE_RANK() OVER(
                            ORDER BY ROUND(SUM(vote_value), 3) DESC) AS place
   FROM
     (SELECT voter,
             candidate,
             1.0 / COUNT(*) OVER(PARTITION BY voter) AS vote_value
      FROM voting_results
      WHERE candidate IS NOT NULL)a
   GROUP BY candidate) AS results
WHERE place = 1