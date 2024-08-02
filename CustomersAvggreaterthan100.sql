---State where customers Average is more than 100
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

with cte as (
SELECT AVG(Amount) AS AverageAmount, State, CustomerID
FROM #Orders
GROUP BY State, CustomerID)

SELECT Distinct (State)
FROM cte
WHERE AverageAmount>100

WITH cte_AvgMonthlySalesCustomer AS
(
SELECT  CustomerID,
        OrderDate,
        [State],
        AVG(Amount) AS AverageValue
FROM    #Orders
GROUP BY CustomerID,OrderDate,[State]
),
cte_MinAverageValueState AS
(
SELECT  [State]
FROM    cte_AvgMonthlySalesCustomer
GROUP BY [State]
HAVING  MIN(AverageValue) >= 100
)
SELECT  [State]
FROM    cte_MinAverageValueState;
GO
