CREATE TABLE [dbo].[Distilleries]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (max) NOT NULL,
[Location] [nvarchar] (max) NOT NULL
)
GO
ALTER TABLE [dbo].[Distilleries] ADD CONSTRAINT [PK_Distilleries] PRIMARY KEY CLUSTERED ([Id])
GO
