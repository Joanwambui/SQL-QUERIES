--Calculate the total number of interactions and the total number of contents created for each customer.
--Include all interaction types and content types in your calculations.
--Your output should include the customer's ID, the total number of interactions, and the total number of content items.

SELECT *
FROM customer_interactions

SELECT *
FROM user_contents

with cte as (
SELECT COUNT(interaction_id) AS count_of_interaction, customer_id
FROM customer_interactions
GROUP BY customer_id),

cte1 as (
SELECT COUNT(content_id) AS count_of_content, customer_id
FROM user_contents
GROUP BY customer_id)

SELECT C.count_of_interaction,B.count_of_content
from cte C
JOIN cte1 B
ON C.customer_id = B.customer_id

SELECT U.customer_id,COALESCE(COUNT(DISTINCT U.content_id),0) AS count_of_interaction, COALESCE(COUNT(DISTINCT C.interaction_id),0) AS count_of_content
FROM (SELECT customer_id, content_id FROM user_contents) U
FULL OUTER JOIN (SELECT customer_id,interaction_id FROM customer_interactions) C
ON U.customer_id  = C.customer_id
GROUP BY U.customer_id


SELECT 
    COALESCE(U.customer_id, C.customer_id) AS customer_id,
    COALESCE(COUNT(DISTINCT U.interaction_id), 0) AS count_of_interaction,
    COALESCE(COUNT(DISTINCT C.content_id), 0) AS count_of_content
FROM 
    (SELECT customer_id, interaction_id FROM customer_interactions) U
FULL OUTER JOIN 
    (SELECT customer_id, content_id FROM user_contents) C
ON 
    U.customer_id = C.customer_id
GROUP BY 
    COALESCE(U.customer_id, C.customer_id);


