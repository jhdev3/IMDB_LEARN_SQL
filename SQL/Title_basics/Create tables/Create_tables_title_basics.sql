/*
Use char when the sizes of the column data entries are consistent. --https://docs.microsoft.com/en-us/sql/t-sql/data-types/char-and-varchar-transact-sql?view=sql-server-ver15
Use varchar when the sizes of the column data entries vary considerably.
Use varchar(max) when the sizes of the column data entries vary considerably, and the string length might exceed 8,000 bytes. 
TEXT VS varchar(max)  för Primt Title eller Orginal Title, spelar inte så stor roll Här är inget som jag kommer använda Index på skulle det vara det får jag begränsa mig till ett vist antal tecken.
Men att leta efter First är i princip det man skulle göra endå om man söker efter Title. 
	The VARCHAR(MAX) data type is a replacement for TEXT data type.
	LIKE statement is identical between the two data types.
	Additional functionality = and GROUP BY can’t be used in TEXT data type but it can be on VARCHAR(MAX)  data type
	--https://sqltutorialtips.blogspot.com/2016/11/text-vs-varcharmax.html
*/

DROP TABLE IF EXISTS dbo.TitlesGenres

DROP TABLE IF EXISTS dbo.Titles

CREATE TABLE Titles (
  title_Id 			VARCHAR(100) NOT NULL, -- Primary Key
  title_Type 		VARCHAR(50),						--Är inte så lång så 50 okej
  primary_Title 	NVARCHAR(500),						-- Några är ganska långa
  original_Title 	NVARCHAR(500),	
  is_Adult 			BIT,								--Istället för bool/boolean som inte fungerade samt att Den läser 0: non-adult title och 1: audlt title, Filteras när de läses in Adult titles är inget jag är intresserad av så tar bort dem. Och senare den här Columnen 
  start_Year		SMALLINT, -- Spara lite plats dvs 2 bytes eftersom det är enbart Året som sparas och hanteras. DATE blir fel format. Största värdet är 32 767 det är ett par år framåt i tiden.             
  end_Year 			SMALLINT,  
  runtime_Minutes	INTEGER -- Kan säkert bli kanska stor så INT borde vara okej. Här skulle det vara trevligt med att konvertera till Time men en TVSerie skulle kunna vara flera dagar lång. Och göra det till DateTime blir lite jobbigt. Det kan man göra med resultaten man får om man tycker att Runtime är relevant. 
);
ALTER TABLE Titles
   ADD CONSTRAINT PK_Titles_title_Id PRIMARY KEY CLUSTERED (title_Id);

ALTER TABLE Titles
	ADD CONSTRAINT CHK_NoTAdult CHECK (is_Adult=0);
 

DROP TABLE IF EXISTS TitlesGenres

--Many to Many relation 
CREATE TABLE TitlesGenres(
	--rowIndex int IDENTITY(1,1) PRIMARY KEY, --Auto generated Row Index Tror inte det behövs samt skulle kunna göra FK till Indexerad Clusterd om jag så vill då jag inte har FK samt kmr inte använda Primary key för att söka i tabellen utan FK
	title_Id   VARCHAR(100) NOT NULL, --FK till Titles
	Gener_name VARCHAR(50) NOT NULL,--FK to Generes taballen om jag vill ha den men kommer endå vara 0 för här är det inter relvant att spara något som är null
);

ALTER TABLE dbo.TitlesGenres
  ADD CONSTRAINT FK_TitlesGenres_Titles
  FOREIGN KEY (title_Id)
  REFERENCES dbo.Titles(title_Id)

CREATE INDEX index_TitlesGenres_FK
	ON dbo.TitlesGenres (title_Id);