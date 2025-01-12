

--We want to identify the most suspicious claims in each state.
--We'll consider the top 5 percentile of claims with the highest fraud scores in each state as potentially fraudulent.

--Your output should include the policy number, state, claim cost, and fraud score

with fraudscorpercentiles AS (
SELECT *, PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY fraud_score) OVER (PARTITION BY state) AS percentile_95
FROM Claims),

potentialfraudulentclaims AS (
SELECT c.policy_number, c.state, c.claim_cost, c.fraud_score
FROM claims c
JOIN fraudscorpercentiles fsd
ON c.state = fsd.state
WHERE c.fraud_Score >= fsd.percentile_95
)

SELECT policy_number, state, claim_Cost, fraud_score
FROM potentialfraudulentclaims
ORDER BY state, fraud_score DESC



