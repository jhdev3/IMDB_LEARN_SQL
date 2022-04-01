
DROP TABLE IF EXISTS dbo.tempDataTableTitle

CREATE TABLE tempDataTableTitle (
	tconst	nvarchar(100)	,
	titleType	nvarchar(50),	
	primaryTitle	nvarchar(500),	
	originalTitle	nvarchar(500),	
	isAdult	bit,
	startYear nvarchar(10),	
	endYear	nvarchar(10),	
	runtimeMinutes	nvarchar(30),	
	genres	nvarchar(100)	 
);
