--39 
-- Kuvame kõik töötajad DimEmployee tabelist
SELECT * FROM DimEmployee

-- Kuvame töötajate andmed koos osakonna nimega
SELECT 
EmployeeKey, 
FirstName, 
BaseRate, 
Gender, 
DepartmentName
FROM 
DimEmployee
JOIN 
DimDepartmentGroup ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentName; 

-- Loome vaate vWeEmployeesByDepartment
CREATE VIEW vWeEmployeesByDepartment AS
SELECT 
EmployeeKey, 
FirstName, 
BaseRate, 
Gender, 
DepartmentName
FROM 
DimEmployee
JOIN 
DimDepartmentGroup ON DimEmployee.DepartmentKey = DimDepartmentGroup.DepartmentKey; 

-- Kuvame töötajad vastavalt osakonnale
SELECT * FROM vWeEmployeesByDepartment

-- Loome vaate vWITDepartment_Employees
CREATE VIEW vWITDepartment_Employees AS
SELECT 
EmployeeKey, 
FirstName, 
BaseRate, 
Gender, 
DepartmentName
FROM 
DimEmployee
JOIN 
DimDepartmentGroup ON DimEmployee.DepartmentKey = DimDepartmentGroup.DepartmentKey 
WHERE 
DimDepartmentGroup.DepartmentGroupName = 'IT'; 

-- Loome vaate VWeEmployeesNonConfidentionalData
CREATE VIEW VWeEmployeesNonConfidentionalData AS
SELECT 
DimEmployee.EmployeeKey, 
DimEmployee.FirstName, 
DimEmployee.BaseRate, 
DimEmployee.Gender, 
DimDepartmentGroup.DepartmentGroupName
FROM 
DimEmployee
JOIN 
DimDepartmentGroup ON DimEmployee.ParentEmployeeKey = DimDepartmentGroup.ParentDepartmentGroupKey; 

-- Loome vaate vWEMployeesCountByDepartment
CREATE VIEW vWEMployeesCountByDepartment AS
SELECT 
DepartmentGroupName, 
COUNT(EmployeeKey) AS TotalEmployees 
FROM 
DimEmployee
JOIN 
DimDepartmentGroup ON DimEmployee.DepartmentKey = DimDepartmentGroup.DepartmentGroupKey 
GROUP BY 
DepartmentGroupName; 
--40 

-- Teeme vaate, mis tagastab peaaegu kõik veerud, aga va Salary veerg.
CREATE VIEW vWEmployeesData 
AS 
SELECT EmployeeKey, FirstName, SickLeaveHours
FROM DimEmployee;

-- Kuvame andmed vaatest vWEmployeesData
SELECT * FROM vWEmployeesData;

-- Värskendame vaates vWEmployeesData töötaja nime
UPDATE vWEmployeesData
SET FirstName = 'Mikey'
WHERE EmployeeKey = 2; 

-- Kustutame töötaja, kelle EmployeeKey on 2
DELETE FROM vWEmployeesData WHERE EmployeeKey = 2;

-- Sisestame uue töötaja andmed vaatesse vWEmployeesData

INSERT INTO DimEmployee(EmployeeKey, FirstName) VALUES (2, 'Mikey'); 

-- Kuvame uuesti andmed vaatest vWEmployeesData
SELECT * FROM vWEmployeesData;

-- Loome vaate, et kuvada töötajaid osakondade järgi
CREATE VIEW vwEmployeeDetailsByDepartment
AS
SELECT E.EmployeeKey, E.FirstName, E.SickLeaveHours, ST.SalesTerritoryRegion
FROM DimEmployee E
JOIN DimSalesTerritory ST
ON E.SalesTerritoryKey = ST.SalesTerritoryKey; 

-- Kuvame andmed vaatest vwEmployeeDetailsByDepartment
SELECT * FROM vwEmployeeDetailsByDepartment;

-- Kustutame vaate vwEmployeeDetailsByDepartment
DROP VIEW vwEmployeeDetailsByDepartment;

UPDATE vwEmployeeDetailsBySalesTerritoryRegion
SET SalesTerritoryRegion = 'IT' WHERE FirstName = 'John';

-- Kuvame andmed uuesti vaates vwEmployeeDetailsBySalesTerritoryRegion
SELECT * FROM vwEmployeeDetailsBySalesTerritoryRegion;
