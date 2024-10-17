-- Tabeli DimEmployee loomine
Create table [DimEmployee] (
[Id] int Primary key, 
[Name] nvarchar(50),  
[Salary] int,         
[Gender] nvarchar(10),
[City] nvarchar(50))

-- Indeksite kuvamine tblEmployee tabelis
Execute sp_helpindex 'tblEmployee'

-- Andmete sisestamine tblEmployee tabelisse
Insert into tblEmployee Values(1, 'Mike', 4500, 'Male', 'New York')
Insert into tblEmployee Values(1, 'John', 2500, 'Male', 'London')

-- Indeksi kustutamine (vea tõttu võib olla vale)
Drop index tblEmployee.PK_tblEmplo_3214ECO7236943A5

-- Andmete uuesti sisestamine tblEmployee tabelisse
Insert into tblEmployee Values(1, 'Mike', 'Sandoz', 4500, 'Male', 'New York')
Insert into tblEmployee Values(1, 'John', 'Menco', 2500, 'Male', 'London')

-- Unikaalse piirangu lisamine City veerule
ALTER TABLE tblEmployee 
ADD CONSTRAINT UQ_tblEmployee_City 
UNIQUE NONCLUSTERED (City)

-- Unikaalse indeksi loomine City veerule
CREATE UNIQUE INDEX IX_tblEmployee_City
ON tblEmployee(City)
WITH IGNORE_DUP_KEY