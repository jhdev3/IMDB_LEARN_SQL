--Skapa tabellen InvolvedIn  utifr�n Principals CastCrewTitles CCT ;)

DROP TABLE IF EXISTS InvolvedIn;

CREATE TABLE InvolvedIn(
	title_Id VARCHAR(100) NOT NULL FOREIGN KEY REFERENCES Titles(title_Id),
	ordering TINYINT,
	person_Id VARCHAR(100) NOT NULL FOREIGN KEY REFERENCES People(person_Id),
	category VARCHAR(50),
	job NVARCHAR(400),
	characters NVARCHAR(500)
);

--Tog l�ng tid Hade varit b�ttre att Updatera Och �ndra TempTable :)
INSERT INTO InvolvedIn (title_Id, ordering, person_Id, category, job, characters) 
		SELECT tconst, ordering, nconst, category, job, characters FROM TempTitlePrincipals
		INNER JOIN Titles 
		on TempTitlePrincipals.tconst = Titles.title_Id
	    INNER JOIN People 
		on TempTitlePrincipals.nconst = People.person_Id;

DROP TABLE IF EXISTS TempTitlePrincipals; --Klar med den tabellen :)

/*
	
	Error Could not allocate space for object 'dbo.InvolvedIn' in database 'IMDB_DB' because the 'PRIMARY' filegroup
	L�ste det genom att Allocera mer mine till IMDB_DB finns en begr�nsning p� express sql p� 10GB ;) s� den �vre Qurin i s�g tar upp en hel del minne, har man inte tillr�ckligt ram kan den nedre l�sningen samt dela upp tabellen i 2-3 och k�ra i omg�ngar kan underl�tta.

	https://stackoverflow.com/questions/3384127/delete-sql-rows-where-ids-do-not-have-a-match-from-another-table
	En b�ttre l�sning hade varit att �ndra TempTitlePrincipals ta bort de rader som inte har en relation och sedan g�ra foreinkey etc
	Samt �ndra Namn p� tabell och kolumn;)
	
	Resultat : Tid 14 min :)
	(48 460 118 rows affected)

*/


--Kul Test se hur m�nga som ingick i cast/crew i Nyckeln till Frihet
SELECT * FROM InvolvedIn as II
INNER JOIN People
on II.person_Id = People.person_Id
INNER JOIN Titles
on II.title_Id = Titles.title_Id
WHERE original_title = 'The Shawshank Redemption' AND title_Type = 'movie'
ORDER BY ordering


--Tid 14 Sekunder Kanske b�r S�tta Index p� Foreign Keys;)
--Tid 1 Sekund med Index :)
--Test Med Index H�r finns det m�jligheter att g�ra CLUSTER som ska vara snabbare eftersom jag inte har PK samt G�r bara ha 1 per tabell dock vet jag inte hur bra det �r n�r det inte �r unika v�rden.:)

CREATE INDEX fk_title_Id--Gav bra resultat s� g�r det p� b�da FKs i den st�rsta tabellen :)
ON InvolvedIn (title_Id);

DROP INDEX fk_title_Id ON InvolvedIn;


CREATE INDEX fk_person_Id --Funger ej F�r mig f�r f�r Ont om plats 1178.59 MB Space kvar kan vara n�gon begr�nsing som sql express har etc. Kul att se drawback av Index samt L�sningen h�r kan vara att g�ra En till FilGroup eller l�gga denna tabell i eller dela upp tabeller i flera dbs
ON InvolvedIn (person_Id);

