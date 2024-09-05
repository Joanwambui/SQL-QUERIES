DROP TABLE IF EXISTS #AccountBalances;
GO

CREATE TABLE #AccountBalances
(
AccountID  INTEGER,
Balance    MONEY,
PRIMARY KEY (AccountID, Balance)
);
GO

INSERT INTO #AccountBalances (AccountID, Balance) VALUES
(1001,234.45),(1001,-23.12),(2002,-93.01),(2002,-120.19),
(3003,186.76), (3003,90.23), (3003,10.11);
GO

SELECT *
FROM #AccountBalances

--Solution 1
--SET Operators
SELECT DISTINCT AccountID FROM #AccountBalances WHERE Balance < 0
EXCEPT
SELECT DISTINCT AccountID FROM #AccountBalances WHERE Balance > 0;
GO


--Solution 2
--MAX
SELECT  AccountID, MAX(Balance) as MAX
FROM    #AccountBalances
GROUP BY AccountID
HAVING  MAX(Balance) < 0;

--Solution 3
--NOT IN
SELECT  DISTINCT AccountID
FROM    #AccountBalances
WHERE   AccountID NOT IN (SELECT AccountID FROM #AccountBalances WHERE Balance > 0);
GO

