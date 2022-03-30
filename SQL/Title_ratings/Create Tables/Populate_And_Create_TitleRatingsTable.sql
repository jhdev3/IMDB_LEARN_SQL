
DROP TABLE IF EXISTS TitleRatings

--Blir One To One Relationship s� d� kan lika g�rna Primary Key h�r vara Title_Id samt Vara Foreign Key.
CREATE TABLE TitleRatings (
	title_Id	varchar(100) PRIMARY KEY,
	average_Rating	float,	
	num_Votes	INT	 
);

--Skulle �ven kunna s�tta CASCADE Update / Delete h�r men det �r inget som vi i kursen �r intreserade av att G�ra.
ALTER TABLE TitleRatings
  ADD CONSTRAINT FK_TitleRatings_Titles
  FOREIGN KEY (title_Id)
  REFERENCES dbo.Titles(title_Id)

--Populate Title_Ratings -- InnerJoint f�r att filtrera bort de titlar som inte finns i titel tabellen
/*
	(1 207 727 rows affected) vs 1 229 218 �r lite minne som sparas :) samt v�ldigt on�digt att ha med.

*/
INSERT INTO TitleRatings (title_Id, average_Rating, num_Votes)
SELECT tconst, averageRating, numVotes 
FROM TempTitleRatings  
INNER JOIN Titles
ON tconst = title_Id

--Intressant och kolla hur m�nga rader/ minne som sparas :)
SELECT COUNT(*)
FROM TempTitleRatings;

--Kollar Sista Raden i Title.Ratings.tsv filen :) f�r att se vad f�r intressant title som dyker upp
SELECT *
FROM TitleRatings
FULL OUTER JOIN Titles
ON TitleRatings.title_Id = Titles.title_Id
WHERE TitleRatings.title_Id = 'tt9916778';