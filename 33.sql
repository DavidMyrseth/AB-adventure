-- Tabeli tblEmployees loomine
CREATE TABLE [dbo].[tblEmployees] (
id INT PRIMARY KEY,       
Name NVARCHAR(50) NULL,   
DateOfBirth DATETIME NULL,
Gender NVARCHAR(10) NULL, 
DepartmentId INT NULL     
);

-- Andmete lisamine tblEmployees
INSERT INTO tblEmployees VALUES (1, 'Sam', '1980-12-30 00:00:00.000', 'Male', 1);
INSERT INTO tblEmployees VALUES (2, 'Pam', '1982-09-01 12:02:36.260', 'Female', 2);
INSERT INTO tblEmployees VALUES (3, 'John', '1985-08-22 12:03:30.370', 'Male', 1);
INSERT INTO tblEmployees VALUES (4, 'Sara', '1979-11-29 12:59:30.670', 'Female', 3);
INSERT INTO tblEmployees VALUES (5, 'Todd', '1978-11-29 12:59:30.670', 'Male', 3);

-- Funktsiooni loomine, mis tagastab töötaja nime ID järgi
CREATE FUNCTION fn_GetEmployeeNameById(@Id INT)
RETURNS NVARCHAR(20)
AS
BEGIN
RETURN (SELECT Name FROM tblEmployees WHERE id = @Id);
END;

-- Funktsiooni muutmine krüpteerimisega
ALTER FUNCTION fn_GetEmployeeNameById(@Id INT)
RETURNS NVARCHAR(20)
WITH ENCRYPTION
AS
BEGIN
RETURN (SELECT Name FROM tblEmployees WHERE id = @Id);
END;

-- Funktsiooni muutmine skeemi sidumise ja krüpteerimisega
ALTER FUNCTION fn_GetEmployeeNameById(@Id INT)
RETURNS NVARCHAR(20)
WITH SCHEMABINDING, ENCRYPTION
AS
BEGIN
RETURN (SELECT Name FROM dbo.tblEmployees WHERE id = @Id);
END;
