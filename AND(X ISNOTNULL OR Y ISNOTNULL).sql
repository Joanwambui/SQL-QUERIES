SELECT candidate_id 
FROM candidates
WHERE problem_solving IS NOT NULL
AND sql_experience IS NOT NULL
AND (python IS NOT NULL OR r_programming IS NOT NULL)
AND domain_knowledge IS NOT NULL
ORDER BY candidate_id ASC
