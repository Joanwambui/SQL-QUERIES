DROP TABLE IF EXISTS customers
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(50)
);


INSERT INTO customers (customer_id, full_name)
VALUES 
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Michael Johnson'),
(4, 'Emily Davis'),
(5, 'William Brown'),
(6, 'Olivia Wilson'),
(7, 'Liam Martinez'),
(8, 'Sophia Anderson'),
(9, 'Noah Taylor'),
(10, 'Isabella Thomas'),
(11, 'James White'),
(12, 'Ava Harris'),
(13, 'Lucas Clark'),
(14, 'Mia Lewis'),
(15, 'Benjamin Young');


SELECT Customer_ID, LTRIM(RTRIM(LEFT(Full_Name, CHARINDEX(' ', Full_Name + ' ') - 1))) AS First_Name
FROM customers;
