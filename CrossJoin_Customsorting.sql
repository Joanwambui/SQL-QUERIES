DROP TABLE IF EXISTS #RegionSales;
GO


CREATE TABLE #RegionSales
(
Region       VARCHAR(100),
Distributor  VARCHAR(100),
Sales        INTEGER NOT NULL,
PRIMARY KEY (Region, Distributor)
);
GO

INSERT INTO #RegionSales (Region, Distributor, Sales) VALUES
('North','ACE',10),
('South','ACE',67),
('East','ACE',54),
('North','ACME',65),
('South','ACME',9),
('East','ACME',1),
('West','ACME',7),
('North','Direct Parts',8),
('South','Direct Parts',7),
('West','Direct Parts',12);
GO

SELECT *
FROM #RegionSales

SELECT DISTINCT Region
FROM #RegionSales

SELECT DISTINCT Distributor
FROM #RegionSales


WITH cte_DistinctRegion AS
(
SELECT  DISTINCT Region
FROM    #RegionSales
),
cte_DistinctDistributor AS
(
SELECT  DISTINCT Distributor
FROM    #RegionSales
),
cte_CrossJoin AS
(
SELECT  Region, Distributor
FROM    cte_DistinctRegion a CROSS JOIN
        cte_DistinctDistributor b
)
SELECT  a.Region,
        a.Distributor,
        ISNULL(b.Sales,0) AS Sales
FROM    cte_CrossJoin a LEFT OUTER JOIN
        #RegionSales b ON a.Region = b.Region and a.Distributor = b.Distributor
ORDER BY a.Distributor,
        (CASE a.Region  WHEN 'North' THEN 1
                        WHEN 'South' THEN 2
                        WHEN 'East'  THEN 3
                        WHEN 'West'  THEN 4 END);
GO
