--TempTabell som Filteras innan resultat l�ggs in

DROP TABLE IF EXISTS TempTitlePrincipals;

CREATE TABLE TempTitlePrincipals(
	
	tconst  VARCHAR(100),
	ordering  TINYINT,
	nconst  VARCHAR(100),
	category  VARCHAR(50),
	job  NVARCHAR(400),--Fanns n�gra l�nga str�ngar
	characters   NVARCHAR(500),
);


--49 585 207 rader stor resltate b�r vara det -1 ;)
BULK INSERT TempTitlePrincipals
FROM 'G:\Informationsarkitektur och databasutv (Kurs)\Data fr�n IMDB\title.principals.tsv\data.tsv'
WITH
(
  CODEPAGE = '65001',
  ERRORFILE = 'G:\Informationsarkitektur och databasutv (Kurs)\Data fr�n IMDB\title.principals.tsv\bulk_insert_BadData.log',
  FIRSTROW = 2,
  FIELDTERMINATOR = '\t',
  ROWTERMINATOR = '0x0A',
  ROWS_PER_BATCH = 10000
);
/* 
	Resultat: 
	(49 595 206 rows affected) Klart Godk�ndt


*/
/* 
	Problem med CodePage eftersom i Job s� sparar de Data i form i Json Str�ngar eller n�got liknande �r inte Samma format som de har p� deras String Arrays men n�got speciellt format som passar dem �r det. Det �r inte uppdelat i Key: value som en JSON object / str�ng men annars �r det En Array med str�ngar och I andra fall en string Array 
	Error 1 med   CODEPAGE = '65001',
	Error 2 Utan CodePAge
	Error 3 - Med CodePage �ndra NVCHAR men inte tillr�ckligt stor column nu �r det 462 tecken l�ng :)
	
	L�sning �ndra Job till NVARCHAR samt storleken p� columnen 500 var tillr�ckligt men det �r det som �r det trevliga med Error Filer:) Ser vad som sticker ut etc ;)

*/