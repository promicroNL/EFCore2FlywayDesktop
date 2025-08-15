SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Dropping foreign keys from [dbo].[Bottles]'
GO
ALTER TABLE [dbo].[Bottles] DROP CONSTRAINT [FK_Bottles_Distilleries_DistilleryId]
GO
PRINT N'Dropping foreign keys from [dbo].[Orders]'
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_Bottles_BottleId]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_Customers_CustomerId]
GO
PRINT N'Dropping foreign keys from [dbo].[Tastings]'
GO
ALTER TABLE [dbo].[Tastings] DROP CONSTRAINT [FK_Tastings_Bottles_BottleId]
GO
ALTER TABLE [dbo].[Tastings] DROP CONSTRAINT [FK_Tastings_Customers_CustomerId]
GO
PRINT N'Dropping index [IX_Bottles_DistilleryId] from [dbo].[Bottles]'
GO
DROP INDEX [IX_Bottles_DistilleryId] ON [dbo].[Bottles]
GO
PRINT N'Dropping index [IX_Orders_CustomerId] from [dbo].[Orders]'
GO
DROP INDEX [IX_Orders_CustomerId] ON [dbo].[Orders]
GO
PRINT N'Dropping index [IX_Orders_BottleId] from [dbo].[Orders]'
GO
DROP INDEX [IX_Orders_BottleId] ON [dbo].[Orders]
GO
PRINT N'Dropping index [IX_Tastings_BottleId] from [dbo].[Tastings]'
GO
DROP INDEX [IX_Tastings_BottleId] ON [dbo].[Tastings]
GO
PRINT N'Dropping index [IX_Tastings_CustomerId] from [dbo].[Tastings]'
GO
DROP INDEX [IX_Tastings_CustomerId] ON [dbo].[Tastings]
GO
PRINT N'Altering [dbo].[Distilleries]'
GO
ALTER TABLE [dbo].[Distilleries] ALTER COLUMN [Name] [nvarchar] (max) NOT NULL
GO
ALTER TABLE [dbo].[Distilleries] ALTER COLUMN [Location] [nvarchar] (max) NOT NULL
GO
PRINT N'Altering [dbo].[Bottles]'
GO
ALTER TABLE [dbo].[Bottles] ALTER COLUMN [Name] [nvarchar] (max) NOT NULL
GO
ALTER TABLE [dbo].[Bottles] ALTER COLUMN [DistilleryId] [int] NOT NULL
GO
PRINT N'Creating index [IX_Bottles_DistilleryId] on [dbo].[Bottles]'
GO
CREATE NONCLUSTERED INDEX [IX_Bottles_DistilleryId] ON [dbo].[Bottles] ([DistilleryId])
GO
PRINT N'Altering [dbo].[Orders]'
GO
ALTER TABLE [dbo].[Orders] ALTER COLUMN [CustomerId] [int] NOT NULL
GO
ALTER TABLE [dbo].[Orders] ALTER COLUMN [BottleId] [int] NOT NULL
GO
PRINT N'Creating index [IX_Orders_CustomerId] on [dbo].[Orders]'
GO
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerId] ON [dbo].[Orders] ([CustomerId])
GO
PRINT N'Creating index [IX_Orders_BottleId] on [dbo].[Orders]'
GO
CREATE NONCLUSTERED INDEX [IX_Orders_BottleId] ON [dbo].[Orders] ([BottleId])
GO
PRINT N'Altering [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] ALTER COLUMN [FirstName] [nvarchar] (max) NOT NULL
GO
ALTER TABLE [dbo].[Customers] ALTER COLUMN [LastName] [nvarchar] (max) NOT NULL
GO
ALTER TABLE [dbo].[Customers] ALTER COLUMN [Address] [nvarchar] (max) NULL
GO
PRINT N'Adding constraints to [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [DF__Customers__Addre__45F365D3] DEFAULT (N'') FOR [Address]
GO
PRINT N'Altering [dbo].[Customers]'
GO
UPDATE [dbo].[Customers] SET [Address]=DEFAULT WHERE [Address] IS NULL
GO
ALTER TABLE [dbo].[Customers] ALTER COLUMN [Address] [nvarchar] (max) NOT NULL
GO
PRINT N'Altering [dbo].[Tastings]'
GO
ALTER TABLE [dbo].[Tastings] ALTER COLUMN [BottleId] [int] NOT NULL
GO
ALTER TABLE [dbo].[Tastings] ALTER COLUMN [CustomerId] [int] NOT NULL
GO
ALTER TABLE [dbo].[Tastings] ALTER COLUMN [Notes] [nvarchar] (max) NOT NULL
GO
PRINT N'Creating index [IX_Tastings_BottleId] on [dbo].[Tastings]'
GO
CREATE NONCLUSTERED INDEX [IX_Tastings_BottleId] ON [dbo].[Tastings] ([BottleId])
GO
PRINT N'Creating index [IX_Tastings_CustomerId] on [dbo].[Tastings]'
GO
CREATE NONCLUSTERED INDEX [IX_Tastings_CustomerId] ON [dbo].[Tastings] ([CustomerId])
GO
PRINT N'Adding foreign keys to [dbo].[Bottles]'
GO
ALTER TABLE [dbo].[Bottles] ADD CONSTRAINT [FK_Bottles_Distilleries_DistilleryId] FOREIGN KEY ([DistilleryId]) REFERENCES [dbo].[Distilleries] ([Id]) ON DELETE CASCADE
GO
PRINT N'Adding foreign keys to [dbo].[Orders]'
GO
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Bottles_BottleId] FOREIGN KEY ([BottleId]) REFERENCES [dbo].[Bottles] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([Id]) ON DELETE CASCADE
GO
PRINT N'Adding foreign keys to [dbo].[Tastings]'
GO
ALTER TABLE [dbo].[Tastings] ADD CONSTRAINT [FK_Tastings_Bottles_BottleId] FOREIGN KEY ([BottleId]) REFERENCES [dbo].[Bottles] ([Id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Tastings] ADD CONSTRAINT [FK_Tastings_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [dbo].[Customers] ([Id]) ON DELETE CASCADE
GO

