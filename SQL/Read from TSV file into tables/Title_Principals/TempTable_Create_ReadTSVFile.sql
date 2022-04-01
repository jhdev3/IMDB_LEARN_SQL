--TempTabell som Filteras innan resultat läggs in

DROP TABLE IF EXISTS TempTitlePrincipals;

CREATE TABLE TempTitlePrincipals(
	
	tconst  VARCHAR(100),
	ordering  TINYINT,
	nconst  VARCHAR(100),
	category  VARCHAR(50),
	job  NVARCHAR(400),--Fanns några långa strängar
	characters   NVARCHAR(500),
);


--49 585 207 rader stor resltate bör vara det -1 ;)
BULK INSERT TempTitlePrincipals
FROM 'G:\Informationsarkitektur och databasutv (Kurs)\Data från IMDB\title.principals.tsv\data.tsv'
WITH
(
  CODEPAGE = '65001',
  ERRORFILE = 'G:\Informationsarkitektur och databasutv (Kurs)\Data från IMDB\title.principals.tsv\bulk_insert_BadData.log',
  FIRSTROW = 2,
  FIELDTERMINATOR = '\t',
  ROWTERMINATOR = '0x0A',
  ROWS_PER_BATCH = 10000
);
/* 
	Resultat: 
	(49 595 206 rows affected) Klart Godkändt


*/
/* 
	Problem med CodePage eftersom i Job så sparar de Data i form i Json Strängar eller något liknande är inte Samma format som de har på deras String Arrays men något speciellt format som passar dem är det. Det är inte uppdelat i Key: value som en JSON object / sträng men annars är det En Array med strängar och I andra fall en string Array 
	Error 1 med   CODEPAGE = '65001',
	Error 2 Utan CodePAge
	Error 3 - Med CodePage ändra NVCHAR men inte tillräckligt stor column nu är det 462 tecken lång :)
	
	Lösning Ändra Job till NVARCHAR samt storleken på columnen 500 var tillräckligt men det är det som är det trevliga med Error Filer:) Ser vad som sticker ut etc ;)

*/