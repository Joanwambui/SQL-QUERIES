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


--WHILE Loop
DROP TABLE IF EXISTS #RoutesList;
GO

CREATE TABLE #RoutesList
(
InsertDate      DATETIME DEFAULT GETDATE() NOT NULL,
RouteInsertID   INTEGER NOT NULL,
RoutePath       VARCHAR(8000) NOT NULL,
TotalCost       MONEY NOT NULL,
LastArrival     VARCHAR(100)
);
GO

INSERT INTO #RoutesList (RouteInsertID, RoutePath, TotalCost, LastArrival)
SELECT  1,
        CONCAT(DepartureCity,',',ArrivalCity),
        Cost,
        ArrivalCity
FROM    #Routes
WHERE   DepartureCity = 'Austin';
GO

DECLARE @vRowCount INTEGER = 1;
DECLARE @vRouteInsertID INTEGER = 2;

WHILE @vRowCount >= 1
BEGIN

     WITH cte_LastArrival AS
     (
     SELECT   RoutePath
             ,TotalCost
             ,REVERSE(SUBSTRING(REVERSE(RoutePath),0,CHARINDEX(',',REVERSE(RoutePath)))) AS LastArrival
     FROM    #RoutesList
     WHERE   LastArrival <> 'Des Moines'
     )
     INSERT INTO #RoutesList (RouteInsertID, RoutePath, TotalCost, LastArrival)
     SELECT  @vRouteInsertID
             ,CONCAT(a.RoutePath,',',b.ArrivalCity)
             ,a.TotalCost + b.Cost
             ,b.ArrivalCity
     FROM    cte_LastArrival a INNER JOIN
             #Routes b ON a.LastArrival = b.DepartureCity AND CHARINDEX(b.ArrivalCity,RoutePath) = 0;

     SET @vRowCount = @@ROWCOUNT;

     DELETE  #RoutesList
     WHERE   RouteInsertID < @vRouteInsertID
             AND LastArrival <> 'Des Moines';

     SET @vRouteInsertID = @vRouteInsertID + 1;
END;
GO

SELECT  REPLACE(RoutePath,',',' --> ') AS RoutePath,
        TotalCost
FROM    #RoutesList
ORDER BY 1;
GO
