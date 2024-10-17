-- Tootmisvaatluse loomine, mis käivitatakse, kui tabel luuakse
CREATE TRIGGER trDavidMyrsethTrigger
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
PRINT 'New table';  
END

-- Tabeli loomine
CREATE TABLE Crastikrab(Id int);

-- Tootmisvaatluse muutmine, et see reageeriks ka tabelite muutmisele ja kustutamisele
ALTER TRIGGER trDavidMyrsethTrigger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
PRINT 'Your table was created, you can modifie or delete'; 
END

-- Uuenda tootmisvaatlust, et see tühistaks kõik tegevused
ALTER TRIGGER trDavidMyrsethTrigger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK;
PRINT 'You cannot create, alter or drop a table';
END

-- Tootmisvaatluse keelamine
DISABLE TRIGGER trMyFirstTrigger ON DATABASE;

-- Tootmisvaatluse loomine nime muutmiseks
CREATE TRIGGER trRENAMETable
ON DATABASE
FOR RENAME
AS
BEGIN
PRINT 'You just renamed something';
END

--93

-- Teine tootmisvaatluse loomine, mis tühistab tegevused
CREATE TRIGGER tr_DavidMyrsethTrigger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK;
PRINT 'You cannot create, alter or drop a table in the current database';
END

-- Tootmisvaatluse loomine, mis tühistab tegevused serveri tasemel
CREATE TRIGGER tr_DavidMyrsethTrigger
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK;
PRINT 'You cannot create, alter or drop a table in any database on the server';
END

-- Tootmisvaatluse keelamine serveri tasemel
DISABLE TRIGGER tr_DavidMyrsethTrigger ON ALL SERVER;

-- Tootmisvaatluse lubamine serveri tasemel
ENABLE TRIGGER tr_DavidMyrsethTrigger ON ALL SERVER;

-- Tootmisvaatluse eemaldamine serveri tasemel
DROP TRIGGER tr_DavidMyrsethTrigger ON ALL SERVER;

--87

-- Tabeli loomine TableA
CREATE TABLE TableA(
id INT PRIMARY KEY,            
Name NVARCHAR(50),             
Gender NVARCHAR(10));
GO

-- Andmete sisestamine tabelisse TableA
INSERT INTO TableA VALUES (1, 'Mark', 'Male');
INSERT INTO TableA VALUES (2, 'Mary', 'Female');
INSERT INTO TableA VALUES (3, 'Steve', 'Male');
INSERT INTO TableA VALUES (4, 'John', 'Male');
INSERT INTO TableA VALUES (5, 'Sara', 'Female');

-- Tabeli loomine TableB
CREATE TABLE TableB(
id INT PRIMARY KEY,
Name NVARCHAR(50), 
Gender NVARCHAR(10));
GO

-- Andmete sisestamine tabelisse TableB
INSERT INTO TableB VALUES (4, 'John', 'Male');
INSERT INTO TableB VALUES (5, 'Sara', 'Female');
INSERT INTO TableB VALUES (6, 'Pam', 'Female');
INSERT INTO TableB VALUES (7, 'Rebeka', 'Female');
INSERT INTO TableB VALUES (8, 'Jordan', 'Male');
GO

-- Andmete valimine, mis on ainult tabelis TableA, kuid mitte tabelis TableB
SELECT id, Name, Gender
FROM TableA
EXCEPT
SELECT id, Name, Gender
FROM TableB;

-- Tabeli loomine tblEmployees
CREATE TABLE tblEmployees(
id INT IDENTITY PRIMARY KEY,
Name NVARCHAR(100),         
Gender NVARCHAR(10),        
Salary INT);
GO

-- Andmete sisestamine tabelisse tblEmployees
INSERT INTO tblEmployees VALUES ('Mark', 'Male', 52000);
INSERT INTO tblEmployees VALUES ('Mary', 'Female', 55000);
INSERT INTO tblEmployees VALUES ('Steve', 'Male', 45000);
INSERT INTO tblEmployees VALUES ('John', 'Male', 40000);
INSERT INTO tblEmployees VALUES ('Sara', 'Male', 48000);
INSERT INTO tblEmployees VALUES ('Pam', 'Female', 60000);
INSERT INTO tblEmployees VALUES ('Tom', 'Male', 58000);
INSERT INTO tblEmployees VALUES ('Georg', 'Male', 65000);
INSERT INTO tblEmployees VALUES ('Tina', 'Female', 67000);
INSERT INTO tblEmployees VALUES ('Ben', 'Male', 80000);
GO

-- Valige töötajad, kelle palk on vähemalt 50000, kuid vähem kui 60000
SELECT id, Name, Gender, Salary
FROM tblEmployees
WHERE Salary >= 50000
EXCEPT
SELECT id, Name, Gender, Salary
FROM tblEmployees
WHERE Salary >= 60000
ORDER BY Name;

--88

-- Valige töötajad tabelist TableA, mis ei ole tabelis TableB
SELECT id, Name, Gender FROM TableA
EXCEPT
SELECT id, Name, Gender FROM TableB;

-- Valige töötajad tabelist TableA, kes ei ole tabelis TableB
SELECT id, Name, Gender FROM TableA
WHERE id NOT IN (SELECT id FROM TableB);

-- Valige töötajad, kelle id ei ole tabelis TableB
INSERT INTO TableA VALUES (1, 'Mark', 'Male');

SELECT id, Name, Gender FROM TableA
EXCEPT 
SELECT id, Name, Gender FROM Table;

SELECT id, Name, Gender FROM TableA
WHERE id NOT IN (SELECT id FROM TableB);

--98

SELECT id, Name, Gender FROM TableA
EXCEPT
SELECT id, Name FROM TableB;

SELECT id, Name, Gender FROM TableA
WHERE id NOT IN (SELECT id, Name FROM TableB);

-- Tabeli loomine Sales
CREATE TABLE Sales(
    Product NVARCHAR(50),           -- Toode
    SaleAmount INT                  -- Müügi summa
);
GO

-- Andmete sisestamine tabelisse Sales
INSERT INTO Sales VALUES ('iPhone', 500);
INSERT INTO Sales VALUES ('Laptop', 800);
INSERT INTO Sales VALUES ('iPhone', 1000);
INSERT INTO Sales VALUES ('Speaker', 400);
INSERT INTO Sales VALUES ('Laptop', 600);
GO

-- Müügi summa kokku arvestamine toote kaupa
SELECT Product, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY Product;

-- Müügi summa üle 1000 arvestamine
SELECT Product, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY Product 
HAVING SUM(SaleAmount) > 1000;

-- Müügi summa toote nime alusel
SELECT Product, SUM(SaleAmount) AS TotalSales
FROM Sales
WHERE Product IN ('iPhone', 'Speakers')
GROUP BY Product;

-- Müügi summa toote nime alusel, kuid vale süntaks
SELECT Product, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY Product
WHERE Product IN ('iPhone', 'Speakers');  -- Siin on viga, GROUP BY peab olema enne WHERE
