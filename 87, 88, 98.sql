--87
-- Loome ja lisame andmed
CREATE TABLE TableA (
Id INT PRIMARY KEY,
Name NVARCHAR(50),
Gender NVARCHAR(10));
GO

INSERT INTO TableA (Id, Name, Gender)
VALUES
(1, 'Mark', 'Male'),
(2, 'Mary', 'Female'),
(3, 'Steve', 'Male'),
(4, 'John', 'Male'),
(5, 'Sara', 'Female');
GO

CREATE TABLE TableB(
Id INT PRIMARY KEY,
Name NVARCHAR(50),
Gender NVARCHAR(10));
GO

INSERT INTO TableB (Id, Name, Gender)
VALUES
(4, 'John', 'Male'),
(5, 'Sara', 'Female'),
(6, 'Pam', 'Female'),
(7, 'Rebeka', 'Female'),
(8, 'Jordan', 'Male');
GO

SELECT * FROM TableA;
SELECT * FROM TableB;

-- Järgmine päring tagastab unikaalsed read vasakust tabelist, mida ei ole paremas tabelis.
Select Id,Name,Gender
From TableA
Except
Select Id,Name,Gender
From TableB

-- Loome ja lisame andmed
Create table tblEmployees(
Id int identity primary key,
Name nvarchar(100),
Gender nvarchar(10),
Salary int)
Go

Insert into tblEmployees values ('Mark', 'Male', 52000)
Insert into tblEmployees values ('Mary', 'Female', 55000)
Insert into tblEmployees values ('Steve', 'Male', 45000)
Insert into tblEmployees values ('John', 'Male', 40000)
Insert into tblEmployees values ('Sara', 'Female', 48000)
Insert into tblEmployees values ('Pam', 'Female', 60000)
Insert into tblEmployees values ('Tom', 'Male', 58000)
Insert into tblEmployees values ('Georg', 'Male', 65000)
Insert into tblEmployees values ('Tina', 'Female', 67000)
Insert into tblEmployees values ('Ben', 'Male', 80000)
Go

Select * from tblEmployees

-- Order by klauslit võib kasutada ainult üks kord pärast teist päringut:
SELECT Id, Name, Gender, Salary
FROM tblEmployees 
WHERE Salary >= 50000
Except 
SELECT Id, Name, Gender, Salary
FROM tblEmployees
WHERE Salary >= 60000
order by Name

--88
-- Järgmine päring tagastab read vasakust tabelist, mida ei ole paremas
Select Id, Name, Gender FROM TableA
Except 
Select Id, Name, Gender From TableB

-- Sama tulemuse saab saavutada kasutades NOT IN operaatorit
SELECT Id, Name, Gender FROM TableA
WHERE Id NOT IN (Select Id From TableB)

-- Sisestame järgmise rea tabelisse TableA
Insert Into TableA values (1, 'Mark', 'Male')

-- Nüüd käivitame EXCEPT päringu

SELECT Id, Name, Gender FROM TableA
EXCEPT 
SELECT Id,Name,Gender From TableB

-- Nüüd käivitame NOT IN operaatoriga päringu
Select Id, Name, Gender From TableA
Where Id NOT IN (Select Id from TableB)

-- Järgnevas päringus on veergude arv teadlikult erinev
SELECT Id, Name, Gender From TableA
EXCEPT
Select Id, Name from TableB

-- Järgnevas päringus tagastab alampäring mitu veergu
Select Id, Name ,Gender From TableA
Where Id NOT IN (Select Id, Name from TableB)

--98 
-- Loome tabeli Sales ja lisame andmed
CREATE TABLE Sales(
Product NVARCHAR(50),
SaleAmount INT);
GO 

INSERT INTO Sales (Product, SaleAmount)
VALUES 
('iPhone', 500),
('Laptop', 800),
('iPhone', 1000),
('Speakers', 400),
('Laptop', 600);
GO

select * from Sales

-- Selleks, et arvutada toodete müügikogus, peame kasutama GROUP BY päringut:
SELECT Product, SUM(SaleAmount) as TotalSales
FROM Sales
GROUP BY Product

-- Kui soovime kuvada ainult need tooted, mille müügikogus ületab 1000€, kasutame HAVING tingimust.
SELECT Product, SUM(SaleAmount) as TotalSales
FROM Sales
GROUP BY Product
HAVING SUM(SaleAmount) > 1000

-- Kui kasutame WHERE klauselit HAVING asemel, saame süntaksivea. 
-- Põhjuseks on see, et WHERE ei tööta kokkuarvutavate funktsioonidega nagu SUM, MIN, MAX, AVG jne.
SELECT Product, SUM(SaleAmount) as TotalSales
FROM Sales
GROUP BY Product
WHERE SUM(SaleAmount) > 1000

-- Arvutame iPhone'i ja kõlarite müügikoguse, kasutades selleks HAVING klauslit. See päring kuvab ainult iPhone'i ja kõlarite müügi.
SELECT Product, SUM(SaleAmount) as TotalSales
FROM Sales
WHERE Product in ('iPhone', 'Speakers')
GROUP BY Product

-- Arvutame iPhone'i ja kõlarite müüki, kasutades HAVING klauslit. See päring kuvab ainult iPhone'i ja kõlarite müügi.
SELECT Product, SUM(SaleAmount) as TotalSales
FROM Sales
GROUP BY Product
HAVING Product in ('iPhone', 'Speakers')
