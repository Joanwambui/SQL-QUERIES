--For each of these clients, calculate the number of such exclusive users. The output should include the client_id and the corresponding count of exclusive users

SELECT client_id, COUNT(DISTINCT user_id) AS ExclusiveClients
FROM meetup_events 
WHERE user_id NOT IN (


SELECT DISTINCT m1.user_id
FROM meetup_events m1
JOIN meetup_events m2
ON m1.client_id <> m2.client_id
AND m1.user_id = m2.user_id
)

GROUP BY client_id
ORDER BY ExclusiveClients DESC
