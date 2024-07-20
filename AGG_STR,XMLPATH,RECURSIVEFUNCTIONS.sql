DROP TABLE IF EXISTS #DMLTable;
GO

CREATE TABLE #DMLTable
(
SequenceNumber  INTEGER PRIMARY KEY,
String          VARCHAR(100) NOT NULL
);
GO

INSERT INTO #DMLTable (SequenceNumber, String) VALUES
(1,'SELECT'),
(2,'Product,'),
(3,'UnitPrice,'),
(4,'EffectiveDate'),
(5,'FROM'),
(6,'Products'),
(7,'WHERE'),
(8,'UnitPrice'),
(9,'> 100');
GO



SELECT  STRING_AGG(CONVERT(NVARCHAR(MAX),String), ' ') WITHIN GROUP (ORDER BY SequenceNumber ASC) AS Syntax
FROM    #DMLTable;
GO

--Solution 2
--Recursion
WITH cte_DMLGroupConcat(String2,Depth) AS
(
SELECT  CAST('' AS NVARCHAR(MAX)),
        CAST(MAX(SequenceNumber) AS INTEGER)
FROM    #DMLTable
UNION ALL
SELECT  cte_Ordered.String + ' ' + cte_Concat.String2, cte_Concat.Depth-1
FROM    cte_DMLGroupConcat cte_Concat INNER JOIN
        #DMLTable cte_Ordered ON cte_Concat.Depth = cte_Ordered.SequenceNumber
)
SELECT  String2
FROM    cte_DMLGroupConcat
WHERE   Depth = 0;
GO

--Solution 3
--XML Path
--There is an error; the ">" gets converted to "&gt;".
SELECT  DISTINCT
        STUFF((
            SELECT  CAST(' ' AS VARCHAR(MAX)) + String
            FROM    #DMLTable U
            ORDER BY SequenceNumber
        FOR XML PATH('')), 1, 1, '') AS DML_String
FROM    #DMLTable;
GO
