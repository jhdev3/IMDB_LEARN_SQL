--Skapa Episodes Tabellen och Importera temp samt filtera bort lite onödig skit

DROP TABLE IF EXISTS Episodes;


CREATE TABLE Episodes(
	episode_Id VARCHAR(100) PRIMARY KEY REFERENCES Titles(title_Id), 
	series_Id VARCHAR(100) NOT NULL FOREIGN KEY REFERENCES Titles(title_Id),
	season_Number SMALLINT,		
	episode_Number INT
);


--lägga in data i tabellen från temp tabellen

INSERT INTO Episodes (episode_Id, series_Id, season_Number, episode_Number) 
		SELECT tconst, parentTconst, seasonNumber, episodeNumber FROM TempEpisodes
		INNER JOIN Titles on TempEpisodes.tconst = Titles.title_Id
	    INNER JOIN Titles AS TitleParent
		on TempEpisodes.parentTconst = TitleParent.title_Id;
										

 /* 
	 6 429 733 rows affected
	 tid : 1 min 9 sek	
 */
 --Ett test för att se om jag får samma resultat som tidigare. 
SELECT * FROM Episodes
LEFT JOIN Titles on Episodes.episode_Id = Titles.title_Id
WHERE episode_Number = '72615';

DROP TABLE TempEpisodes