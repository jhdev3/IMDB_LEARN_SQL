--KnownFor Tabell Many to Many relation mellan People och Titles
DROP TABLE IF EXISTS KnownFor;
--Ett annat Passande Namn f�r Tabellen TitleKnownForPeople eller liknande f�r att tydligt vissa vad det �r f�r typ av tabell.
CREATE TABLE KnownFor(
	person_Id VARCHAR(100) FOREIGN KEY REFERENCES People(person_Id),
	title_Id  VARCHAR(100) FOREIGN KEY REFERENCES Titles(title_Id)
);

--Kan finnas sk�l att l�gga index p� b�da columnerna, G�r det om det blir l�ngsamma queries. 

--L�gger in data i Known For i 2 steg f�r att det ska bli lite enklare queris samt f�r liten extra kontroll s� att allt blir r�tt

--Steg 1
SELECT person_Id, value as title_Id INTO TempKnownFor
FROM TempNameBasic  
CROSS APPLY STRING_SPLIT(TempNameBasic.knownForTitles, ',')
INNER JOIN People
ON nconst = person_Id --Kolla s� Forignkey finns kan g�ra det mot TempNameBasic men g�r det mot People h�r s� beh�vs det inte g�ras i steg 2 :)
--Resultat 20 114  797 rader

INSERT INTO KnownFor(person_Id, title_id)
	SELECT t.person_Id, t.title_Id FROM TempKnownFor as T
	INNER JOIN Titles 
	on Titles.title_Id = T.title_Id
--Denna query b�r spara n�gra rader dvs resultatet borde bli mindre �n 20 114  797 rader, samt f� ett error om inte foreign key finns i People men det borde redan vara kontrolerat i steg 1 men skulle n�got g�tt fel d�r f�r vi error h�r ;)
-- Resultatet fr�n Query (17 770 097 rows affected) = Mission Complete :)

DROP TABLE TempKnownFor; --beh�vs inte mer:)

--Testa Will Smith Igen ska vi kolla vilka titlarna �r? :)
SELECT People.person_Id, primary_Title 
FROM Titles 
LEFT JOIN KnownFor
ON Titles.title_Id = KnownFor.title_Id
INNER JOIN People
ON KnownFor.person_Id = People.person_Id
Where person_Name Like '%Will Smith%'; 

--nm0000226 D�r �r "Will Smith" som slog till Chris Rock ;) k�nner igen en title ;) 
--Kul fakta Querin tog 13 sekunder och 144 rader :) �n s� l�nge beh�vs inget index i known for ;) Men skulle kanske snabba p� en s�dan h�r query lite.