DROP TABLE IF EXISTS #Orders;
DROP TABLE IF EXISTS #ManufacturingTimes;
GO

CREATE TABLE #Orders
(
OrderID        INTEGER PRIMARY KEY,
Product        VARCHAR(100) NOT NULL,
DaysToDeliver  INTEGER NOT NULL
);
GO

CREATE TABLE #ManufacturingTimes
(
Product            VARCHAR(100),
Component          VARCHAR(100),
DaysToManufacture  INTEGER NOT NULL,
PRIMARY KEY (Product, Component)
);
GO

INSERT INTO #Orders (OrderID, Product, DaysToDeliver) VALUES
(1, 'Aurora', 7),
(2, 'Twilight', 3),
(3, 'SunRay', 9);
GO

INSERT INTO #ManufacturingTimes (Product, Component, DaysToManufacture) VALUES
('Aurora', 'Photon Coil', 7),
('Aurora', 'Filament', 2),
('Aurora', 'Shine Capacitor', 3),
('Aurora', 'Glow Sphere', 1),
('Twilight', 'Photon Coil', 7),
('Twilight', 'Filament', 2),
('SunRay', 'Shine Capacitor', 3),
('SunRay', 'Photon Coil', 1);
GO

SELECT *
FROM #Orders

SELECT *
FROM #ManufacturingTimes



WITH cte_Max AS
(
SELECT  Product,
        MAX(DaysToManufacture) AS DaysToBuild
FROM    #ManufacturingTimes b
GROUP BY Product
)
SELECT  a.OrderID,
        a.Product,
        b.DaystoBuild,
        a.DaysToDeliver,
        CASE WHEN b.DaystoBuild = DaystoDeliver THEN 'On Schedule'
             WHEN b.DaystoBuild < DaystoDeliver THEN 'Ahead of Schedule'
             WHEN b.DaystoBuild > DaystoDeliver THEN 'Behind Schedule' END AS Schedule
FROM    #Orders a INNER JOIN
        cte_Max b ON a.Product = b.Product;
GO
