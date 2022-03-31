--Skapa Temp Tabell och Importera h�r g�ller samma princip som f�reg�ende att filtrera utifr�n Title tabellen dvs finns ingen title l�ggs det inte till i "Riktiga Tabellen"
--Blir en One to Many mellan Episoder och Titlar. 
DROP TABLE IF EXISTS TempEpisodes;

CREATE TABLE TempEpisodes(	
	tconst VARCHAR(100), -- alphanumeric identifier of episode
	parentTconst VARCHAR(100), -- alphanumeric identifier of the parent TV Series
	seasonNumber VARCHAR(20),		-- season number the episode belongs to
	episodeNumber VARCHAR(20)			-- episode number of the tconst in the TV series borde inte vara st�rre �n 255
);

--Finns lite \N i seasonNumber och Episode f�r rensa upp dem senare byter TINYINT till varchar och sedan tillbaka
BULK INSERT TempEpisodes
FROM 'G:\Informationsarkitektur och databasutv (Kurs)\Data fr�n IMDB\title.episode.tsv\data.tsv'
WITH
(
  CODEPAGE = '65001',
  ERRORFILE = 'G:\Informationsarkitektur och databasutv (Kurs)\Data fr�n IMDB\title.episode.tsv\bulk_insert_BadData.log', --Trevligt att se vad som blir fel
  FIRSTROW = 2,
  FIELDTERMINATOR = '\t',
  ROWTERMINATOR = '0x0A',
  ROWS_PER_BATCH = 10000
);
/* 
	(6597006 rows affected)
	Tog 20 sekunder
*/

--Update Temp Table To match Episode Table
UPDATE TempEpisodes
SET seasonNumber = NULL 
WHERE seasonNumber = '\N';
/* 
(1402462 rows affected) Mer �n v�ntat

*/

ALTER TABLE TempEpisodes
ALTER COLUMN seasonNumber SMALLINT; --Finn serier som har �rtal som season number

-- Lite Roliga Tests f�r att kolla :)
SELECT * FROM TempEpisodes
WHERE seasonNumber = '1994';

SELECT * FROM Titles
WHERE title_Id = 'tt1868747'

--Uppdatera Episode Numer. 
UPDATE TempEpisodes
SET episodeNumber = NULL 
WHERE episodeNumber = '\N';

ALTER TABLE TempEpisodes
ALTER COLUMN episodeNumber INT; --Finns serier med tex 813 som episode numer, Men lite f�rv�nande �ven serier med Episode numer 72615 :) s� f�r bli en INT


SELECT * FROM TempEpisodes
LEFT JOIN Titles on TempEpisodes.parentTconst = Titles.title_Id
WHERE episodeNumber = '72615';
