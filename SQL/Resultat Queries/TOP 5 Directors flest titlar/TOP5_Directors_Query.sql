

SELECT TOP 5 P.person_Id ,person_Name, COUNT(*) as Number_Of_Titles
INTO [IMDB_Results].[dbo].TOP5_Directors
FROM People as P
	INNER JOIN Directors as D
	ON P.person_Id= D.person_Id 
	INNER JOIN Titles as T
	ON D.title_Id = T.title_Id
GROUP BY P.person_Id, person_Name
ORDER BY Number_Of_Titles DESC

/* -Tid 16 sekunder
	person_Name	Number_Of_Titles
	Johnny Manahan	12658
	Nivedita Basu	12158
	Saibal Banerjee	10289
	Anil v Kumar	8861
	Conrado Lumabas	8024
*/


--För att Testa tid osv görs en Nested Query :)
SELECT title_Type, COUNT(*) as TimesDirecting FROM Titles as T
	INNER JOIN Directors as D
	ON D.title_Id=  T.title_Id AND D.person_Id = (SELECT person_Id from People
												WHERE person_Name = 'Johnny Manahan')
GROUP BY title_Type
ORDER BY TimesDirecting DESC

/* Resultat inte så förvånande :)
	title_Type	TimesDirecting
	tvEpisode	12629
	tvSeries	17
	tvSpecial	7
	movie	5
*/


--Men kan vara roligt att se om De är kända för något :)

SELECT D.person_Name, title_type, primary_Title, original_Title FROM Titles as T
INNER JOIN KnownFor as K
On T.title_Id = K.title_Id
INNER JOIN [IMDB_Results].[dbo].TOP5_Directors as D
ON K.person_Id = D.person_Id
ORDER BY D.person_Name

--Inget som jag sett men, 24 India är något jag känner igen.

/* Tid 5 Sekunder.
person_Name	title_type	primary_Title	original_Title
Anil v Kumar	tvSeries	Ganga Kii Dheej	Ganga Kii Dheej
Anil v Kumar	tvSeries	Itna Karo Na Mujhe Pyaar	Itna Karo Na Mujhe Pyaar
Anil v Kumar	tvSeries	Kayamath	Kayamath
Anil v Kumar	tvSeries	Kahiin To Hoga	Kahiin To Hoga
Conrado Lumabas	tvSeries	Saksi	Saksi
Johnny Manahan	movie	Si Aida, si Lorna, o si Fe	Si Aida, si Lorna, o si Fe
Johnny Manahan	movie	Oo na... Mahal na kung mahal	Oo na... Mahal na kung mahal
Johnny Manahan	tvSeries	ASAP	ASAP
Johnny Manahan	movie	Ang TV Movie: The Adarna Adventure	Ang TV Movie: The Adarna Adventure
Nivedita Basu	tvSeries	Kya Hadsaa Kya Haqeeqat	Kya Hadsaa Kya Haqeeqat
Nivedita Basu	tvSeries	24: India	24
Nivedita Basu	tvSeries	Itna Karo Na Mujhe Pyaar	Itna Karo Na Mujhe Pyaar
Nivedita Basu	tvSeries	Karma	Karma
Saibal Banerjee	movie	Sanjhbati	Sanjhbati
Saibal Banerjee	tvSeries	Ichche Nodee	Ichche Nodee
Saibal Banerjee	tvSeries	Fagun Bou	Fagun Bou
Saibal Banerjee	tvSeries	Ishti Kutum	Ishti Kutum


*/