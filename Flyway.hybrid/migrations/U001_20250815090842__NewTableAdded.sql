SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
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
PRINT N'Dropping foreign keys from [dbo].[Bottles]'
GO
ALTER TABLE [dbo].[Bottles] DROP CONSTRAINT [FK_Bottles_Distilleries_DistilleryId]
GO
PRINT N'Dropping constraints from [dbo].[Bottles]'
GO
ALTER TABLE [dbo].[Bottles] DROP CONSTRAINT [PK_Bottles]
GO
PRINT N'Dropping constraints from [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] DROP CONSTRAINT [PK_Customers]
GO
PRINT N'Dropping constraints from [dbo].[Distilleries]'
GO
ALTER TABLE [dbo].[Distilleries] DROP CONSTRAINT [PK_Distilleries]
GO
PRINT N'Dropping constraints from [dbo].[Orders]'
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [PK_Orders]
GO
PRINT N'Dropping constraints from [dbo].[Tastings]'
GO
ALTER TABLE [dbo].[Tastings] DROP CONSTRAINT [PK_Tastings]
GO
PRINT N'Dropping constraints from [dbo].[__EFMigrationsHistory]'
GO
ALTER TABLE [dbo].[__EFMigrationsHistory] DROP CONSTRAINT [PK___EFMigrationsHistory]
GO
PRINT N'Dropping constraints from [dbo].[Bottles]'
GO
ALTER TABLE [dbo].[Bottles] DROP CONSTRAINT [DF__Bottles__WhiskyB__44FF419A]
GO
PRINT N'Dropping constraints from [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] DROP CONSTRAINT [DF__Customers__Addre__45F365D3]
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
PRINT N'Dropping [dbo].[__EFMigrationsHistory]'
GO
DROP TABLE [dbo].[__EFMigrationsHistory]
GO
PRINT N'Dropping [dbo].[Tastings]'
GO
DROP TABLE [dbo].[Tastings]
GO
PRINT N'Dropping [dbo].[Orders]'
GO
DROP TABLE [dbo].[Orders]
GO
PRINT N'Dropping [dbo].[Distilleries]'
GO
DROP TABLE [dbo].[Distilleries]
GO
PRINT N'Dropping [dbo].[Customers]'
GO
DROP TABLE [dbo].[Customers]
GO
PRINT N'Dropping [dbo].[Bottles]'
GO
DROP TABLE [dbo].[Bottles]
GO

