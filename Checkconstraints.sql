DROP TABLE IF EXISTS #CustomerInfo;
GO

CREATE TABLE #CustomerInfo
(
CustomerID   INTEGER PRIMARY KEY,
PhoneNumber  VARCHAR(14) NOT NULL,
CONSTRAINT ckPhoneNumber CHECK (LEN(PhoneNumber) = 14
                            AND SUBSTRING(PhoneNumber,1,1)= '('
                            AND SUBSTRING(PhoneNumber,5,1)= ')'
                            AND SUBSTRING(PhoneNumber,6,1)= '-'
                            AND SUBSTRING(PhoneNumber,10,1)= '-')
);
GO

INSERT INTO #CustomerInfo (CustomerID, PhoneNumber) VALUES
(1001,'(555)-555-5555'),(2002,'(555)-555-5555'), (3003,'(555)-555-5555');
GO

SELECT  CustomerID, PhoneNumber
FROM    #CustomerInfo;
GO