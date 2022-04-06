USE [IMDB_Results]
GO

 DROP TABLE IF  EXISTS [dbo].[Popular_TvSeries_1989_2021]


CREATE TABLE [dbo].[Popular_TvSeries_1989_2021](
	[title_Id] [varchar](100) NOT NULL,
	[start_Year] [smallint] NULL,
	[title_Type] [varchar](50) NULL,
	[original_Title] [nvarchar](500) NULL,
	[average_Rating] [float] NULL,
	[num_Votes] [int] NULL,
	[Geners] [varchar](1000) NULL
)
GO


