USE [BugLog]
GO
/****** Object:  Table [dbo].[Bugs]    Script Date: 09/09/2018 16:18:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bugs](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [ntext] NOT NULL,
	[Description] [ntext] NOT NULL,
	[Status] [nvarchar](50) NOT NULL CONSTRAINT [DF_Bugs_Status]  DEFAULT (N'Reported'),
	[UserID] [int] NULL CONSTRAINT [DF_Bugs_UserID]  DEFAULT ((-1)),
 CONSTRAINT [PK_Bugs] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
ALTER TABLE [dbo].[Bugs]  WITH CHECK ADD  CONSTRAINT [FK_Bugs_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[Bugs] CHECK CONSTRAINT [FK_Bugs_Users]