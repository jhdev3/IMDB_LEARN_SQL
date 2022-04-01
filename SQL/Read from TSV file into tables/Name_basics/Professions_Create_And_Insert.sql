--Create ProfessionTable one to Many relation.
--Finns en anleding till att g�ra en Tabell med namnet "Jobs" och g�ra Profession table Many to Many d� title.principals
-- D�r det finns category (string) - the category of job that person was in 
--I dessa Columner skulle det kunna finnas en relation Mellan Profession och Category
--Men att skapa den tabellen och skapa relation mellan dem k�nner jag att den tiden som kr�vs inte �r v�rt det. Men v�rt att p�peka i alla fall.


DROP TABLE IF EXISTS Professions;

CREATE TABLE Professions(
	
	person_Id VARCHAR(100) FOREIGN KEY REFERENCES People(person_Id), --Kan finnas sk�l till att g�ra FK indexerad. f�r att snabba upp Queries
	profession_Name NVARCHAR(50) 
);

--Samma Query som f�r Genere bara h�r k�nner jag att det blir enklare med One to Many s� har d� ett enkelt namn p� Tabellen.
INSERT INTO Professions (person_Id, profession_Name)
SELECT nconst, value as p 
FROM TempNameBasic  
CROSS APPLY STRING_SPLIT(TempNameBasic.primaryProfession, ',')
INNER JOIN People
ON nconst = People.person_Id;

/* Resultat Insert Into
	(12 510 887 rows affected)
	Tid: 1 min 8 sekunder :)
*/
--Vet vilket Id som �r Will Smith utifr�n KnownForTabellen s� kan se vilka professions han har :)
SELECT profession_Name
FROM Professions 
Where person_Id = 'nm0000226'; 

/* Resultat, Inget Boxing h�r inte men kanske hade �ndrats om han knockat Chris Rock ;) 
	soundtrack
	producer
	actor
*/