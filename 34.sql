-- Ajutise tabeli #PersonDetails loomine
Create Table #PersonDetails(Id int, Name nvarchar(20))

-- Andmete sisestamine ajutisse tabelisse
Insert into #PersonDetails Values(1, 'Mike')
Insert into #PersonDetails Values(2, 'John')
Insert into #PersonDetails Values(3, 'Todd')

-- Kontrollimine, kas ajutine tabel on loodud
Select name from tempdb..sysobjects 
where name like '#PersonDetails%'

-- Ajutise tabeli kustutamine
DROP TABLE #PersonDetails

-- Protseduuri loomine ajutise tabeli loomiseks
Create Procedure spCreateLocalTempTable
as
begin
-- Ajutise tabeli loomine
Create Table #PersonDetails(Id int, Name nvarchar(20))

-- Andmete sisestamine
Insert into #PersonDetails Values(1, 'Mike')
Insert into #PersonDetails Values(2, 'John')
Insert into #PersonDetails Values(3, 'Todd')

-- Andmete valimine
Select * from #PersonDetails
END

-- Globaalsete ajutiste tabeli ##EmployeeDetails loomine
Create Table ##EmployeeDetails(Id int, Name nvarchar(20))

-- Andmete sisestamine globaalsete tabelisse
Insert into ##EmployeeDetails Values(1, 'Alice')
Insert into ##EmployeeDetails Values(2, 'Bob')
Insert into ##EmployeeDetails Values(3, 'Charlie')

-- Kontrollimine, kas globaalne ajutine tabel on loodud
Select name from tempdb..sysobjects 
where name like '##EmployeeDetails%'

-- Andmete valimine globaalsetest tabelitest
Select * from ##EmployeeDetails
