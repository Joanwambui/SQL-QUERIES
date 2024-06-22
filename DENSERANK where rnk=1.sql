WITH cte AS
( SELECT id, age, coins_needed, power, 
DENSE_RANK() OVER (PARTITION BY w.power, wp.age ORDER BY power DESC, coins_needed) AS rnk 
FROM wands w 
JOIN wands_property wp ON w.code=wp.code AND wp.is_evil=0)

SELECT id, age, coins_needed, power 
FROM cte 
WHERE rnk=1 
ORDER BY power DESC, age DESC;