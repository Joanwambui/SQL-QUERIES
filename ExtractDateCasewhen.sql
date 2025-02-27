WITH cte AS (
    SELECT *,
           EXTRACT(DAY FROM measurement_time) AS DAYNO,
           EXTRACT(YEAR FROM measurement_time) AS YEARNO,
           ROW_NUMBER() OVER (PARTITION BY EXTRACT(DAY FROM measurement_time) ORDER BY EXTRACT(HOUR FROM measurement_time)) AS RowCount
    FROM measurements
    ORDER BY DAYNO
)

    
SELECT 

DATE(measurement_time) AS measurement_day,
      SUM(CASE WHEN rowcount IN (1,3,5) THEN measurement_value END) AS odd_sum,
       SUM(CASE WHEN rowcount IN (2,4,6) THEN measurement_value END) AS even_sum
FROM cte
GROUP BY Date(measurement_time)
ORDER BY 1;
