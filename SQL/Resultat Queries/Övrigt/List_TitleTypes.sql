--2021

SELECT t.title_Id, t.title_Type, t.original_Title FROM Titles as T
	INNER JOIN TitlesGenres as TG
	ON T.title_Id = TG.title_Id
	WHERE start_Year = 2022 AND tg.Gener_name ='News'


SELECT t.title_Type, COUNT(*) AS NumberOfTypes  FROM Titles as T
GROUP by (title_Type)

/* 

title_Type  NumberOfTypes
tvMovie	135422
movie	596395
video	163882
tvPilot	2
tvEpisode	6430263
short	860438
tvShort	10508
tvMiniSeries	42542
videoGame	30565
tvSpecial	36389
tvSeries	220647

*/




