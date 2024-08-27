DROP TABLE IF EXISTS #PrimeNumbers;
GO

CREATE TABLE #PrimeNumbers
(
IntegerValue  INTEGER PRIMARY KEY
);
GO

INSERT INTO #PrimeNumbers (IntegerValue) VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
GO

WITH cte_Mod AS
(
SELECT  a.IntegerValue, a.IntegerValue % b.IntegerValue AS Modulus
FROM    #PrimeNumbers a INNER JOIN
        #PrimeNumbers b ON a.IntegerValue >= b.IntegerValue
)
SELECT IntegerValue AS PrimeNumber
FROM   cte_Mod
WHERE  Modulus = 0
GROUP BY IntegerValue
HAVING COUNT(*) = 2;
GO