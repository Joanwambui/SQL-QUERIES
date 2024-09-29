WITH food_regions_grouped AS (
SELECT TOP 1 region, SUM(fast_food_millions) AS total_spending
FROM food_regions
GROUP BY region
ORDER BY total_spending DESC 
  )
SELECT region
  FROM food_regions_grouped;