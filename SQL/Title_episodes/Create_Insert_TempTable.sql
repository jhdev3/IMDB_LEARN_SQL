--Skapa Temp Tabell och Importera här gäller samma princip som föregående att filtrera utifrån Title tabellen dvs finns ingen title läggs det inte till i "Riktiga Tabellen"
--Blir en One to Many mellan Episoder och Titlar. 
DROP TABLE IF EXISTS TempEpisodes;

CREATE TABLE TempEpisodes(	
	tconst VARCHAR(100), -- alphanumeric identifier of episode
	parentTconst VARCHAR(100), -- alphanumeric identifier of the parent TV Series
	seasonNumber VARCHAR(20),		-- season number the episode belongs to
	episodeNumber VARCHAR(20)			-- episode number of the tconst in the TV series borde inte vara större än 255
);

--Finns lite \N i seasonNumber och Episode får rensa upp dem senare byter TINYINT till varchar och sedan tillbaka
BULK INSERT TempEpisodes
FROM 'G:\Informationsarkitektur och databasutv (Kurs)\Data från IMDB\title.episode.tsv\data.tsv'
WITH
(
  CODEPAGE = '65001',
  ERRORFILE = 'G:\Informationsarkitektur och databasutv (Kurs)\Data från IMDB\title.episode.tsv\bulk_insert_BadData.log', --Trevligt att se vad som blir fel
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
(1402462 rows affected) Mer än väntat

*/

ALTER TABLE TempEpisodes
ALTER COLUMN seasonNumber SMALLINT; --Finn serier som har årtal som season number

-- Lite Roliga Tests för att kolla :)
SELECT * FROM TempEpisodes
WHERE seasonNumber = '1994';

SELECT * FROM Titles
WHERE title_Id = 'tt1868747'

--Uppdatera Episode Numer. 
UPDATE TempEpisodes
SET episodeNumber = NULL 
WHERE episodeNumber = '\N';

ALTER TABLE TempEpisodes
ALTER COLUMN episodeNumber INT; --Finns serier med tex 813 som episode numer, Men lite förvånande även serier med Episode numer 72615 :) så får bli en INT


SELECT * FROM TempEpisodes
LEFT JOIN Titles on TempEpisodes.parentTconst = Titles.title_Id
WHERE episodeNumber = '72615';
