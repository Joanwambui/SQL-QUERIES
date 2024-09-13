
DROP TABLE IF EXISTS #WinningNumbers;
DROP TABLE IF EXISTS #LotteryTickets;
GO

CREATE TABLE #WinningNumbers
(
Number  INTEGER PRIMARY KEY
);
GO

INSERT INTO #WinningNumbers (Number) VALUES
(25),(45),(78);
GO

CREATE TABLE #LotteryTickets
(
TicketID  VARCHAR(3),
Number    INTEGER,
PRIMARY KEY (TicketID, Number)
);
GO

INSERT INTO #LotteryTickets (TicketID, Number) VALUES
('AAA',25),('AAA',45),('AAA',78),
('BBB',25),('BBB',45),('BBB',98),
('CCC',67),('CCC',86),('CCC',91);
GO


SELECT*
FROM #LotteryTickets;

SELECT *
FROM #WinningNumbers;

WITH cte_Ticket AS
(
SELECT  TicketID,
        COUNT(*) AS MatchingNumbers
FROM    #LotteryTickets a INNER JOIN
        #WinningNumbers b ON a.Number = b.Number
GROUP BY TicketID
),
cte_Payout AS
(
SELECT  (CASE WHEN MatchingNumbers = (SELECT COUNT(*) FROM #WinningNumbers) THEN 100 ELSE 10 END) AS Payout
FROM    cte_Ticket
)
SELECT  SUM(Payout) AS TotalPayout
FROM    cte_Payout;
GO
