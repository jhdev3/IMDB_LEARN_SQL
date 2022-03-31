
DROP TABLE IF EXISTS TempTitleRatings

CREATE TABLE TempTitleRatings (
	tconst	nvarchar(100)	,
	averageRating	float,	
	numVotes	INT	 
);

--Bör Bli 1229218
BULK INSERT TempTitleRatings
FROM 'G:\Informationsarkitektur och databasutv (Kurs)\Data från IMDB\title.ratings.tsv\data.tsv'
WITH
(
  CODEPAGE = '65001',
  ERRORFILE = 'G:\Informationsarkitektur och databasutv (Kurs)\Data från IMDB\title.ratings.tsv\bulk_insert_BadData.log',
  FIRSTROW = 2,
  FIELDTERMINATOR = '\t',
  ROWTERMINATOR = '0x0A',
  KEEPNULLS,  
  ROWS_PER_BATCH = 10000
);
