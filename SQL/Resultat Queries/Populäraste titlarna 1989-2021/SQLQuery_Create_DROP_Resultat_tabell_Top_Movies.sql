USE [IMDB_Results]
GO

/****** Object:  Table [dbo].[Popular_Movies_1989_2021]    Script Date: 2022-04-05 12:58:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Popular_Movies_1989_2021]') AND type in (N'U'))
DROP TABLE [dbo].[Popular_Movies_1989_2021]
GO


CREATE TABLE [dbo].[Popular_Movies_1989_2021](
	[title_Id] [varchar](100) NOT NULL,
	[start_Year] [smallint] NULL,
	[title_Type] [varchar](50) NULL,
	[original_Title] [nvarchar](500) NULL,
	[average_Rating] [float] NULL,
	[num_Votes] [int] NULL,
	[Geners] [varchar](1000) NULL
)
GO


