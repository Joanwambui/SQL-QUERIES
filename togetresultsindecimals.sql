SELECT e.location, AVG(h.popularity) AS avg_popularity
FROM facebook_employees e
INNER JOIN facebook_hack_survey h
ON e.id = h.employee_id
GROUP BY e.location;
