Write a query to find all dates with higher temperatures compared to the previous dates (yesterday).

Order dates in ascending order.

SELECT t1.date
FROM temperatures t1
INNER JOIN temperatures t2 ON DATEDIFF(day, t2.date, t1.date) = 1 AND t1.temperature > t2.temperature
ORDER BY t1.date;
