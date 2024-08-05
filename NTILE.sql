DROP TABLE IF EXISTS #PlayerScores;
GO

CREATE TABLE #PlayerScores
(
    PlayerID  INTEGER PRIMARY KEY,
    Score     INTEGER NOT NULL
);
GO

INSERT INTO #PlayerScores (PlayerID, Score) VALUES
(1001,2343),(2002,9432),
(3003,6548),(4004,1054),
(5005,6832);
GO

SELECT  NTILE(2) OVER (ORDER BY Score DESC) AS Quartile,
        PlayerID,
        Score
FROM    #PlayerScores a
ORDER BY Score DESC;
GO
