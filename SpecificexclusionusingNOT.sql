DROP TABLE IF EXISTS #Orders;
GO

CREATE TABLE #Orders
(
OrderID     INTEGER PRIMARY KEY,
CustomerID  INTEGER NOT NULL,
Amount      MONEY NOT NULL
);
GO

INSERT INTO #Orders (OrderID, CustomerID, Amount) VALUES
(1,1001,25),(2,1001,50),(3,2002,65),(4,3003,50);
GO

SELECT *
FROM #Orders

--How can we retrieve all orders except those where the CustomerID is 1001 and the Amount is 50?
SELECT *
FROM #Orders
WHERE  AMOUNT <> 50 OR CustomerID <> 1001 


--Solution 1
--NOT
SELECT  OrderID,
        CustomerID,
        Amount
FROM    #Orders
WHERE   NOT(CustomerID = 1001 AND Amount = 50);
GO

SELECT  OrderID,
        CustomerID,
        Amount
FROM    #Orders
EXCEPT
SELECT  OrderID,
        CustomerID,
        Amount
FROM    #Orders
WHERE   CustomerID = 1001 AND Amount = 50;
GO