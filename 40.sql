-- Vaate loomine töötajate andmete jaoks
CREATE VIEW vWEmployeesData 
AS 
SELECT EmployeeKey, FirstName, SickLeaveHours
FROM DimEmployee;

-- Andmete valimine vaates vWEmployeesData
SELECT * FROM vWEmployeesData;

-- Uuendamine vaates vWEmployeesData (kehtib ainult vaates, kui see on lubatud)
UPDATE vWEmployeesData
SET FirstName = 'Mikey'
WHERE EmployeeKey = 2;

-- Kustutamine vaates vWEmployeesData (see on võimalik ainult kui vaade on lihtne)
DELETE FROM vWEmployeesData WHERE EmployeeKey = 2;

-- Andmete sisestamine DimEmployee tabelisse
INSERT INTO DimEmployee(EmployeeKey, FirstName) VALUES (2, 'Mikey');

-- Vaate loomine töötajate detailide jaoks osakonna järgi
CREATE VIEW vwEmployeeDetailsByDepartment
AS
SELECT E.EmployeeKey, E.FirstName, E.SickLeaveHours, ST.SalesTerritoryRegion
FROM DimEmployee E
JOIN DimSalesTerritory ST
ON E.SalesTerritoryKey = ST.SalesTerritoryKey;

-- Andmete valimine vaates vwEmployeeDetailsByDepartment
SELECT * FROM vwEmployeeDetailsByDepartment;

-- Uuendamine vaates vwEmployeeDetailsBySalesTerritoryRegion (vaate nimi vale, peaks olema vwEmployeeDetailsByDepartment)
UPDATE vwEmployeeDetailsByDepartment
SET SalesTerritoryRegion = 'IT' 
WHERE FirstName = 'John';