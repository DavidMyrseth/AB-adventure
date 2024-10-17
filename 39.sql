-- Tabeli tblEmployee loomine
Create table tblEmployee (
[Id] int Primary key, 
[Name] nvarchar(50),  
[Salary] int,         
[Gender] nvarchar(10),
[City] nvarchar(50))

-- Tabeli tblDepartament loomine
Create table tblDepartament (
DeptId int Primary Key,
DeptName nvarchar(20))

-- Andmete sisestamine tblDepartament tabelisse
Insert into tblDepartament values(1, 'IT')
Insert into tblDepartament values(2, 'PayRoll')
Insert into tblDepartament values(3, 'HR')
Insert into tblDepartament values(4, 'Admin')

-- Andmete sisestamine tblEmployee tabelisse
Insert into tblEmployee values(1, 'John', 5000, 'Male', 3)
Insert into tblEmployee values(2, 'Mike', 3400, 'Male', 2)
Insert into tblEmployee values(3, 'Pam', 6000, 'Female', 1)
Insert into tblEmployee values(4, 'Todd', 4800, 'Male', 4)
Insert into tblEmployee values(5, 'Sara', 3200, 'Female', 1)
Insert into tblEmployee values(6, 'Ben', 4800, 'Male', 3)

-- Andmete valimine DimEmployee tabelist
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup 
ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName;

-- Vaate loomine töötajate rühmitamiseks osakonna järgi
CREATE VIEW vWeEmployeesByDepartment AS
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupName;

-- Vaate valimine
SELECT * FROM vWeEmployeesByDepartment

-- Vaate loomine IT osakonna töötajate jaoks
CREATE VIEW vWITDepartment_Employees AS
SELECT EmployeeKey, FirstName, BaseRate, Gender, DepartmentName
FROM DimEmployee
JOIN DimDepartmentGroup ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey 
WHERE DimDepartmentGroup.DepartmentGroupName = 'IT';

-- Vaate loomine mitteconfidentsiaalsete andmete jaoks
Create View vWEmployeesNonConfidentialData AS
SELECT Id, Name, Gender, DeptName
FROM tblEmployee
JOIN tblDepartament ON tblEmployee.DepartmentId = tblDepartament.DeptId

-- Vaate loomine töötajate arvu rühmitamiseks osakonna järgi
CREATE VIEW vWEMployeesCountByDepartment AS
SELECT DepartmentGroupName, 
COUNT(EmployeeKey) AS TotalEmployees
FROM DimEmployee
JOIN DimDepartmentGroup ON DimEmployee.DepartmentName = DimDepartmentGroup.DepartmentGroupKey 
GROUP BY DepartmentGroupName
