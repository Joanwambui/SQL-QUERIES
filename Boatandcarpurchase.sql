DROP TABLE IF EXISTS #Vehicles;
GO


        
CREATE TABLE #Vehicles (
VehicleID  INTEGER PRIMARY KEY,
[Type]     VARCHAR(20),
Model      VARCHAR(20),
Price      MONEY
);
GO

        
        
INSERT INTO #Vehicles (VehicleID, [Type], Model, Price) VALUES
(1, 'Car','Rolls-Royce Phantom', 460000),
(2, 'Car','Cadillac CT5', 39000),
(3, 'Car','Porsche Boxster', 63000),
(4, 'Car','Lamborghini Spyder', 290000),
(5, 'Boat','Malibu', 210000),
(6, 'Boat', 'ATX 22-S', 85000),
(7, 'Boat', 'Sea Ray SLX', 520000),
(8, 'Boat', 'Mastercraft', 25000);
GO

SELECT  a.Model AS Car,
        b.Model AS Boat
FROM    #Vehicles a CROSS JOIN
        #Vehicles B
WHERE   a.Type = 'Car' AND
        b.Type = 'Boat' AND
        a.Price > b.Price + 200000
ORDER BY 1,2;
GO
