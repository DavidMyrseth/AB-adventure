-- Tabeli DimEmployee loomine
Create table [DimEmployee] (
[Id] int Primary key, 
[Name] nvarchar(50),  
[Salary] int,         
[Gender] nvarchar(10),
[City] nvarchar(50))

-- Andmete sisestamine DimEmployee tabelisse
Insert into DimEmployee Values(3, 'John', 4500, 'Male', 'New York')
Insert into DimEmployee Values(1, 'Sam', 2500, 'Male', 'London')
Insert into DimEmployee Values(4, 'Sara', 5500, 'Female', 'Tokyo')
Insert into DimEmployee Values(5, 'Todd', 3100, 'Male', 'Toronto')
Insert into DimEmployee Values(2, 'Pam', 6500, 'Female', 'Sydney')

-- Andmete valimine DimEmployee tabelist
Select * from DimEmployee

-- Mitte-klasterdava indeksi loomine Nimi veerule
Create NonClustered Index IX_DimEmployee_Name
on DimEmployee(Name)

-- Indeksi kustutamine (teave indeksist võib olla vale)
Drop index DimEmployee.PK_DimEmployee_3214EC070A9D95DB

-- Klasterdava indeksi loomine Sugu ja Palk veerule
Create Clustered Index IX_DimEmployee_Gender_Salary
ON DimEmployee(Gender DESC, Salary ASC)

-- Mitte-klasterdava indeksi loomine Nimi veerule (korduv)
Create NonClustered Index IX_DimEmployee_Name
on DimEmployee(Name)
