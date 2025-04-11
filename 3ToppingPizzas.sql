 SELECT CONCAT_WS(',', topping_list) AS pizza,
       
       SUM(ingredient_cost) AS total_cost 
FROM (
    SELECT CONCAT_WS(',', t1.topping_name, t2.topping_name, t3.topping_name) AS topping_list,
           t1.ingredient_cost + t2.ingredient_cost + t3.ingredient_cost AS ingredient_cost
    FROM pizza_toppings t1
       
    JOIN pizza_toppings t2 ON t1.topping_name < t2.topping_name
       
    JOIN pizza_toppings t3 ON t2.topping_name < t3.topping_name AND t1.topping_name < t3.topping_name
) AS subquery
GROUP BY topping_list
ORDER BY total_cost DESC, pizza;

SELECT 
  CONCAT(p1.topping_name, ',', p2.topping_name, ',', p3.topping_name) AS pizza,
  p1.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost AS total_cost
FROM pizza_toppings AS p1
INNER JOIN pizza_toppings AS p2
  ON p1.topping_name < p2.topping_name 
INNER JOIN pizza_toppings AS p3
  ON p2.topping_name < p3.topping_name 
ORDER BY total_cost DESC, pizza;
---Important tip: Instead of matching the tables on columns using the equal sign =, we use the less than sign < to ensure that:
--There is no duplication of the ingredients across each row.
--The ingredients are arranged in an alphabetical manner from left to right.
--The goal was to get all the possible unique combinations (Only 3)
