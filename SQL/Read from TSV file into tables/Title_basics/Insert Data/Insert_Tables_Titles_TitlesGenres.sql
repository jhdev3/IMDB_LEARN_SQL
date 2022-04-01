--Import Into Real Tables

INSERT INTO Titles (title_Id, title_Type, primary_Title, original_Title, is_Adult, start_Year, end_Year, runtime_Minutes)
SELECT tconst, titleType, primaryTitle, originalTitle, isAdult, startYear, endYear, runtimeMinutes  FROM tempDataTableTitle
WHERE isAdult = 0;

--Check Last Row
SELECT * FROM Titles
WHERE title_Id='tt9916880';

--Kollar så filtret fungerar 
SELECT * FROM Titles
WHERE is_Adult = 1;
--Vet att denna title är Kissing Contest och Adult
SELECT * FROM Titles
WHERE title_Id='tt15100902';

/*
Tog Lite tid mitt Resultat blev:
(13670417 rows affected) 1 min 57 sec
	Completion time: 2022-03-30T12:50:07.1933813+02:00
*/
INSERT INTO dbo.TitlesGenres (title_Id, Gener_name)
SELECT tconst, value as genere 
FROM tempDataTableTitle  
CROSS APPLY STRING_SPLIT(tempDataTableTitle.genres, ',')
INNER JOIN Titles
ON tconst = title_Id

--Bör Retunera Animation Comedy och Romance
--Test Så det Fungerar :)
SELECT * FROM TitlesGenres
WHERE title_Id = 'tt0000003'

--När det Fungerar 

DROP TABLE tempDataTableTitle


--Sedan Behövs inte detta så frigör lite plats på hårdisken med mera, Constraint trevligt för gör man fel så får man veta det
ALTER TABLE Titles
	DROP CONSTRAINT CHK_NoTAdult;

ALTER TABLE Titles
	DROP COLUMN is_Adult;