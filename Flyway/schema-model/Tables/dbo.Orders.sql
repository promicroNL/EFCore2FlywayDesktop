CREATE TABLE [dbo].[Orders]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NOT NULL,
[Date] [datetime2] NOT NULL,
[Total] [decimal] (18, 2) NOT NULL,
[BottleId] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([Id])
GO
CREATE NONCLUSTERED INDEX [IX_Orders_BottleId] ON [dbo].[Orders] ([BottleId])
GO
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerId] ON [dbo].[Orders] ([CustomerId])
GO
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Bottles_BottleId] FOREIGN KEY ([BottleId]) REFERENCES [dbo].[Bottles] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([Id]) ON DELETE CASCADE
GO
