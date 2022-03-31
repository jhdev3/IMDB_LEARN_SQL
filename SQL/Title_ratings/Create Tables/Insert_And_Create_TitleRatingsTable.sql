
DROP TABLE IF EXISTS TitleRatings

--Blir One To One Relationship så då kan lika gärna Primary Key här vara Title_Id samt Vara Foreign Key.
CREATE TABLE TitleRatings (
	title_Id	varchar(100) PRIMARY KEY,
	average_Rating	float,	
	num_Votes	INT	 
);

--Skulle Även kunna sätta CASCADE Update / Delete här men det är inget som vi i kursen är intreserade av att Göra.
ALTER TABLE TitleRatings
  ADD CONSTRAINT FK_TitleRatings_Titles
  FOREIGN KEY (title_Id)
  REFERENCES dbo.Titles(title_Id)

--Populate Title_Ratings -- InnerJoint för att filtrera bort de titlar som inte finns i titel tabellen
/*
	(1 207 727 rows affected) vs 1 229 218 är lite minne som sparas :) samt väldigt onödigt att ha med.

*/
INSERT INTO TitleRatings (title_Id, average_Rating, num_Votes)
SELECT tconst, averageRating, numVotes 
FROM TempTitleRatings  
INNER JOIN Titles
ON tconst = title_Id

--Intressant och kolla hur många rader/ minne som sparas :)
SELECT COUNT(*)
FROM TempTitleRatings;

--Kollar Sista Raden i Title.Ratings.tsv filen :) för att se vad för intressant title som dyker upp
SELECT *
FROM TitleRatings
FULL OUTER JOIN Titles
ON TitleRatings.title_Id = Titles.title_Id
WHERE TitleRatings.title_Id = 'tt9916778';