DROP TABLE IF EXISTS #GroupCriteria;
GO

CREATE TABLE #GroupCriteria
(
OrderID      INTEGER PRIMARY KEY,
Distributor  VARCHAR(100) NOT NULL,
Facility     INTEGER NOT NULL,
[Zone]       VARCHAR(100) NOT NULL,
Amount       MONEY NOT NULL
);
GO

INSERT INTO #GroupCriteria (OrderID, Distributor, Facility, [Zone], Amount) VALUES
(1,'ACME',123,'ABC',100),
(2,'ACME',123,'ABC',75),
(3,'Direct Parts',789,'XYZ',150),
(4,'Direct Parts',789,'XYZ',125);
GO

SELECT  DENSE_RANK() OVER (ORDER BY Distributor, Facility, [Zone]) AS CriteriaID,
        OrderID,
        Distributor,
        Facility,
        [Zone],
        Amount
FROM    #GroupCriteria;
GO
