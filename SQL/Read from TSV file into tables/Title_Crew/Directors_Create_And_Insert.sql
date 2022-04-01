--Directors Tabell Many to Many Mellan Titles och People

DROP TABLE IF EXISTS Directors;

CREATE TABLE Directors(
	title_Id  VARCHAR(100) NOT NULL FOREIGN KEY REFERENCES Titles(title_Id),
	person_Id VARCHAR(100) NOT NULL FOREIGN KEY REFERENCES People(person_Id)
);

--Insert i 2 steg eftersom det ska bli en Many to Many och kan bli lite f�rre rader samt att det blir lite otydligt och ond�igt kr�ngligt value ska j�mf�ras med People tabellen direct 

--Steg 1
SELECT title_Id, value as person_Id INTO TempDirectors
FROM TempTitleCrew  
CROSS APPLY STRING_SPLIT(TempTitleCrew.directors, ',')
INNER JOIN Titles
ON tconst = title_Id --Kolla FK_Title_Id
--Resultat (10 098 180 rows affected)


INSERT INTO Directors(title_Id, person_Id)
	SELECT D.title_Id, D.person_Id FROM TempDirectors as D
	INNER JOIN People 
	on D.person_Id = People.person_Id;
--(6 509 101 rows affected) inte riktigt vad jag f�rv�ntade mig, Men h�r �r det alla \N som f�rsvinner vilket sparar lite plats p� h�rdsiken :) Samt underl�tter vid s�kningar etc

--Lite Tests

--Query 1: 71 Resultat -- Inte Riktigt samma resultat som Imdb och g� in p� Steven Spielberg men finns n�gra som heter AKA Steven Spielberg osv, Om han har gjort n�got under annat namn etc;)
--Enligt IMDB b�r det var 51 men h�r kan det som sagt ge fler person_Ids men huvudsaken �r att Query 1 och 2 ger samma resultat. 
SELECT COUNT(*) FROM Directors
INNER JOIN People
ON Directors.person_Id = People.person_Id
WHERE person_Name like '%Steven Spielberg%'

--71 -Query 2
SELECT COUNT(*) FROM TempDirectors
INNER JOIN People
ON TempDirectors.person_Id = People.person_Id
WHERE person_Name like '%Steven Spielberg%'


DROP TABLE TempDirectors; --beh�vs inte mer:)

