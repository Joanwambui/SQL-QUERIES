DROP TABLE IF EXISTS users1
CREATE TABLE users1(user_id INT, user_name varchar(30));
INSERT INTO users1 VALUES (1, 'Karl'), (2, 'Hans'), (3, 'Emma'), (4, 'Emma'), (5, 'Mike'), (6, 'Lucas'), (7, 'Sarah'), (8, 'Lucas'), (9, 'Anna'), (10, 'John');

DROP TABLE IF EXISTS friends1
CREATE TABLE friends1(user_id INT, friend_id INT);
INSERT INTO friends1 VALUES (1,3),(1,5),(2,3),(2,4),(3,1),(3,2),(3,6),(4,7),(5,8),(6,9),(7,10),(8,6),(9,10),(10,7),(10,9);

SELECT *
FROM users1 U

SELECT *
FROM friends1 F

--You are analyzing a social network dataset at Google. 
--Your task is to find mutual friends between two users, Karl and Hans. There is only one user named Karl and one named Hans in the dataset.


with cte as (SELECT * FROM friends1
where user_id = 1)
, cte2 as (SELECT * FROM friends1
where user_id = 2)
SELECT cte.friend_id FROM cte
join cte2 on cte.friend_id = cte2.friend_id
WHERE cte.friend_id = cte2.friend_id
