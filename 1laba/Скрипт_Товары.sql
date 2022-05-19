USE [CEGsales]
GO

/****** Object:  Table [dbo].[������]    Script Date: 15.03.2022 17:21:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[������](
	[������������] [nvarchar](20) NOT NULL,
	[����] [real] NOT NULL,
	[����������] [int] NOT NULL,
 CONSTRAINT [PK_������] PRIMARY KEY CLUSTERED 
(
	[������������] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO