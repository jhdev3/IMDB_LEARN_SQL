


SELECT  start_year, COUNT(*) from Popular_Movies_1989_2021
GROUP BY start_year
--Intressant 2015 Inget bra år för MOVIES enda året som inte hade titel samt 2012 med 7 titlar ett år där kvaliten var något extra:)
/* 
2005	3		1989	1
2006	3		1990	1
2007	1		1991	2
2008	2		1992	2
2009	3		1993	2
2010	4		1994	5
2011	2		1995	5
2012	7		1996	2
2013	2		1997	9
2014	2		1998	2
2016	3		1999	4
2017	2		2000	4
2018	4		2001	3
2019	5		2002	3
2020	5		2003	2
2021	3		2004	2
*/

/*
--TOP Movies Each Year förutom 2015 ;)
*/



Select start_year ,original_Title, average_Rating, Geners  from Popular_Movies_1989_2021 as T1
GROUP BY start_year ,original_Title, average_Rating, Geners
HAVING average_Rating = (SELECT MAX(average_Rating) from Popular_Movies_1989_2021 as T2						
						 where T1.start_year = T2.start_year)
order by average_Rating DESC
/* 
start_year	original_Title	average_Rating	Geners
2021	Jai Bhim	9.4	Crime,Drama,Mystery
1994	The Shawshank Redemption	9.3	Drama
2020	Soorarai Pottru	9.3	Drama
2008	The Dark Knight	9.1	Action,Crime,Drama
1993	Schindler's List	9	Biography,Drama,History
2003	The Lord of the Rings: The Return of the King	9	Action,Adventure,Drama
2016	Dag II	9	Action,Drama,War
2001	The Lord of the Rings: The Fellowship of the Ring	8.9	Action,Adventure,Drama
1999	Fight Club	8.8	Drama
2002	The Lord of the Rings: The Two Towers	8.8	Action,Adventure,Drama
2010	Inception	8.8	Action,Adventure,Sci-Fi
1990	Goodfellas	8.7	Biography,Crime,Drama
2014	Interstellar	8.7	Adventure,Drama,Sci-Fi
1991	Terminator 2: Judgment Day	8.6	Action,Sci-Fi
1991	The Silence of the Lambs	8.6	Crime,Drama,Thriller
1995	Se7en	8.6	Crime,Drama,Mystery
1997	La vita è bella	8.6	Comedy,Drama,Romance
1998	Saving Private Ryan	8.6	Drama,War
2000	Gladiator	8.5	Action,Adventure,Drama
2000	Memento	8.5	Mystery,Thriller
2006	The Departed	8.5	Crime,Drama,Thriller
2006	The Prestige	8.5	Drama,Mystery,Thriller
2009	3 Idiots	8.5	Comedy,Drama
2011	Intouchables	8.5	Biography,Comedy,Drama
2012	Django Unchained	8.5	Drama,Western
2018	Avengers: Infinity War	8.5	Action,Adventure,Sci-Fi
2018	K.G.F: Chapter 1	8.5	Action,Crime,Drama
2019	Gisaengchung	8.5	Comedy,Drama,Thriller
2007	Taare Zameen Par	8.4	Drama,Family
2017	Coco	8.4	Adventure,Animation,Comedy
1989	Indiana Jones and the Last Crusade	8.3	Action,Adventure
1992	Reservoir Dogs	8.3	Crime,Drama,Thriller
2004	Eternal Sunshine of the Spotless Mind	8.3	Drama,Romance,Sci-Fi
2004	Swades: We, the People	8.3	Drama,Musical
2005	Babam ve Oglum	8.3	Drama,Family
2005	Batman Begins	8.3	Action,Crime,Drama
2013	Bhaag Milkha Bhaag	8.3	Biography,Drama,Sport
1996	Eskiya	8.2	Crime,Drama,Thriller
1996	Trainspotting	8.2	Drama
*/