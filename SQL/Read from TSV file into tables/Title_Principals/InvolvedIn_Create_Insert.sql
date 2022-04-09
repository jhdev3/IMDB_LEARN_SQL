--Skapa tabellen InvolvedIn  utifrån Principals CastCrewTitles CCT ;)

DROP TABLE IF EXISTS InvolvedIn;

CREATE TABLE InvolvedIn(
	title_Id VARCHAR(100) NOT NULL FOREIGN KEY REFERENCES Titles(title_Id),
	ordering TINYINT,
	person_Id VARCHAR(100) NOT NULL FOREIGN KEY REFERENCES People(person_Id),
	category VARCHAR(50),
	job NVARCHAR(400),
	characters NVARCHAR(500)
);

--Tog lång tid Hade varit bättre att Updatera Och Ändra TempTable :)
INSERT INTO InvolvedIn (title_Id, ordering, person_Id, category, job, characters) 
		SELECT tconst, ordering, nconst, category, job, characters FROM TempTitlePrincipals
		INNER JOIN Titles 
		on TempTitlePrincipals.tconst = Titles.title_Id
	    INNER JOIN People 
		on TempTitlePrincipals.nconst = People.person_Id;

DROP TABLE IF EXISTS TempTitlePrincipals; --Klar med den tabellen :)

/*
	
	Error Could not allocate space for object 'dbo.InvolvedIn' in database 'IMDB_DB' because the 'PRIMARY' filegroup
	Löste det genom att Allocera mer mine till IMDB_DB finns en begränsning på express sql på 10GB ;) så den övre Qurin i säg tar upp en hel del minne, har man inte tillräckligt ram kan den nedre lösningen samt dela upp tabellen i 2-3 och köra i omgångar kan underlätta.

	https://stackoverflow.com/questions/3384127/delete-sql-rows-where-ids-do-not-have-a-match-from-another-table
	En bättre lösning hade varit att ändra TempTitlePrincipals ta bort de rader som inte har en relation och sedan göra foreinkey etc
	Samt Ändra Namn på tabell och kolumn;)
	
	Resultat : Tid 14 min :)
	(48 460 118 rows affected)

*/


--Kul Test se hur många som ingick i cast/crew i Nyckeln till Frihet
SELECT * FROM InvolvedIn as II
INNER JOIN People
on II.person_Id = People.person_Id
INNER JOIN Titles
on II.title_Id = Titles.title_Id
WHERE original_title = 'The Shawshank Redemption' AND title_Type = 'movie'
ORDER BY ordering


--Tid 14 Sekunder Kanske bör Sätta Index på Foreign Keys;)
--Tid 1 Sekund med Index :)
--Test Med Index Här finns det möjligheter att göra CLUSTER som ska vara snabbare eftersom jag inte har PK samt Går bara ha 1 per tabell dock vet jag inte hur bra det är när det inte är unika värden.:)

CREATE INDEX fk_title_Id--Gav bra resultat så gör det på båda FKs i den största tabellen :)
ON InvolvedIn (title_Id);

DROP INDEX fk_title_Id ON InvolvedIn;


CREATE INDEX fk_person_Id --Funger ej För mig för får Ont om plats 1178.59 MB Space kvar kan vara någon begränsing som sql express har etc. Kul att se drawback av Index samt Lösningen här kan vara att göra En till FilGroup eller lägga denna tabell i eller dela upp tabeller i flera dbs
ON InvolvedIn (person_Id);

