--Create ProfessionTable one to Many relation.
--Finns en anleding till att göra en Tabell med namnet "Jobs" och göra Profession table Many to Many då title.principals
-- Där det finns category (string) - the category of job that person was in 
--I dessa Columner skulle det kunna finnas en relation Mellan Profession och Category
--Men att skapa den tabellen och skapa relation mellan dem känner jag att den tiden som krävs inte är värt det. Men värt att påpeka i alla fall.


DROP TABLE IF EXISTS Professions;

CREATE TABLE Professions(
	
	person_Id VARCHAR(100) FOREIGN KEY REFERENCES People(person_Id), --Kan finnas skäl till att göra FK indexerad. för att snabba upp Queries
	profession_Name NVARCHAR(50) 
);

--Samma Query som för Genere bara här känner jag att det blir enklare med One to Many så har då ett enkelt namn på Tabellen.
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
--Vet vilket Id som är Will Smith utifrån KnownForTabellen så kan se vilka professions han har :)
SELECT profession_Name
FROM Professions 
Where person_Id = 'nm0000226'; 

/* Resultat, Inget Boxing här inte men kanske hade ändrats om han knockat Chris Rock ;) 
	soundtrack
	producer
	actor
*/