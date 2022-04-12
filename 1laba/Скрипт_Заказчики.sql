USE [CEGsales]
GO

/****** Object:  Table [dbo].[Заказчики]    Script Date: 15.03.2022 17:14:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Заказчики](
	[Наименование_фирмы] [nvarchar](20) NOT NULL,
	[Адрес] [nvarchar](50) NOT NULL,
	[Расчётный_счёт] [nvarchar](15) NOT NULL,
 CONSTRAINT [PK_Заказчики] PRIMARY KEY CLUSTERED 
(
	[Наименование_фирмы] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


