--92 
-- DDL-trigger SQL
-- Loome esmalt triggeri, mis käivitub uue tabeli loomisel
CREATE TRIGGER trMyFirstTrigger
ON DATABASE
FOR CREATE_TABLE
AS
BEGIN
PRINT 'Uus tabel loodud'
END

-- Loome testtabeli
CREATE TABLE Test(Id int);

-- Muudame triggerit, et see käivituks ka tabeli muutmise ja kustutamise korral
ALTER TRIGGER trMyFirstTrigger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
PRINT 'Tabel loodi, muudeti või kustutati'
END

-- Kustutame testtabeli
DROP TABLE Test;

-- Proovime muuta tabelit, mis on juba kustutatud
ALTER TABLE Test ADD Makaka int; -- See tekitab vea, kuna tabelit ei eksisteeri

-- Muudame triggerit, et see tagastaks teate ja tühistaks muudatused
ALTER TRIGGER trMyFirstTrigger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK -- Tühistame muudatused
PRINT 'Sa ei saa tabelit luua, muuta ega kustutada'
END

-- Proovime jälle tabelit kustutada
DROP TABLE Test;

-- Loome uue tabeli Test2
CREATE TABLE Test2(Id int);

-- Proovime taas tabelit muuta
ALTER TABLE Test ADD Makaka2 int;

-- Deaktiveerime triggeri
DISABLE TRIGGER trMyFirstTrigger ON DATABASE;

-- Kustutame triggeri
DROP TRIGGER trMyFirstTrigger ON DATABASE;

-- Loome triggeri, mis käivitub tabeli ümbernimetamisel
CREATE TRIGGER trRenameTable
ON DATABASE
FOR RENAME
AS
BEGIN
PRINT 'Sa just nimetasid midagi ümber'
END

-- Muudame tabeli nime
sp_rename 'Test', 'NewTestTable';

--93 
-- Serveri ulatuses DDL-triggerid
-- Loome andmebaasi ulatuses triggeri
CREATE TRIGGER tr_DatabaseScopeTrigger
ON DATABASE
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
PRINT 'Sa ei saa praeguses andmebaasis tabelit luua, muuta ega kustutada'
END

-- Keelame andmebaasi ulatuses triggeri
DISABLE TRIGGER tr_DatabaseScopeTrigger ON DATABASE

-- Lubame andmebaasi ulatuses triggeri
ENABLE TRIGGER tr_DatabaseScopeTrigger ON DATABASE

-- Proovime tabelit "test" luua
CREATE TABLE test(id int);

-- Loome serveri ulatuses triggeri
CREATE TRIGGER tr_ServerScopeTrigger
ON ALL SERVER
FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
BEGIN
ROLLBACK
PRINT 'Sa ei saa üheski serveri andmebaasis tabelit luua, muuta ega kustutada'
END

-- Keelame serveri ulatuses triggeri
DISABLE TRIGGER tr_ServerScopeTrigger ON ALL SERVER

-- Lubame serveri ulatuses triggeri
ENABLE TRIGGER tr_ServerScopeTrigger ON ALL SERVER

-- Kustutame serveri ulatuses triggeri
DROP TRIGGER tr_ServerScopeTrigger ON ALL SERVER;
