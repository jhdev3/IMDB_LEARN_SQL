--PersonTable
DROP TABLE IF EXISTS People
CREATE TABLE People (
	person_Id VARCHAR(100) PRIMARY KEY,
	person_Name NVARCHAR(150),
	birth_Year SMALLINT,
	death_Year SMALLINT,
); 

--Finns sätt att även filtera denna tabell utifrån vad jag vill query osv men här känns det inte riktigt relvant att uföra det jobbet
INSERT INTO People(person_Id, person_Name, birth_Year, death_Year)
SELECT nconst, primaryName, birthYear, deathYear FROM TempNameBasic
WHERE nconst is not null

--(11 512 537 rows affected) = Lyckad Insert



