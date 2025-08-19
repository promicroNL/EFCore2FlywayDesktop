CREATE TABLE [dbo].[Tastings]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[BottleId] [int] NULL,
[CustomerId] [int] NULL,
[Date] [datetime2] NOT NULL,
[Rating] [int] NOT NULL,
[Notes] [nvarchar] (max) NULL
)
GO
ALTER TABLE [dbo].[Tastings] ADD CONSTRAINT [PK_Tastings] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE NONCLUSTERED INDEX [IX_Tastings_BottleId] ON [dbo].[Tastings] ([BottleId])
GO
CREATE NONCLUSTERED INDEX [IX_Tastings_CustomerId] ON [dbo].[Tastings] ([CustomerId])
GO
ALTER TABLE [dbo].[Tastings] ADD CONSTRAINT [FK_Tastings_Bottles_BottleId] FOREIGN KEY ([BottleId]) REFERENCES [dbo].[Bottles] ([Id])
GO
ALTER TABLE [dbo].[Tastings] ADD CONSTRAINT [FK_Tastings_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([Id])
GO
