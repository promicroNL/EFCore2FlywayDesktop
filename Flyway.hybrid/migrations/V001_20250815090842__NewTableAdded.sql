SET NUMERIC_ROUNDABORT OFF
GO
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT, QUOTED_IDENTIFIER, ANSI_NULLS ON
GO
PRINT N'Creating [dbo].[Bottles]'
GO
CREATE TABLE [dbo].[Bottles]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (max) NOT NULL,
[DistilleryId] [int] NOT NULL,
[Age] [int] NOT NULL,
[AlcoholByVolume] [real] NOT NULL,
[WhiskyBaseId] [int] NOT NULL CONSTRAINT [DF__Bottles__WhiskyB__44FF419A] DEFAULT ((0))
)
GO
PRINT N'Creating primary key [PK_Bottles] on [dbo].[Bottles]'
GO
ALTER TABLE [dbo].[Bottles] ADD CONSTRAINT [PK_Bottles] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating index [IX_Bottles_DistilleryId] on [dbo].[Bottles]'
GO
CREATE NONCLUSTERED INDEX [IX_Bottles_DistilleryId] ON [dbo].[Bottles] ([DistilleryId])
GO
PRINT N'Creating [dbo].[Customers]'
GO
CREATE TABLE [dbo].[Customers]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (max) NOT NULL,
[LastName] [nvarchar] (max) NOT NULL,
[DateOfBirth] [datetime2] NOT NULL,
[Address] [nvarchar] (max) NOT NULL CONSTRAINT [DF__Customers__Addre__45F365D3] DEFAULT (N'')
)
GO
PRINT N'Creating primary key [PK_Customers] on [dbo].[Customers]'
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[Distilleries]'
GO
CREATE TABLE [dbo].[Distilleries]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (max) NOT NULL,
[Location] [nvarchar] (max) NOT NULL
)
GO
PRINT N'Creating primary key [PK_Distilleries] on [dbo].[Distilleries]'
GO
ALTER TABLE [dbo].[Distilleries] ADD CONSTRAINT [PK_Distilleries] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating [dbo].[Orders]'
GO
CREATE TABLE [dbo].[Orders]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[CustomerId] [int] NOT NULL,
[Date] [datetime2] NOT NULL,
[Total] [int] NOT NULL,
[BottleId] [int] NOT NULL
)
GO
PRINT N'Creating primary key [PK_Orders] on [dbo].[Orders]'
GO
ALTER TABLE [dbo].[Orders] ADD CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating index [IX_Orders_BottleId] on [dbo].[Orders]'
GO
CREATE NONCLUSTERED INDEX [IX_Orders_BottleId] ON [dbo].[Orders] ([BottleId])
GO
PRINT N'Creating index [IX_Orders_CustomerId] on [dbo].[Orders]'
GO
CREATE NONCLUSTERED INDEX [IX_Orders_CustomerId] ON [dbo].[Orders] ([CustomerId])
GO
PRINT N'Creating [dbo].[Tastings]'
GO
CREATE TABLE [dbo].[Tastings]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[BottleId] [int] NOT NULL,
[CustomerId] [int] NOT NULL,
[Date] [datetime2] NOT NULL,
[Rating] [int] NOT NULL,
[Notes] [nvarchar] (max) NOT NULL
)
GO
PRINT N'Creating primary key [PK_Tastings] on [dbo].[Tastings]'
GO
ALTER TABLE [dbo].[Tastings] ADD CONSTRAINT [PK_Tastings] PRIMARY KEY CLUSTERED ([Id])
GO
PRINT N'Creating index [IX_Tastings_BottleId] on [dbo].[Tastings]'
GO
CREATE NONCLUSTERED INDEX [IX_Tastings_BottleId] ON [dbo].[Tastings] ([BottleId])
GO
PRINT N'Creating index [IX_Tastings_CustomerId] on [dbo].[Tastings]'
GO
CREATE NONCLUSTERED INDEX [IX_Tastings_CustomerId] ON [dbo].[Tastings] ([CustomerId])
GO
PRINT N'Creating [dbo].[__EFMigrationsHistory]'
GO
CREATE TABLE [dbo].[__EFMigrationsHistory]
(
[MigrationId] [nvarchar] (150) NOT NULL,
[ProductVersion] [nvarchar] (32) NOT NULL
)
GO
PRINT N'Creating primary key [PK___EFMigrationsHistory] on [dbo].[__EFMigrationsHistory]'
GO
ALTER TABLE [dbo].[__EFMigrationsHistory] ADD CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED ([MigrationId])
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
PRINT N'Adding foreign keys to [dbo].[Bottles]'
GO
ALTER TABLE [dbo].[Bottles] ADD CONSTRAINT [FK_Bottles_Distilleries_DistilleryId] FOREIGN KEY ([DistilleryId]) REFERENCES [dbo].[Distilleries] ([Id]) ON DELETE CASCADE
GO

