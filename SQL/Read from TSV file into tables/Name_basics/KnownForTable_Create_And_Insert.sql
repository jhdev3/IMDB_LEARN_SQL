--KnownFor Tabell Many to Many relation mellan People och Titles
DROP TABLE IF EXISTS KnownFor;
--Ett annat Passande Namn för Tabellen TitleKnownForPeople eller liknande för att tydligt vissa vad det är för typ av tabell.
CREATE TABLE KnownFor(
	person_Id VARCHAR(100) FOREIGN KEY REFERENCES People(person_Id),
	title_Id  VARCHAR(100) FOREIGN KEY REFERENCES Titles(title_Id)
);

--Kan finnas skäl att lägga index på båda columnerna, Gör det om det blir långsamma queries. 

--Lägger in data i Known For i 2 steg för att det ska bli lite enklare queris samt för liten extra kontroll så att allt blir rätt

--Steg 1
SELECT person_Id, value as title_Id INTO TempKnownFor
FROM TempNameBasic  
CROSS APPLY STRING_SPLIT(TempNameBasic.knownForTitles, ',')
INNER JOIN People
ON nconst = person_Id --Kolla så Forignkey finns kan göra det mot TempNameBasic men gör det mot People här så behövs det inte göras i steg 2 :)
--Resultat 20 114  797 rader

INSERT INTO KnownFor(person_Id, title_id)
	SELECT t.person_Id, t.title_Id FROM TempKnownFor as T
	INNER JOIN Titles 
	on Titles.title_Id = T.title_Id
--Denna query bör spara några rader dvs resultatet borde bli mindre än 20 114  797 rader, samt få ett error om inte foreign key finns i People men det borde redan vara kontrolerat i steg 1 men skulle något gått fel där får vi error här ;)
-- Resultatet från Query (17 770 097 rows affected) = Mission Complete :)

DROP TABLE TempKnownFor; --behövs inte mer:)

--Testa Will Smith Igen ska vi kolla vilka titlarna är? :)
SELECT People.person_Id, primary_Title 
FROM Titles 
LEFT JOIN KnownFor
ON Titles.title_Id = KnownFor.title_Id
INNER JOIN People
ON KnownFor.person_Id = People.person_Id
Where person_Name Like '%Will Smith%'; 

--nm0000226 Där är "Will Smith" som slog till Chris Rock ;) känner igen en title ;) 
--Kul fakta Querin tog 13 sekunder och 144 rader :) Än så länge behövs inget index i known for ;) Men skulle kanske snabba på en sådan här query lite.