SELECT customer_name, COUNT(DISTINCT activity) Distinct_Activities
FROM rentals
GROUP BY customer_name
HAVING COUNT(DISTINCT activity) > 1