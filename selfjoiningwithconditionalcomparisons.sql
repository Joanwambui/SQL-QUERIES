SELECT t1.name,t1.passengerid, ABS(t1.fare - t2.fare) as fare_difference
FROM  titanic t1
JOIN titanic t2
ON 
t1.fare != t2.fare 
AND ABS(t1.age-t2.age) <=5 AND 
t1.pclass = t2.pclass 
AND t1.survived = 0 AND
t2.survived = 0


