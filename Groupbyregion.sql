WITH food_regions_grouped AS (
SELECT TOP 1 region, SUM(fast_food_millions) AS total_spending
FROM food_regions
GROUP BY region
ORDER BY total_spending DESC 
  )
SELECT region
  FROM food_regions_grouped;


SELECT R.region, AVG(S.snowfall_inches) AS average_snowfall
FROM ski_resorts R
INNER JOIN snowfall S
ON R. resort_id = S.resort_id
GROUP BY region
ORDER BY AVG(S.snowfall_inches) DESC
