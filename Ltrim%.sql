drop table if exists product_demo;
create table product_demo
(
	store_id	int,
	product_1	varchar(50),
	product_2	varchar(50)
);
insert into product_demo values (1, 'Apple - IPhone', '   Apple - MacBook Pro');
insert into product_demo values (1, 'Apple - AirPods', 'Samsung - Galaxy Phone');
insert into product_demo values (2, 'Apple_IPhone', 'Apple: Phone');
insert into product_demo values (2, 'Google Pixel', ' apple: Laptop');
insert into product_demo values (2, 'Sony: Camera', 'Apple Vision Pro');
insert into product_demo values (3, 'samsung - Galaxy Phone', 'mapple MacBook Pro');

select * from product_demo;

SELECT 
    SUM(CASE WHEN LOWER(Product_1) LIKE 'apple%' THEN 1 ELSE 0 END) AS Product_1_Count,
    SUM(CASE WHEN LOWER(Product_2) LIKE 'apple%' THEN 1 ELSE 0 END) AS Product_2_Count
FROM 
    product_demo
WHERE 
    LOWER(Product_1) LIKE 'apple%' OR LOWER(Product_2) LIKE 'apple%'
GROUP BY 
    store_id;


SELECT store_id,
    SUM(CASE WHEN LOWER(Product_1) LIKE 'apple%' THEN 1 ELSE 0 END) AS Product_1_Count,
    SUM(CASE WHEN LOWER(Product_2) LIKE 'apple%' THEN 1 ELSE 0 END) AS Product_2_Count
FROM 
    product_demo

GROUP BY 
    store_id;

SELECT store_id,
    SUM(CASE WHEN LOWER(Product_1) LIKE '   apple%' OR LOWER(Product_1) LIKE 'apple%' THEN 1 ELSE 0 END) AS Product_1_Count,
    SUM(CASE WHEN LOWER(Product_2) LIKE '   apple%' OR LOWER(Product_2) LIKE 'apple%' THEN 1 ELSE 0 END) AS Product_2_Count
FROM 
    product_demo
GROUP BY 
    store_id;

select store_id
, sum(case when ltrim(lower(product_1)) like 'apple%' then 1 else 0 end) as product_1
, sum(case when ltrim(lower(product_2)) like 'apple%' then 1 else 0 end) as product_2
from product_demo
group by store_id
order by store_id;

--ltrim functions removes any white spaces before the name