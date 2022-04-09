--Top Directors Utifrån Avrage betyg :)


--Det Roliga här blir att göra Avrage på average_rating misstaget här att Summera average_rating så får den som gjort flest titlar en enorm fördel ;)
--Det vi vill ha här är Kvalitet före Kvantitet ;)

CREATE VIEW TOP_10_Directors_AVG_Rating AS
	SELECT TOP 10 p.person_Id, p.person_Name, ROUND(AVG(TG.average_Rating), 2) as Average_Rating from People as P
	INNER JOIN Directors as D
	on P.person_Id = D.person_Id
	INNER JOIN TitleRatings as TG
	on D.title_Id = TG.title_Id
	WHERE TG.num_Votes > 50000
	GROUP BY p.person_Id, p.person_Name
	HAVING (COUNT(TG.average_Rating)) > 10
	ORDER BY Average_Rating DESC;

--Tid 1-2 sekunder
/* Ganska Jämt :)
person_Id	person_Name	Average_Rating
nm0787687	Matt Shakman	8.55
nm0533713	Michelle MacLaren	8.52
nm0002399	Alik Sakharov	8.48
nm0687964	Jeremy Podeswa	8.45
nm0336241	Alex Graves	8.44
nm0002835	Adam Bernstein	8.43
nm0080601	Ed Bianchi	8.41
nm0851930	Alan Taylor	8.39
nm0806252	Michael Slovis	8.37
nm0118778	Colin Bucksey	8.36
*/




/*Prestanda */
--Known for tabell

	CREATE INDEX Index_KnownFor_TitleId
	ON KnownFor (title_Id);

	DROP INDEX Index_KnownFor_TitleId ON KnownFor;


	CREATE INDEX Index_KnownFor_PersonId
	ON KnownFor (person_Id);

	DROP INDEX Index_KnownFor_PersonId ON KnownFor;

--Director Tabell
	CREATE INDEX Index_Directors_TitleId
	ON Directors (title_Id);

	DROP INDEX Index_Directors_TitleId ON Directors;


	CREATE INDEX Index_Directors_PersonId
	ON Directors (person_Id);

	DROP INDEX Index_Directors_PersonId ON Directors;




SELECT TOP_10.person_Name, title_type, primary_Title, original_Title FROM Titles as T
INNER JOIN KnownFor as K
On T.title_Id = K.title_Id
INNER JOIN TOP_10_Directors_AVG_Rating as TOP_10
ON K.person_Id = TOP_10.person_Id
ORDER BY TOP_10.person_Name

--Tid 40 Sek
--Det hjälper att vara med i Populära TVSerier ;) som Tex Game Of Thrones :
/* 
person_Name	title_type	primary_Title	original_Title
Adam Bernstein	movie	Six Ways to Sunday	Six Ways to Sunday
Adam Bernstein	tvSeries	Breaking Bad	Breaking Bad
Adam Bernstein	tvSeries	30 Rock	30 Rock
Adam Bernstein	tvSeries	Fargo	Fargo
Alan Taylor	movie	Thor: The Dark World	Thor: The Dark World
Alan Taylor	movie	The Emperor's New Clothes	The Emperor's New Clothes
Alan Taylor	tvSeries	Game of Thrones	Game of Thrones
Alan Taylor	movie	Terminator Genisys	Terminator Genisys
Alex Graves	tvSeries	Proof	Proof
Alex Graves	tvSeries	Game of Thrones	Game of Thrones
Alex Graves	tvSeries	The West Wing	The West Wing
Alex Graves	movie	The Crude Oasis	The Crude Oasis
Alik Sakharov	tvSeries	Ozark	Ozark
Alik Sakharov	tvSeries	Game of Thrones	Game of Thrones
Alik Sakharov	tvSeries	The Sopranos	The Sopranos
Alik Sakharov	tvSeries	House of Cards	House of Cards
Colin Bucksey	tvSeries	Educating Marmalade	Educating Marmalade
Colin Bucksey	tvSeries	Person of Interest	Person of Interest
Colin Bucksey	tvSeries	Breaking Bad	Breaking Bad
Colin Bucksey	tvSeries	Fargo	Fargo
Ed Bianchi	tvSeries	The Wire	The Wire
Ed Bianchi	tvSeries	City on a Hill	City on a Hill
Ed Bianchi	tvSeries	Boardwalk Empire	Boardwalk Empire
Ed Bianchi	tvSeries	Deadwood	Deadwood
Jeremy Podeswa	tvMiniSeries	Station Eleven	Station Eleven
Jeremy Podeswa	tvSeries	Game of Thrones	Game of Thrones
Jeremy Podeswa	tvMiniSeries	The Pacific	The Pacific
Jeremy Podeswa	tvSeries	The Handmaid's Tale	The Handmaid's Tale
Matt Shakman	tvSeries	The Great	The Great
Matt Shakman	tvSeries	Game of Thrones	Game of Thrones
Matt Shakman	tvSeries	It's Always Sunny in Philadelphia	It's Always Sunny in Philadelphia
Matt Shakman	tvMiniSeries	WandaVision	WandaVision
Michael Slovis	tvSeries	Breaking Bad	Breaking Bad
Michael Slovis	movie	Nick and Norah's Infinite Playlist	Nick and Norah's Infinite Playlist
Michael Slovis	tvSeries	CSI: Crime Scene Investigation	CSI: Crime Scene Investigation
Michael Slovis	tvSeries	New Amsterdam	New Amsterdam
Michelle MacLaren	tvSeries	The Walking Dead	The Walking Dead
Michelle MacLaren	tvSeries	Breaking Bad	Breaking Bad
Michelle MacLaren	tvSeries	The X-Files	The X Files
Michelle MacLaren	tvSeries	Game of Thrones	Game of Thrones

*/