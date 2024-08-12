DROP TABLE IF EXISTS #SampleData;
GO

CREATE TABLE #SampleData
(
IntegerValue  INTEGER NOT NULL
);
GO

INSERT INTO #SampleData (IntegerValue) VALUES
(1),(1),(2),(3),(3),(4);
GO

SELECT *
FROM #SampleData

with cte as (
SELECT IntegerValue, ROW_NUMBER() OVER (PARTITION BY IntegerValue ORDER BY IntegerValue) AS Rowno
FROM #SampleData)

SELECT IntegerValue
FROM cte 
WHERE Rowno = 1


WITH cte_Duplicates AS
(
SELECT  ROW_NUMBER() OVER (PARTITION BY IntegerValue ORDER BY IntegerValue) AS Rnk
FROM    #SampleData
)
DELETE FROM cte_Duplicates WHERE Rnk > 1
GO

SELECT * FROM #SampleData;
GO