--Read file

BULK INSERT tempDataTableTitle
FROM 'G:\Informationsarkitektur och databasutv (Kurs)\Individuell upg\Data fr?n IMDB\title.basics.tsv\data.tsv'
WITH
(
  CODEPAGE = '65001',
  ERRORFILE = 'G:\Informationsarkitektur och databasutv (Kurs)\Individuell upg\Data fr?n IMDB\title.basics.tsv\bulk_insert_BadData.log',
  FIRSTROW = 2,
  FIELDTERMINATOR = '\t',
  ROWTERMINATOR = '0x0A',
  KEEPNULLS,  
  ROWS_PER_BATCH = 10000
);