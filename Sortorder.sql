DROP TABLE IF EXISTS #SortOrder;
GO

CREATE TABLE #SortOrder
(
City  VARCHAR(100) PRIMARY KEY
);
GO

INSERT INTO #SortOrder (City) VALUES
('Atlanta'),('Baltimore'),('Chicago'),('Denver');
GO

SELECT  City
FROM    #SortOrder
ORDER BY (CASE City WHEN 'Atlanta' THEN 2
                    WHEN 'Baltimore' THEN 1
                    WHEN 'Chicago' THEN 4
                    WHEN 'Denver' THEN 1 END);