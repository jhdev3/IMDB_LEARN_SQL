--Writers Tabell Many to Many Mellan Titles och People Samma Som Directors

DROP TABLE IF EXISTS Writers;

CREATE TABLE Writers(
	title_Id  VARCHAR(100) NOT NULL FOREIGN KEY REFERENCES Titles(title_Id),
	person_Id VARCHAR(100) NOT NULL FOREIGN KEY REFERENCES People(person_Id)
);

--Insert i 2 steg eftersom det ska bli en Many to Many och kan bli lite färre rader samt att det blir lite otydligt och ondöigt krångligt value ska jämföras med People tabellen direct 

--Steg 1
SELECT title_Id, value as person_Id INTO TempWriters
FROM TempTitleCrew  
CROSS APPLY STRING_SPLIT(TempTitleCrew.writers, ',')
INNER JOIN Titles
ON tconst = title_Id --Kolla FK_Title_Id

--Resultat (14 358 218 rows affected) Tid 49 sekunder


--Steg 2 filtera bort \N samt kolla relationen till People tabellen

INSERT INTO Writers(title_Id, person_Id)
	SELECT W.title_Id, W.person_Id FROM TempWriters as W
	INNER JOIN People 
	on W.person_Id = People.person_Id;
--(10 316 463 rows affected)


SELECT COUNT(*) FROM Writers
INNER JOIN People
ON Writers.person_Id = People.person_Id
WHERE person_Name like '%Steven Spielberg%'
--Resultat 88

SELECT COUNT(*) FROM TempWriters
INNER JOIN People
ON TempWriters.person_Id = People.person_Id
WHERE person_Name like '%Steven Spielberg%'
--Resultat 88 :)

DROP TABLE TempWriters; --behövs inte mer:)

DROP TABLE TempTitleCrew;--Ta bort när Writers Och Directors är Klara :)
