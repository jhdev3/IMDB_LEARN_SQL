/*
Use char when the sizes of the column data entries are consistent. --https://docs.microsoft.com/en-us/sql/t-sql/data-types/char-and-varchar-transact-sql?view=sql-server-ver15
Use varchar when the sizes of the column data entries vary considerably.
Use varchar(max) when the sizes of the column data entries vary considerably, and the string length might exceed 8,000 bytes. 
TEXT VS varchar(max)  f�r Primt Title eller Orginal Title, spelar inte s� stor roll H�r �r inget som jag kommer anv�nda Index p� skulle det vara det f�r jag begr�nsa mig till ett vist antal tecken.
Men att leta efter First �r i princip det man skulle g�ra end� om man s�ker efter Title. 
	The VARCHAR(MAX) data type is a replacement for TEXT data type.
	LIKE statement is identical between the two data types.
	Additional functionality = and GROUP BY can�t be used in TEXT data type but it can be on VARCHAR(MAX)  data type
	--https://sqltutorialtips.blogspot.com/2016/11/text-vs-varcharmax.html
*/

DROP TABLE IF EXISTS dbo.TitlesGenres

DROP TABLE IF EXISTS dbo.Titles

CREATE TABLE Titles (
  title_Id 			VARCHAR(100) NOT NULL, -- Primary Key
  title_Type 		VARCHAR(50),						--�r inte s� l�ng s� 50 okej
  primary_Title 	NVARCHAR(500),						-- N�gra �r ganska l�nga
  original_Title 	NVARCHAR(500),	
  is_Adult 			BIT,								--Ist�llet f�r bool/boolean som inte fungerade samt att Den l�ser 0: non-adult title och 1: audlt title, Filteras n�r de l�ses in Adult titles �r inget jag �r intresserad av s� tar bort dem. Och senare den h�r Columnen 
  start_Year		SMALLINT, -- Spara lite plats dvs 2 bytes eftersom det �r enbart �ret som sparas och hanteras. DATE blir fel format. St�rsta v�rdet �r 32 767 det �r ett par �r fram�t i tiden.             
  end_Year 			SMALLINT,  
  runtime_Minutes	INTEGER -- Kan s�kert bli kanska stor s� INT borde vara okej. H�r skulle det vara trevligt med att konvertera till Time men en TVSerie skulle kunna vara flera dagar l�ng. Och g�ra det till DateTime blir lite jobbigt. Det kan man g�ra med resultaten man f�r om man tycker att Runtime �r relevant. 
);
ALTER TABLE Titles
   ADD CONSTRAINT PK_Titles_title_Id PRIMARY KEY CLUSTERED (title_Id);

ALTER TABLE Titles
	ADD CONSTRAINT CHK_NoTAdult CHECK (is_Adult=0);
 

DROP TABLE IF EXISTS TitlesGenres

--Many to Many relation 
CREATE TABLE TitlesGenres(
	--rowIndex int IDENTITY(1,1) PRIMARY KEY, --Auto generated Row Index Tror inte det beh�vs samt skulle kunna g�ra FK till Indexerad Clusterd om jag s� vill d� jag inte har FK samt kmr inte anv�nda Primary key f�r att s�ka i tabellen utan FK
	title_Id   VARCHAR(100) NOT NULL, --FK till Titles
	Gener_name VARCHAR(50) NOT NULL,--FK to Generes taballen om jag vill ha den men kommer end� vara 0 f�r h�r �r det inter relvant att spara n�got som �r null
);

ALTER TABLE dbo.TitlesGenres
  ADD CONSTRAINT FK_TitlesGenres_Titles
  FOREIGN KEY (title_Id)
  REFERENCES dbo.Titles(title_Id)

CREATE INDEX index_TitlesGenres_FK
	ON dbo.TitlesGenres (title_Id);