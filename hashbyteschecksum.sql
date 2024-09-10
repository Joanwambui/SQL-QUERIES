DROP TABLE IF EXISTS #Assembly;
GO

CREATE TABLE #Assembly
(
AssemblyID  INTEGER,
Part        VARCHAR(100),
PRIMARY KEY (AssemblyID, Part)
);
GO

INSERT INTO #Assembly (AssemblyID, Part) VALUES
(1001,'Bolt'),(1001,'Screw'),(2002,'Nut'),
(2002,'Washer'),(3003,'Toggle'),(3003,'Bolt');
GO

SELECT  HASHBYTES('SHA2_512',CONCAT(AssemblyID, Part)) AS ExampleUniqueID1,
        CHECKSUM(CONCAT(AssemblyID, Part)) AS ExampleUniqueID12,
        AssemblyID,
        Part
FROM    #Assembly;
GO