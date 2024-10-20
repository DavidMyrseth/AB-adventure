--32 
-- Tabelit tagastava funktsiooni näide e Inline Table-Valued Function (ILTVF):
create function fn_ILTVF_GetEmployees()
Returns Table
as
Return (Select EmployeeKey, FirstName, Cast(BirthDate as Date) as DOB
From DimEmployee)

-- Mitu avaldist kasutav tabelit tagastav funktsioon e multi-statement table-valued function (MSTVF):
create function fn_MSTVF_GetEmployees()
Returns @Table table (EmployeeKey int, FirstName nvarchar(20), DOB Date)
as
begin
insert into @Table
Select EmployeeKey, FirstName, CAST(BirthDate as Date)
From DimEmployee
return
End

-- Kui soovid mõlemat funktsiooni välja kutsuda, siis kasutad järgmisi käske:
Select * from fn_ILTVF_GetEmployees()
Select * from fn_MSTVF_GetEmployees()

-- Uuendame tabelit ja kasutame selleks ILTVF funktsiooni:
Update fn_ILTVF_GetEmployees() set FirstName='Sam1' where EmployeeKey=1;
Select * from fn_ILTVF_GetEmployees()

--33 
-- Lihtne skaleeritav funktsioon ilma krüpteerimata:
Create Function fn_GetEmpoyeeNameById(@Id int)
Returns nvarchar(20)
as
Begin
return (Select FirstName From DimEmployee Where EmployeeKey = @Id)
END

-- Funktsiooni sisu vaatamine:
sp_helptext fn_GetEmployeeNameById

-- Nüüd muudame funktsiooni ja krüpteerime selle:
Alter Function fn_GetEmployeeNameById(@Id int)
Returns nvarchar(20)
With Encryption
as
Begin
return (Select FirstName from DimEmployee where EmployeeKey = @Id)
END

-- Muudame funktsiooni, lisades SCHEMABINDING valiku:
Alter function fn_GetEmpoyeeNameById(@Id int)
Returns nvarchar(20)
With SchemaBinding
as
begin
Return (Select FirstName from DimEmployee where EmployeeKey = @Id)
END

--34 
-- Kohaliku ajutise tabeli loomine:
Create Table #DimEmployee(EmployeeKey int, FirstName nvarchar(20))

-- Andmete sisestamine ajutisse tabelisse:
Insert into #DimEmployee VALUES(1, 'Mike')
Insert into #DimEmployee VALUES(2, 'John')
Insert into #DimEmployee VALUES(3, 'Todd')

-- Vaata ajutise tabeli sisu:
Select * from #DimEmployee

-- Kuidas kontrollida, kas ajutine tabel on loodud?
SELECT FirstName FROM AdventureWorksDW2019..sysobjects
WHERE FirstName LIKE '#DimEmployee%';

-- Kohaliku ajutise tabeli loomiseks protseduuri näide:
Create procedure spCreateLocalTempTable
as
Begin
Create Table #DimEmployee(EmployeeKey int, FirstName nvarchar(20));
INSERT INTO #DimEmployee VALUES(1, 'Mike');
INSERT INTO #DimEmployee VALUES(2, 'John');
INSERT INTO #DimEmployee VALUES(3, 'Todd');
Select * From #DimEmployee
END

-- Kuidas luua globaalset ajutist tabelit:
CREATE TABLE ##EmployeeDetails(Id int, Name nvarchar(20))

INSERT INTO ##EmployeeDetails(Id, Name)
SELECT EmployeeKey, FirstName 
FROM dbo.DimEmployee
