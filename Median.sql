DROP TABLE IF EXISTS #SampleData;
GO

CREATE TABLE #SampleData
(
IntegerValue  INTEGER NOT NULL
);
GO

INSERT INTO #SampleData (IntegerValue) VALUES
(5),(6),(10),(10),(13),(14),(17),(20),(81),(90),(76);
GO

--Median
SELECT
        ((SELECT TOP 1 IntegerValue
        FROM    (
                SELECT  TOP 50 PERCENT IntegerValue
                FROM    #SampleData
                ORDER BY IntegerValue
                ) a
        ORDER BY IntegerValue DESC) +  --Add the Two Together
        (SELECT TOP 1 IntegerValue
        FROM (
            SELECT  TOP 50 PERCENT IntegerValue
            FROM    #SampleData
            ORDER BY IntegerValue DESC
            ) a
        ORDER BY IntegerValue ASC)
        ) * 1.0 /2 AS Median;