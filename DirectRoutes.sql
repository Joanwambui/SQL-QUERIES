---determine the optimal travel route and its cost from Austin to Des Moines using recursive SQL CTEs to explore all possible paths?
--The expected output is a list of all possible travel routes from Austin to Des Moines, along with the total cost for each route. 

DROP TABLE IF EXISTS #Routes;
GO

    
CREATE TABLE #Routes
(
RouteID        INTEGER NOT NULL,
DepartureCity  VARCHAR(30) NOT NULL,
ArrivalCity    VARCHAR(30) NOT NULL,
Cost           MONEY NOT NULL,
PRIMARY KEY (DepartureCity, ArrivalCity)
);
GO

INSERT INTO #Routes (RouteID, DepartureCity, ArrivalCity, Cost) VALUES
(1,'Austin','Dallas',100),
(2,'Dallas','Memphis',200),
(3,'Memphis','Des Moines',300),
(4,'Dallas','Des Moines',400);


SELECT *
FROM #Routes


-- Create a temporary table to store the paths
DROP TABLE IF EXISTS #SimpleRoutes;
GO

CREATE TABLE #SimpleRoutes
(
    RoutePath   VARCHAR(100) NOT NULL,
    TotalCost   MONEY NOT NULL
);
GO

-- Start by inserting the direct routes from the starting city
INSERT INTO #SimpleRoutes (RoutePath, TotalCost)
SELECT CONCAT(DepartureCity, ' --> ', ArrivalCity) AS RoutePath, Cost
FROM #Routes
WHERE DepartureCity = 'Austin';
GO

-- Display the result
SELECT RoutePath, TotalCost
FROM #SimpleRoutes
ORDER BY TotalCost;
GO
