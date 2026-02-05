use international_debt_db;

select * from dbo.IDSCountry;

ALTER TABLE dbo.IDSCountry
DROP COLUMN column32;

select * from dbo.[IDSCountry-Series];

ALTER TABLE dbo.[IDSCountry-Series]
DROP COLUMN column4;

select * from dbo.IDSFootNote;

ALTER TABLE dbo.IDSFootNote
DROP COLUMN column5;

select * from dbo.IDSSeries;

ALTER TABLE dbo.IDSSeries
DROP COLUMN column21;

select * from dbo.[IDSSeries-Time];

ALTER TABLE dbo.[IDSSeries-Time]
DROP COLUMN column4;

select * from dbo.IDSData;

DELETE FROM dbo.IDSData
WHERE country_name = 'Country Name';

