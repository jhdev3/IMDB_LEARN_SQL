--- Vilka Genres skapades flest filmer/Tv-serier från 1989–2021? 

--Plockar Ut top 5, Varje År mellan 1989-2021. Filtrera på Episode, Ingen Titeln och Short. 
--Anledningen att Inte Short följer med är att det inte direkt är en Genre utan typ av Genre.
DECLARE @Year INT 
SET @Year=1989
WHILE ( @Year <= 2021)
BEGIN
	--Sparar mitt resultat i en Databas ny databas för att Bara ha resultat tabellerna samlade i ett ställe gör det Lättare att Titta på/filtrera/exportera/ datan ;)
	INSERT INTO [IMDB_Results].[dbo].TOP5_Most_Prod_Per_Genre_1989_to_2021([Year], [Gener_name], [Productions])
		SELECT TOP 5 [Year]= @Year, TG.Gener_name, COUNT(t.start_Year) as Productions FROM Titles as T
		INNER JOIN TitlesGenres as TG
		ON T.title_Id = TG.title_Id
		WHERE (start_Year = @Year AND NOT title_Type = 'tvEpisode') AND NOT( TG.Gener_name ='\N' or TG.Gener_name ='Short' )     
		GROUP BY TG.Gener_name
		ORDER BY Productions DESC;
	--För att se vad som händer i messages
	PRINT 'Done with year: ' + CONVERT(VARCHAR,@Year)
	SET @Year  = @Year  + 1
END
-- Total tid 3 min 17 sekunder. 165 Rader ,33 år Varje "Query" tar 6 sekunder i snitt.   

SELECT count(DISTINCT Gener_name) FROM TOP5_Most_Prod_Per_Genre_1989_to_2021
-- 11 Olika Genres :)

SELECT  Gener_name FROM TOP5_Most_Prod_Per_Genre_1989_to_2021
GROUP BY Gener_name
/* 
Gener_name:
		Action
		Animation
		Comedy
		Crime
		Documentary
		Drama
		Family
		Horror
		Music
		Romance
		Thriller
*/

SELECT   Gener_name, count(*) as TOP_5_Number_of_Years FROM TOP5_Most_Prod_Per_Genre_1989_to_2021
GROUP BY Gener_name
ORDER BY TOP_5_Number_of_Years DESC
/* 
Resultat: 
	Gener_name	TOP_5_Number_of_Years
	Comedy			33
	Documentary		33
	Drama			33
	Action			28
	Horror			12
	Animation		8
	Music			7
	Romance			5
	Family			3
	Crime			2
	Thriller		1
*/

--Plockar ut de populäraste uppstickarna ;)
SELECT  [Year], Gener_name FROM TOP5_Most_Prod_Per_Genre_1989_to_2021
WHERE Gener_name IN 
	(SELECT TOP5.Gener_name FROM TOP5_Most_Prod_Per_Genre_1989_to_2021 as TOP5
	GROUP BY Gener_name
	HAVING COUNT(TOP5.Gener_name) BETWEEN 1 AND 27)
ORDER BY [Year];

/* Uppstickare 

Year  |	Gener_name | Year	|	Gener_name
---------------------------------------
1991	Animation	2012		Horror
1992	Animation	2013		Horror
1996	Animation	2014		Horror
1997	Animation	2015		Horror
1999	Animation	2016		Horror
2000	Animation	2017		Horror
2003	Music		2018		Horror
2004	Music		2019		Music
2005	Music		2019		Horror
2006	Music		2020		Horror
2007	Animation	2020		Music
2008	Animation	2021		Music
2009	Horror		2021		Horror
2011	Horror		
*/

--De År Action Trillade ut top 5 :)
SELECT [Year], Count(*) FROM TOP5_Most_Prod_Per_Genre_1989_to_2021
WHERE NOT Gener_name = 'Action'
GROUP BY [Year]
HAVING COUNT(*) = 5;
/*
	Year:
		2014
		2018
		2019
		2020
		2021
*/
SELECT   Gener_name, SUM(Productions) as TOP_5_Number_of_Years FROM TOP5_Most_Prod_Per_Genre_1989_to_2021
GROUP BY Gener_name
ORDER BY TOP_5_Number_of_Years DESC

/* 
Gener_name	TOP_5_Number_of_Years
Drama			395 339
Documentary		276 868
Comedy			273 681
Action			60 511
Horror			58 321
Music			21 900
Romance			10 869
Animation		8 568
Thriller		4 597
Family			1 782
Crime			1 082
*/


--Tabell för att spara Resultat från Query 1 :)
USE IMDB_Results
CREATE TABLE TOP5_Most_Prod_Per_Genre_1989_to_2021(
	[Year] SMALLINT,
	Gener_name VARCHAR(25),
	Productions INT
);
