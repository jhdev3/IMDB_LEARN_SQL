--Populäraste titlarna 1989-2021 :)
--I Detta Fall Skulle en View kunna vara aktuellt eftersom Denna Query gick väldigt snabbt :)
--Istället för att Skapa En Extra Tabell. 

--Vad Som Krävs här är att byta title_Type='tvseries' till Movies samt Insert Into tabellen Om man vill ha någon sådan.
DECLARE @Year INT 
SET @Year=1989
WHILE ( @Year < 2021)
BEGIN
	INSERT INTO [IMDB_Results].[dbo].[Popular_TvSeries_1989_2021]
	SELECT TOP 25 t.title_Id, start_Year, title_Type ,original_Title, average_Rating, num_Votes,
	(SELECT  STRING_AGG( ISNULL(Gener_name, ' '), ',') --Lite Hacks för att få en Snygg Utrskift :) 
		   From TitlesGenres
		   WHERE title_Id = t.title_Id) As Geners 
	FROM Titles as T
	 INNER JOIN TitleRatings as TR
	 ON  t.title_Id = TR.title_Id
	 WHERE t.start_Year BETWEEN @Year AND (@Year+8) AND (title_Type='TvSeries') AND (TR.num_Votes > 50000) 
	 ORDER BY average_Rating DESC

	SET @Year  = @Year  + 8
END

 --TOP 100: TVSeries 8 års Increment Trevlig Utskift men det går väldigt snabbt :)

 SELECT * FROM [IMDB_Results].[dbo].[Popular_TvSeries_1989_2021]