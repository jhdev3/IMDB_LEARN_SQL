--Lite Nyfiken på en del resultat med tanke på min Filtrering ;)

SELECT * FROM Titles as T
INNER JOIN TitlesGenres as TG
on T.title_Id = TG.title_Id
WHERE t.start_Year = 1989 AND Tg.Gener_name='Adult'

--Guendalina
SELECT * FROM Titles as T
INNER JOIN TitlesGenres as TG
on T.title_Id = TG.title_Id
WHERE t.title_Id = 'tt0256789'

--O Ônibus da Suruba
SELECT * FROM Titles as T
INNER JOIN TitlesGenres as TG
on T.title_Id = TG.title_Id
WHERE t.title_Id = 'tt15282122'

--La Parisienne
SELECT * FROM Titles as T
INNER JOIN TitlesGenres as TG
on T.title_Id = TG.title_Id
WHERE t.title_Id = 'tt0207005'