USE [CEGsales]
GO

/****** Object:  Table [dbo].[������]    Script Date: 15.03.2022 17:21:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[������](
	[�����_������] [nvarchar](10) NOT NULL,
	[������������_������] [nvarchar](20) NOT NULL,
	[����_�������] [real] NOT NULL,
	[����������] [int] NOT NULL,
	[����_��������] [date] NOT NULL,
	[��������] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_������] PRIMARY KEY CLUSTERED 
(
	[�����_������] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[������]  WITH CHECK ADD  CONSTRAINT [FK_������_���������] FOREIGN KEY([��������])
REFERENCES [dbo].[���������] ([������������_�����])
GO

ALTER TABLE [dbo].[������] CHECK CONSTRAINT [FK_������_���������]
GO

ALTER TABLE [dbo].[������]  WITH CHECK ADD  CONSTRAINT [FK_������_������] FOREIGN KEY([������������_������])
REFERENCES [dbo].[������] ([������������])
GO

ALTER TABLE [dbo].[������] CHECK CONSTRAINT [FK_������_������]
GO


