


SELECT  start_year, COUNT(*) from Popular_TvSeries_1989_2021
GROUP BY start_year
--Intressant 1991 Inget bra år för TV-Series enda året som inte hade titel samt 2005 med 10 titlar samt 1997 är extra bra år där kvaliten var något extra:)
/* 
1989	5		2006	3
1990	3		2007	2
1992	1		2008	2
1993	3		2009	2
1994	2		2010	3
1995	3		2011	5
1996	2		2012	1
1997	7		2013	6
1998	1		2014	4
1999	4		2015	3
2000	1		2016	2
2001	1		2017	2
2002	4		2018	2
2003	4		2019	4
2004	2		2020	2
2005	10		2021	3
*/

/*
--TOP Movies Each Year förutom 2015 ;)
*/



Select start_year ,original_Title, average_Rating, Geners  from Popular_TvSeries_1989_2021 as T1
GROUP BY start_year ,original_Title, average_Rating, Geners
HAVING average_Rating = (SELECT MAX(average_Rating) from Popular_TvSeries_1989_2021 as T2						
						 where T1.start_year = T2.start_year)
order by average_Rating DESC
--Finns Dubblerade årtal dvs då de har samma rating, Du får kolla på serien/Filmen för att avgöra själv vilken som är bäst ;)
/* 
start_year	original_Title	average_Rating	Geners
2021	Dhindora	9.8	Comedy,Drama
2020	Scam 1992: The Harshad Mehta Story	9.6	Biography,Crime,Drama
2008	Breaking Bad	9.5	Crime,Drama,Thriller
2002	The Wire	9.3	Crime,Drama,Thriller
2005	Avatar: The Last Airbender	9.3	Action,Adventure,Animation
2011	Game of Thrones	9.3	Action,Adventure,Drama
2011	Leyla ile Mecnun	9.3	Adventure,Comedy,Drama
2019	Kota Factory	9.3	Comedy,Drama
1999	The Sopranos	9.2	Crime,Drama
2013	Rick and Morty	9.2	Adventure,Animation,Comedy
2009	Hagane no renkinjutsushi	9.1	Action,Adventure,Animation
2010	Sherlock	9.1	Crime,Drama,Mystery
1992	Batman: The Animated Series	9	Action,Adventure,Animation
1994	Friends	9	Comedy,Romance
2006	Death Note: Desu nôto	9	Animation,Crime,Drama
1989	Seinfeld	8.9	Comedy
1998	Kaubôi bibappu	8.9	Action,Adventure,Animation
2012	Gravity Falls	8.9	Action,Adventure,Animation
2014	Fargo	8.9	Crime,Drama,Thriller
2014	Last Week Tonight with John Oliver	8.9	Comedy,History,News
2014	True Detective	8.9	Crime,Drama,Mystery
2018	Yellowstone	8.9	Drama,Western
1990	Twin Peaks	8.8	Crime,Drama,Mystery
1997	South Park	8.8	Animation,Comedy
2000	Curb Your Enthusiasm	8.8	Comedy
2001	Six Feet Under	8.8	Comedy,Drama
2003	Chappelle's Show	8.8	Comedy,Music
2004	House M.D.	8.8	Drama,Mystery
2007	Naruto: Shippûden	8.8	Action,Adventure,Animation
2015	Better Call Saul	8.8	Crime,Drama
2015	Narcos	8.8	Biography,Crime,Drama
2015	One Punch Man: Wanpanman	8.8	Action,Animation,Comedy
2016	The Grand Tour	8.8	Comedy,Sport,Talk-Show
2017	Dark	8.8	Crime,Drama,Mystery
1993	The X Files	8.7	Crime,Drama,Mystery
1995	Dragon Ball	8.6	Action,Adventure,Animation
1996	3rd Rock from the Sun	7.8	Comedy,Family,Sci-Fi
*/