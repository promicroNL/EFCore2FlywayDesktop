CREATE TABLE [dbo].[Distilleries]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (max) NULL,
[Location] [nvarchar] (max) NULL
)
GO
ALTER TABLE [dbo].[Distilleries] ADD CONSTRAINT [PK_Distilleries] PRIMARY KEY CLUSTERED ([Id])
GO
