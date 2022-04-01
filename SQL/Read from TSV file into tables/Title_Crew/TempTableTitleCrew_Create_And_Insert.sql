--Title CrewTempTable

DROP TABLE IF EXISTS TempTitleCrew;

CREATE TABLE TempTitleCrew(
	
	tconst  VARCHAR(100),
	directors  VARCHAR(MAX),
	writers VARCHAR(MAX),--Fanns n�gra riktigt storra string arrayer :) Eftersom det �r ett temp tabell s� blir updelningen sen mer effektiv lagring;)
);
--8 799 419 rader i filen totalen b�r vara det -1 ;)
BULK INSERT TempTitleCrew
FROM 'G:\Informationsarkitektur och databasutv (Kurs)\Data fr�n IMDB\title.crew.tsv\data.tsv'
WITH
(
  CODEPAGE = '65001',
  ERRORFILE = 'G:\Informationsarkitektur och databasutv (Kurs)\Data fr�n IMDB\title.crew.tsv\bulk_insert_BadData.log',
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
