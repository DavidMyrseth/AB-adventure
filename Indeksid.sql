-- Indeksid.sql
-- Soovime leida kõik töötajad, kelle palk on vahemikus 50 kuni 70
Create index IX_DimEmployee_Salary
on DimEmployee (BaseRate ASC)

Select * from DimEmployee where BaseRate > 5000 and BaseRate < 7000

-- Kui soovid vaadata indeksit
EXEC sp_help 'DimEmployee'; 

-- Kui soovid kustutada indeksi
drop Index DimEmployee.IX_tblEmployee_Salary

--36
-- Klastreeritud ja mitte-klastreeritud indeksid

-- Unikaalse klastreeritud indeksi loomise näide Id veerus.
execute sp_helpindex DimEmployee

-- Vaatame DimEmployee tabelit
Select * from DimEmployee

-- Selle tulemusena SQL server ei luba luua rohkem kui ühte klastreeritud indeksit tabeli kohta. Järgnev skript annab veateate.
Create Clustered Index IX_DimEmpoyee_Name
on DimEmployee(FirstName)

-- Nüüd loome klastreeritud indeksi kahe veeru põhjal. Selleks peame enne kustutama praeguse klastreeritud indeksi Id veerus:
Drop index DimEmployee

-- Nüüd käivitame järgmise koodi, et luua uus klastreeritud ühendindeks Gender ja Salary veergudel
CREATE CLUSTERED INDEX IX_DimEmployee_Gender_Salary
ON DimEmployee(Gender DESC, BaseRate ASC);

-- Järgmine kood loob mitteklastreeritud indeksi Name veeru põhjal DimEmployee tabelis
Create NonClustered Index IX_DimEmployee_Name
On DimEmployee (FirstName)

--37
-- Unikaalne ja mitte-unikaalne indeks

-- Kuvame DimEmployee tabeli indeksite teavet
EXEC sp_helpIndex DimEmployee

-- Lisame uusi töötajaid DimEmployee tabelisse
INSERT INTO DimEmployee (FirstName, LastName, BaseRate, Gender)
VALUES ('Mike', 'Sandoz', 4400, 'M')
INSERT INTO DimEmployee (FirstName, LastName, BaseRate, Gender)
VALUES ('John', 'Menco', 2500, 'M')

-- Kuvame kõik töötajad DimEmployee tabelist
SELECT * FROM DimEmployee

-- Loome ainulaadse mitteklastreeritud indeksi FirstName ja LastName jaoks
CREATE UNIQUE NONCLUSTERED INDEX UIX_DimEmployee_FirstName_LastName
ON DimEmployee (FirstName, LastName)

-- Lisame tabelisse ainulaadse piirangu EmployeeNationalIDAlternateKey jaoks
ALTER TABLE DimEmployee 
ADD CONSTRAINT UQ_DimEmployee_EmployeeNationalID
UNIQUE NONCLUSTERED (EmployeeNationalIDAlternateKey);

-- Kuvame DimEmployee tabeli piirangute teabe
EXECUTE SP_HELPCONSTRAINT DimEmployee

-- Kuvame kõik DimEmployee tabeli veerud
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'DimEmployee';

-- Loome ainulaadse indeksi EmployeeNationalIDAlternateKey jaoks
CREATE UNIQUE INDEX IX_DimEmployee_City
ON DimEmployee (EmployeeNationalIDAlternateKey)
WITH IGNORE_DUP_KEY

--38
-- Indeksi eelised ja puudused

-- Loome mitteklastreeritud indeksi BaseRate veeru põhjal
CREATE NONCLUSTERED INDEX IX_DimEmployee_BaseRate
ON DimEmployee (BaseRate ASC)

-- Kuvame töötajad, kelle BaseRate on vahemikus 4000 kuni 8000
SELECT * FROM DimEmployee WHERE BaseRate > 4000 AND BaseRate < 8000

-- Kustutame töötaja, kelle BaseRate on 2500
DELETE FROM DimEmployee WHERE BaseRate = 2500

-- Uuendame töötaja BaseRate väärtust 7500-lt 9000-le
UPDATE DimEmployee SET BaseRate = 9000 WHERE BaseRate = 7500

-- Kuvame kõik töötajad, sorteerituna BaseRate järgi kasvavas järjekorras
SELECT * FROM DimEmployee ORDER BY BaseRate

-- Kuvame kõik töötajad, sorteerituna BaseRate järgi kahanevas järjekorras
SELECT * FROM DimEmployee ORDER BY BaseRate DESC

-- Kuvame BaseRate ja nende arvu DimEmployee tabelis
SELECT BaseRate, COUNT(BaseRate) AS Total
FROM DimEmployee
GROUP BY BaseRate
