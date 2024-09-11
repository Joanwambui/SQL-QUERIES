DROP TABLE IF EXISTS #Spouses;
GO

CREATE TABLE #Spouses
(
PrimaryID  VARCHAR(100),
SpouseID   VARCHAR(100),
PRIMARY KEY (PrimaryID, SpouseID)
);
GO

INSERT INTO #Spouses (PrimaryID, SpouseID) VALUES
('Pat','Charlie'),('Jordan','Casey'),
('Ashley','Dee'),('Charlie','Pat'),
('Casey','Jordan'),('Dee','Ashley');
GO



WITH cte_Reciprocals AS
(
SELECT
        (CASE WHEN PrimaryID < SpouseID THEN PrimaryID ELSE SpouseID END) AS ID1,
        (CASE WHEN PrimaryID > SpouseID THEN PrimaryID ELSE SpouseID END) AS ID2,
        PrimaryID,
        SpouseID
FROM    #Spouses
),
cte_DenseRank AS
(
SELECT  DENSE_RANK() OVER (ORDER BY ID1) AS GroupID,
        ID1, ID2, PrimaryID, SpouseID
FROM    cte_Reciprocals
)
SELECT  GroupID,
        b.PrimaryID,
        b.SpouseID
FROM    cte_DenseRank a INNER JOIN
        #Spouses b ON a.PrimaryID = b.PrimaryID AND a.SpouseID = b.SpouseID;
GO