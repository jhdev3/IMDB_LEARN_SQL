--Extra Info
--Spara Data i en Tabell
DROP VIEW Top_Movies_TvSeries;

CREATE VIEW  Top_Movies_TvSeries AS	--Vill hitta något syfte för att Testa View :) det här passar bra.
	SELECT * FROM Popular_Movies_1989_2021
	UNION ALL
	SELECT * FROM Popular_TvSeries_1989_2021
	
Select *  from Top_Movies_TvSeries
ORDER BY average_Rating DESC;
/* 
title_Id	start_Year	title_Type	original_Title	average_Rating	num_Votes	Geners
tt14650074	2021		tvSeries	Dhindora		9.8				113692			Comedy,Drama
tt14392248	2021		tvSeries	Aspirants		9.7				292331			Drama
tt12392504	2020	tvSeries	Scam 1992: The Harshad Mehta Story	9.6	138100	Biography,Crime,Drama
tt0903747	2008	tvSeries	Breaking Bad	9.5	1693469	Crime,Drama,Thriller
tt7657124	2008	tvSeries	The Heroes	9.4	163564	Animation,Drama,History
tt15097216	2021	movie	Jai Bhim	9.4	183559	Crime,Drama,Mystery
tt10189514	2020	movie	Soorarai Pottru	9.3	108897	Drama
tt0111161	1994	movie	The Shawshank Redemption	9.3	2565428	Drama
tt0417299	2005	tvSeries	Avatar: The Last Airbender	9.3	293589	Action,Adventure,Animation
tt1831164	2011	tvSeries	Leyla ile Mecnun	9.3	92880	Adventure,Comedy,Drama
tt0944947	2011	tvSeries	Game of Thrones	9.3	1967797	Action,Adventure,Drama
tt9432978	2019	tvSeries	Kota Factory	9.3	67060	Comedy,Drama
tt0417299	2005	tvSeries	Avatar: The Last Airbender	9.3	293589	Action,Adventure,Animation
tt0306414	2002	tvSeries	The Wire	9.3	322314	Crime,Drama,Thriller
tt0141842	1999	tvSeries	The Sopranos	9.2	367750	Crime,Drama
tt2861424	2013	tvSeries	Rick and Morty	9.2	467405	Adventure,Animation,Comedy
tt2861424	2013	tvSeries	Rick and Morty	9.2	467405	Adventure,Animation,Comedy
tt2560140	2013	tvSeries	Shingeki no Kyojin	9.1	334617	Action,Adventure,Animation
tt1355642	2009	tvSeries	Hagane no renkinjutsushi	9.1	153867	Action,Adventure,Animation
tt1475582	2010	tvSeries	Sherlock	9.1	884996	Crime,Drama,Mystery


*/

Select start_year, Count(*) AS [Number_of_Titles] from Top_Movies_TvSeries
GROUP BY start_year
order by start_year

/* 
start_year	Number_of_Titles	start_year	Number_of_Titles
1989	6							2005		13
1990	4							2006		6
1991	2							2007		3
1992	3							2008		4
1993	5							2009		5
1994	7							2010		7
1995	8							2011		7
1996	4							2012		8
1997	16							2013		8
1998	3							2014		6
1999	8							2015		3
2000	5							2016		5
2001	4							2017		4
2002	7							2018		6
2003	6							2019		9
2004	4							2020		7
									2021		6
*/

Select start_year, title_Type ,original_Title, average_Rating, Geners  from Top_Movies_TvSeries as T1
GROUP BY start_year,title_Type ,original_Title, average_Rating, Geners
HAVING average_Rating = (SELECT MAX(average_Rating) from Top_Movies_TvSeries as T2						
						 where T1.start_year = T2.start_year)
order by start_year

/* 
	start_year	title_Type	original_Title	average_Rating	Geners
	1989	tvSeries	Seinfeld	8.9	Comedy
	1990	tvSeries	Twin Peaks	8.8	Crime,Drama,Mystery
	1991	movie	Terminator 2: Judgment Day	8.6	Action,Sci-Fi
	1991	movie	The Silence of the Lambs	8.6	Crime,Drama,Thriller
	1992	tvSeries	Batman: The Animated Series	9	Action,Adventure,Animation
	1993	movie	Schindler's List	9	Biography,Drama,History
	1994	movie	The Shawshank Redemption	9.3	Drama
	1995	movie	Se7en	8.6	Crime,Drama,Mystery
	1995	tvSeries	Dragon Ball	8.6	Action,Adventure,Animation
	1996	movie	Eskiya	8.2	Crime,Drama,Thriller
	1996	movie	Trainspotting	8.2	Drama
	1997	tvSeries	South Park	8.8	Animation,Comedy
	1998	tvSeries	Kaubôi bibappu	8.9	Action,Adventure,Animation
	1999	tvSeries	The Sopranos	9.2	Crime,Drama
	2000	tvSeries	Curb Your Enthusiasm	8.8	Comedy
	2001	movie	The Lord of the Rings: The Fellowship of the Ring	8.9	Action,Adventure,Drama
	2002	tvSeries	The Wire	9.3	Crime,Drama,Thriller
	2003	movie	The Lord of the Rings: The Return of the King	9	Action,Adventure,Drama
	2004	tvSeries	House M.D.	8.8	Drama,Mystery
	2005	tvSeries	Avatar: The Last Airbender	9.3	Action,Adventure,Animation
	2006	tvSeries	Death Note: Desu nôto	9	Animation,Crime,Drama
	2007	tvSeries	Naruto: Shippûden	8.8	Action,Adventure,Animation
	2008	tvSeries	Breaking Bad	9.5	Crime,Drama,Thriller
	2009	tvSeries	Hagane no renkinjutsushi	9.1	Action,Adventure,Animation
	2010	tvSeries	Sherlock	9.1	Crime,Drama,Mystery
	2011	tvSeries	Game of Thrones	9.3	Action,Adventure,Drama
	2011	tvSeries	Leyla ile Mecnun	9.3	Adventure,Comedy,Drama
	2012	tvSeries	Gravity Falls	8.9	Action,Adventure,Animation
	2013	tvSeries	Rick and Morty	9.2	Adventure,Animation,Comedy
	2014	tvSeries	Fargo	8.9	Crime,Drama,Thriller
	2014	tvSeries	Last Week Tonight with John Oliver	8.9	Comedy,History,News
	2014	tvSeries	True Detective	8.9	Crime,Drama,Mystery
	2015	tvSeries	Better Call Saul	8.8	Crime,Drama
	2015	tvSeries	Narcos	8.8	Biography,Crime,Drama
	2015	tvSeries	One Punch Man: Wanpanman	8.8	Action,Animation,Comedy
	2016	movie	Dag II	9	Action,Drama,War
	2017	tvSeries	Dark	8.8	Crime,Drama,Mystery
	2018	tvSeries	Yellowstone	8.9	Drama,Western
	2019	tvSeries	Kota Factory	9.3	Comedy,Drama
	2020	tvSeries	Scam 1992: The Harshad Mehta Story	9.6	Biography,Crime,Drama
	2021	tvSeries	Dhindora	9.8	Comedy,Drama

*/

---Movies  --------

