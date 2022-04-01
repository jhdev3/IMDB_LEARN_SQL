--TempNameBasic Tabell
DROP TABLE IF EXISTS TempNameBasic;


CREATE TABLE TempNameBasic(
	nconst VARCHAR(100),
	primaryName NVARCHAR(150),--Finns även namn som är 103 tecken långa :) 100 var inte tillräckligt stort :)
	birthYear VARCHAR(10), -- Finns även en hel del \N här också vilket är lite underligt Men det är IMDBs databas
	deathYear VARCHAR(10), --\N får fixas senare Clean up
	primaryProfession VARCHAR(300),
	knownForTitles VARCHAR(200)
);

--Totalt antal rader i filen är 11 512 538 :) Så borde bli det -1 första raden som är vad columnerna heter ;)
BULK INSERT TempNameBasic
FROM 'G:\Informationsarkitektur och databasutv (Kurs)\Data från IMDB\Name.Basics\data.tsv'
WITH
(
  CODEPAGE = '65001',
  ERRORFILE = 'G:\Informationsarkitektur och databasutv (Kurs)\Data från IMDB\Name.Basics\bulk_insert_BadData.log',
  FIRSTROW = 2,
  FIELDTERMINATOR = '\t',
  ROWTERMINATOR = '0x0A',
  KEEPNULLS,  
  ROWS_PER_BATCH = 10000
);

/* 
Resultat från Bulk insert :)
	11 512 537 rows affected
	Tid 33 sekunder
*/
--Litet test för att se hur tabellerna ser ut :)
select * FROM TempNameBasic
Where primaryName Like '%Will Smith%'; --Det fanns ett par stycken Tyärr går det inte än att söka på om någon Slagit Chris Rock under Oscars ;)

UPDATE TempNameBasic
SET birthYear = null
WHERE birthYear = '\N';
--- Översakande många rader (10965151 rows affected)

UPDATE TempNameBasic
SET deathYear = null
WHERE deathYear = '\N';

--(11312654 rows affected)
--Updaterar columner så de matchar med Target Table;)-- Skulle här kunna bara byta namn på tabell etc men jag använder tempTablen för att upprätta och verifera relationen mellan people tabell och Known for samt profession tabellerna.
ALTER TABLE TempNameBasic
	ALTER COLUMN birthYear SMALLINT;

ALTER TABLE TempNameBasic
	ALTER COLUMN deathYear SMALLINT;