-- Tabeli DimEmploye loomine
Create table DimEmploye (
[Id] int Primary key, 
[Name] nvarchar(50),  
[Salary] int,         
[Gender] nvarchar(10),
[City] nvarchar(50))

-- Andmete sisestamine DimEmploye tabelisse
Insert into DimEmploye Values(1, 'Mike', 'Snadoz', 4500, 'Male', 'New York')
Insert into DimEmploye Values(2, 'Sara', 'Menco', 6500, 'Female', 'New York')
Insert into DimEmploye Values(3, 'John', 'Barber', 2500, 'Male', 'New York')
Insert into DimEmploye Values(4, 'Pam', 'Grove', 3500, 'Female', 'New York')
Insert into DimEmploye Values(5, 'James', 'Mirch', 7500, 'Male', 'New York')

-- Mitte-klasterdava indeksi loomine palkadele
Create NonClustered Index IX_Dimploye_Salary
on DimEmploye (Salary Asc)

-- Andmete valimine palkade vahel 4000 ja 8000
Select * from DimEmploye where Salary > 4000 and Salary < 8000

-- Andmete kustutamine, kus palk on 2500
Delete from DimEmploye where Salary = 2500

-- Palkade uuendamine, kus palk on 7500
Update DimEmploye Set Salary = 9000 where Salary = 7500

-- Tabeli DimEmployee valimine (tabeli nimi on vale, see peaks olema DimEmploye)
SELECT * FROM DimEmploye ORDER BY Salary

-- DimEmploye tabeli andmete valimine järjestatud palga järgi kahanevalt
Select * from DimEmploye order by Salary Desc

-- Palga ja palga arvu rühmitamine
Select Salary, COUNT(Salary) as Total 
from DimEmploye 
Group By Salary