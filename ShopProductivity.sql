--Given the following tables describing a generic Shop selling products, please write a SQL query that answers the following question:
---“Which two Shops have the highest and the lowest productivity respectively in the last 28 days?”

---Shop productivity is measured by monetary value of sales divided by total salesperson work-hours in the same time period.

-- Drop dependent tables first
DROP TABLE IF EXISTS Sale;
DROP TABLE IF EXISTS WorkShift;

-- Now, drop the Shop and other tables
DROP TABLE IF EXISTS Shop;
DROP TABLE IF EXISTS Salesperson;
DROP TABLE IF EXISTS Product;

-- Re-create the tables
CREATE TABLE Shop (
    shop_id INT PRIMARY KEY,
    shop_name VARCHAR(255)
);

CREATE TABLE Salesperson (
    salesperson_id INT PRIMARY KEY,
    salesperson_name VARCHAR(255)
);

CREATE TABLE WorkShift (
    shift_id INT PRIMARY KEY,
    salesperson_id INT,
    shop_id INT,
    start_time DATETIME,
    end_time DATETIME,
    FOREIGN KEY (salesperson_id) REFERENCES Salesperson(salesperson_id),
    FOREIGN KEY (shop_id) REFERENCES Shop(shop_id)
);

CREATE TABLE Product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    price DECIMAL(10, 2)
);

CREATE TABLE Sale (
    sale_id INT PRIMARY KEY,
    shift_id INT,
    product_id INT,
    sale_time DATETIME,
    quantity_sold INT,
    FOREIGN KEY (shift_id) REFERENCES WorkShift(shift_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id)
);

-- Insert data into Shop table
INSERT INTO Shop (shop_id, shop_name) VALUES
(1, 'Central Market'),
(2, 'Westside Plaza'),
(3, 'Uptown Bazaar');

-- Insert data into Salesperson table
INSERT INTO Salesperson (salesperson_id, salesperson_name) VALUES
(1, 'Jane Doe'),
(2, 'John Smith'),
(3, 'Mary Johnson');

-- Insert data into WorkShift table
INSERT INTO WorkShift (shift_id, salesperson_id, shop_id, start_time, end_time) VALUES
(1, 1, 1, '2024-09-01 08:00:00', '2024-09-01 16:00:00'),
(2, 2, 2, '2024-09-01 09:00:00', '2024-09-01 17:00:00'),
(3, 3, 3, '2024-09-01 10:00:00', '2024-09-01 18:00:00');

-- Insert data into Product table
INSERT INTO Product (product_id, product_name, price) VALUES
(1, 'Apple', 0.50),
(2, 'Banana', 0.30),
(3, 'Orange', 0.60);

-- Insert data into Sale table
INSERT INTO Sale (sale_id, shift_id, product_id, sale_time, quantity_sold) VALUES
(1, 1, 1, '2024-09-01 08:30:00', 10),
(2, 2, 2, '2024-09-01 09:45:00', 15),
(3, 3, 3, '2024-09-01 10:15:00', 8);


SELECT *
FROM Shop

SELECT *
FROM Salesperson

SELECT *
FROM WorkShift

SELECT *
FROM Product

SELECT *
FROM Product

SELECT *
FROM Sale


SELECT *, DATEDIFF(HOUR, start_time, end_time) AS shift_duration_hours
FROM WorkShift;

SELECT S.*, P.price, S.quantity_sold*P.price AS AmountSold, DATEDIFF(HOUR, W.start_time, W.end_time) AS shift_duration_hours, (S.quantity_sold*P.price)/(DATEDIFF(HOUR, W.start_time, W.end_time)) AS Productivity
FROM Sale S
INNER JOIN Product P
ON S.product_id=P.product_id
INNER JOIN WorkShift W
ON W.shift_id=S.shift_id
ORDER BY Productivity ASC