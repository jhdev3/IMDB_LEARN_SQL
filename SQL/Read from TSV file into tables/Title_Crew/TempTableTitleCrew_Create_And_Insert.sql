--Title CrewTempTable

DROP TABLE IF EXISTS TempTitleCrew;

CREATE TABLE TempTitleCrew(
	
	tconst  VARCHAR(100),
	directors  VARCHAR(MAX),
	writers VARCHAR(MAX),--Fanns några riktigt storra string arrayer :) Eftersom det är ett temp tabell så blir updelningen sen mer effektiv lagring;)
);
--8 799 419 rader i filen totalen bör vara det -1 ;)
BULK INSERT TempTitleCrew
FROM 'G:\Informationsarkitektur och databasutv (Kurs)\Data från IMDB\title.crew.tsv\data.tsv'
WITH
(
  CODEPAGE = '65001',
  ERRORFILE = 'G:\Informationsarkitektur och databasutv (Kurs)\Data från IMDB\title.crew.tsv\bulk_insert_BadData.log',
  FIRSTROW = 2,
  FIELDTERMINATOR = '\t',
  ROWTERMINATOR = '0x0A',
  KEEPNULLS,  
  ROWS_PER_BATCH = 10000
);
/* 
	Resultat: 
	(8799418 rows affected) :) Jippi

*/
