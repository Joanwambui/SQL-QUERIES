WITH Year2019 AS (
    SELECT company_name, COUNT(product_name) AS count_2019, year
    FROM car_launches
    WHERE year = 2019
    GROUP BY company_name, year
),
Year2020 AS (
    SELECT company_name, COUNT(product_name) AS count_2020, year
    FROM car_launches
    WHERE year = 2020
    GROUP BY company_name, year
)
SELECT L.company_name, L.count_2020 - P.count_2019 AS difference
FROM Year2020 AS L
JOIN Year2019 AS P
ON L.company_name = P.company_name;



SELECT a.company_name,
       (count(DISTINCT a.product_name)-count(DISTINCT b.product_name)) net_products
FROM
  (SELECT company_name,
          product_name
   FROM car_launches
   WHERE YEAR = 2020) a
FULL OUTER JOIN
  (SELECT company_name,
          product_name
   FROM car_launches
   WHERE YEAR = 2019) b ON a.company_name = b.company_name
GROUP BY a.company_name
ORDER BY company_name