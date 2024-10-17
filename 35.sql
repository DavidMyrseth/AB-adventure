-- Andmete valimine DimEmployee tabelist, kus BaseRate on vahemikus 50 ja 70
Select * from DimEmployee where BaseRate > 50 and BaseRate < 70

-- Indeksi loomine DimEmployee.BaseRate veerule
Create Index IX_DimEmployee_BaseRate
on DimEmployee (BaseRate ASC)

-- Tabeli DimEmployee struktuuri kuvamine
Execute sp_helptext DimEmployee

-- Indeksi kustutamine DimEmployee tabelist
Drop Index DimEmployee.IX_DimEmployee_BaseRate
