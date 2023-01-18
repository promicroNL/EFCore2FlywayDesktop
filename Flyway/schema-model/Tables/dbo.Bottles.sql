CREATE TABLE [dbo].[Bottles]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (max) NOT NULL,
[DistilleryId] [int] NOT NULL,
[Age] [int] NOT NULL,
[AlcoholByVolume] [real] NOT NULL,
[WhiskyBaseId] [int] NOT NULL CONSTRAINT [DF__Bottles__WhiskyB__47DBAE45] DEFAULT ((0))
)
GO
ALTER TABLE [dbo].[Bottles] ADD CONSTRAINT [PK_Bottles] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE NONCLUSTERED INDEX [IX_Bottles_DistilleryId] ON [dbo].[Bottles] ([DistilleryId])
GO
ALTER TABLE [dbo].[Bottles] ADD CONSTRAINT [FK_Bottles_Distilleries_DistilleryId] FOREIGN KEY ([DistilleryId]) REFERENCES [dbo].[Distilleries] ([Id]) ON DELETE CASCADE
GO
