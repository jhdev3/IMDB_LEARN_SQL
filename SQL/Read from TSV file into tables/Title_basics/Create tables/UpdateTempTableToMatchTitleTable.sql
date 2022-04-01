--Update Temp Table To match TitleTable
--Tar lite Tid med Alter Tables

UPDATE dbo.tempDataTableTitle
SET startYear = NULL
WHERE startYear = '\N';

ALTER TABLE tempDataTableTitle
ALTER COLUMN startYear SMALLINT;

UPDATE dbo.tempDataTableTitle
SET endYear = NULL
WHERE endYear = '\N';

ALTER TABLE tempDataTableTitle
ALTER COLUMN endYear SMALLINT;


UPDATE tempDataTableTitle
SET runtimeMinutes = NULL
WHERE runtimeMinutes = '\N';

ALTER TABLE tempDataTableTitle
ALTER COLUMN runtimeMinutes INT;