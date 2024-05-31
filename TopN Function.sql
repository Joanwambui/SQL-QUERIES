WITH cte1 AS
(SELECT TOP 1 city, LEN(city) AS citylength
FROM STATION
ORDER BY LEN(city), city),

cte2 AS
(SELECT TOP 1 city, LEN(city) AS citylength
FROM
STATION
ORDER BY LEN(city) DESC, city)

SELECT city, citylength FROM cte1
UNION
SELECT city, citylength FROM cte2;