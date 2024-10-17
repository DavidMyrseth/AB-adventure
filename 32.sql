-- Inline TVF, mis tagastab tabeli
CREATE FUNCTION fn_ILTVF_GetEmployees()
RETURNS TABLE
AS
RETURN (
SELECT EmployeeKey, FirstName, CAST(BirthDate AS DATE) AS DOB
FROM DimEmployee
);

-- Multi-Statement TVF, mis kasutab vahepealset tabelimuutujat
Create Function fn_MSTVF_GetEmployees()
Returns @Table Table (EmployeeKey int, FirstName nvarchar(20), DOB Date)
as
Begin
Insert into @Table
Select EmployeeKey, FirstName, Cast(BirthDate as Date)
From DimEmployee
Return
End

-- Funktsioonide väljakutsumine
Select * from fn_ILTVF_GetEmployees()
Select * from fn_MSTVF_GetEmployees()
