--TempNameBasic Tabell
DROP TABLE IF EXISTS TempNameBasic;


CREATE TABLE TempNameBasic(
	nconst VARCHAR(100),
	primaryName NVARCHAR(150),--Finns �ven namn som �r 103 tecken l�nga :) 100 var inte tillr�ckligt stort :)
	birthYear VARCHAR(10), -- Finns �ven en hel del \N h�r ocks� vilket �r lite underligt Men det �r IMDBs databas
	deathYear VARCHAR(10), --\N f�r fixas senare Clean up
	primaryProfession VARCHAR(300),
	knownForTitles VARCHAR(200)
);

--Totalt antal rader i filen �r 11 512 538 :) S� borde bli det -1 f�rsta raden som �r vad columnerna heter ;)
BULK INSERT TempNameBasic
FROM 'G:\Informationsarkitektur och databasutv (Kurs)\Data fr�n IMDB\Name.Basics\data.tsv'
WITH
(
  CODEPAGE = '65001',
  ERRORFILE = 'G:\Informationsarkitektur och databasutv (Kurs)\Data fr�n IMDB\Name.Basics\bulk_insert_BadData.log',
  FIRSTROW = 2,
  FIELDTERMINATOR = '\t',
  ROWTERMINATOR = '0x0A',
  KEEPNULLS,  
  ROWS_PER_BATCH = 10000
);

/* 
Resultat fr�n Bulk insert :)
	11 512 537 rows affected
	Tid 33 sekunder
*/
--Litet test f�r att se hur tabellerna ser ut :)
select * FROM TempNameBasic
Where primaryName Like '%Will Smith%'; --Det fanns ett par stycken Ty�rr g�r det inte �n att s�ka p� om n�gon Slagit Chris Rock under Oscars ;)

UPDATE TempNameBasic
SET birthYear = null
WHERE birthYear = '\N';
--- �versakande m�nga rader (10965151 rows affected)

UPDATE TempNameBasic
SET deathYear = null
WHERE deathYear = '\N';

--(11312654 rows affected)
--Updaterar columner s� de matchar med Target Table;)-- Skulle h�r kunna bara byta namn p� tabell etc men jag anv�nder tempTablen f�r att uppr�tta och verifera relationen mellan people tabell och Known for samt profession tabellerna.
ALTER TABLE TempNameBasic
	ALTER COLUMN birthYear SMALLINT;

ALTER TABLE TempNameBasic
	ALTER COLUMN deathYear SMALLINT;