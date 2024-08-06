DROP TABLE IF EXISTS #Orders;
GO

CREATE TABLE #Orders
(
OrderID     INTEGER PRIMARY KEY,
CustomerID  INTEGER NOT NULL,
OrderDate   DATE NOT NULL,
Amount      MONEY NOT NULL,
[State]     VARCHAR(2) NOT NULL
);
GO

INSERT INTO #Orders (OrderID, CustomerID, OrderDate, Amount, [State]) VALUES
(1,1001,'1/1/2018',100,'TX'),
(2,1001,'1/1/2018',150,'TX'),
(3,1001,'1/1/2018',75,'TX'),
(4,1001,'2/1/2018',100,'TX'),
(5,1001,'3/1/2018',100,'TX'),
(6,2002,'2/1/2018',75,'TX'),
(7,2002,'2/1/2018',150,'TX'),
(8,3003,'1/1/2018',100,'IA'),
(9,3003,'2/1/2018',100,'IA'),
(10,3003,'3/1/2018',100,'IA'),
(11,4004,'4/1/2018',100,'IA'),
(12,4004,'5/1/2018',50,'IA'),
(13,4004,'5/1/2018',100,'IA');
GO

SELECT *
FROM #Orders

'''
You are tasked with retrieving a specific subset of orders to analyze them. 
Specifically, you need to retrieve the 5th through the 10th rows of the orders sorted by OrderID.
Write a SQL query that accomplishes this using the OFFSET FETCH NEXT clause to extract exactly 6 rows starting from the 5th row.
'''

SELECT OrderID, CustomerID, OrderDate, Amount, [State]
FROM   #Orders
ORDER BY OrderID
OFFSET 4 ROWS FETCH NEXT 6 ROWS ONLY;
