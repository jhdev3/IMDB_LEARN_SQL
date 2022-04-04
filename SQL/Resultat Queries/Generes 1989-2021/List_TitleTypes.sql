--2021
SELECT t.title_Id, t.title_Type, t.original_Title FROM Titles as T
	INNER JOIN TitlesGenres as TG
	ON T.title_Id = TG.title_Id
	WHERE start_Year = 2022 AND tg.Gener_name ='News'
--12 568 Rows. och Alla types är tvEpisode 

SELECT title_Type, COUNT(*) AS NumberOfTypes  FROM Titles
GROUP by (title_Type)

/* 

title_Type		NumberOfTypes
tvMovie			135 422
movie			596 395
video			163 882
tvPilot			2
tvEpisode		6 430 263
short			860 438
tvShort			10 508
tvMiniSeries	42 542
videoGame		30 565
tvSpecial		36 389
tvSeries		220 647
*/

SELECT *  FROM Titles
WHERE title_Type = 'tvPilot';

/* 
title_Id	title_Type	primary_Title	original_Title	start_Year
tt14761346	tvPilot	Testing Title 14	Testing Title 14	2021
tt15258334	tvPilot	TV Pilot	TV Pilot	1991
*/