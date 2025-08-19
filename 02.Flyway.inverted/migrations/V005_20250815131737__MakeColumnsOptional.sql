

BEGIN TRANSACTION;
GO

ALTER TABLE [Bottles] DROP CONSTRAINT [FK_Bottles_Distilleries_DistilleryId];
GO

ALTER TABLE [Orders] DROP CONSTRAINT [FK_Orders_Bottles_BottleId];
GO

ALTER TABLE [Orders] DROP CONSTRAINT [FK_Orders_Customers_CustomerId];
GO

ALTER TABLE [Tastings] DROP CONSTRAINT [FK_Tastings_Bottles_BottleId];
GO

ALTER TABLE [Tastings] DROP CONSTRAINT [FK_Tastings_Customers_CustomerId];
GO

DECLARE @var0 sysname;
SELECT @var0 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Tastings]') AND [c].[name] = N'Notes');
IF @var0 IS NOT NULL EXEC(N'ALTER TABLE [Tastings] DROP CONSTRAINT [' + @var0 + '];');
ALTER TABLE [Tastings] ALTER COLUMN [Notes] nvarchar(max) NULL;
GO

DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Tastings]') AND [c].[name] = N'CustomerId');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Tastings] DROP CONSTRAINT [' + @var1 + '];');
ALTER TABLE [Tastings] ALTER COLUMN [CustomerId] int NULL;
GO

DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Tastings]') AND [c].[name] = N'BottleId');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Tastings] DROP CONSTRAINT [' + @var2 + '];');
ALTER TABLE [Tastings] ALTER COLUMN [BottleId] int NULL;
GO

DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Orders]') AND [c].[name] = N'CustomerId');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Orders] DROP CONSTRAINT [' + @var3 + '];');
ALTER TABLE [Orders] ALTER COLUMN [CustomerId] int NULL;
GO

DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Orders]') AND [c].[name] = N'BottleId');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Orders] DROP CONSTRAINT [' + @var4 + '];');
ALTER TABLE [Orders] ALTER COLUMN [BottleId] int NULL;
GO

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Distilleries]') AND [c].[name] = N'Name');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Distilleries] DROP CONSTRAINT [' + @var5 + '];');
ALTER TABLE [Distilleries] ALTER COLUMN [Name] nvarchar(max) NULL;
GO

DECLARE @var6 sysname;
SELECT @var6 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Distilleries]') AND [c].[name] = N'Location');
IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [Distilleries] DROP CONSTRAINT [' + @var6 + '];');
ALTER TABLE [Distilleries] ALTER COLUMN [Location] nvarchar(max) NULL;
GO

DECLARE @var7 sysname;
SELECT @var7 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Customers]') AND [c].[name] = N'LastName');
IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [Customers] DROP CONSTRAINT [' + @var7 + '];');
ALTER TABLE [Customers] ALTER COLUMN [LastName] nvarchar(max) NULL;
GO

DECLARE @var8 sysname;
SELECT @var8 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Customers]') AND [c].[name] = N'FirstName');
IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [Customers] DROP CONSTRAINT [' + @var8 + '];');
ALTER TABLE [Customers] ALTER COLUMN [FirstName] nvarchar(max) NULL;
GO

DECLARE @var9 sysname;
SELECT @var9 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Customers]') AND [c].[name] = N'Address');
IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [Customers] DROP CONSTRAINT [' + @var9 + '];');
ALTER TABLE [Customers] ALTER COLUMN [Address] nvarchar(max) NULL;
GO

DECLARE @var10 sysname;
SELECT @var10 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Bottles]') AND [c].[name] = N'Name');
IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [Bottles] DROP CONSTRAINT [' + @var10 + '];');
ALTER TABLE [Bottles] ALTER COLUMN [Name] nvarchar(max) NULL;
GO

DECLARE @var11 sysname;
SELECT @var11 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Bottles]') AND [c].[name] = N'DistilleryId');
IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [Bottles] DROP CONSTRAINT [' + @var11 + '];');
ALTER TABLE [Bottles] ALTER COLUMN [DistilleryId] int NULL;
GO

ALTER TABLE [Bottles] ADD CONSTRAINT [FK_Bottles_Distilleries_DistilleryId] FOREIGN KEY ([DistilleryId]) REFERENCES [Distilleries] ([Id]);
GO

ALTER TABLE [Orders] ADD CONSTRAINT [FK_Orders_Bottles_BottleId] FOREIGN KEY ([BottleId]) REFERENCES [Bottles] ([Id]);
GO

ALTER TABLE [Orders] ADD CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]);
GO

ALTER TABLE [Tastings] ADD CONSTRAINT [FK_Tastings_Bottles_BottleId] FOREIGN KEY ([BottleId]) REFERENCES [Bottles] ([Id]);
GO

ALTER TABLE [Tastings] ADD CONSTRAINT [FK_Tastings_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250815131737_MakeColumnsOptional', N'7.0.1');
GO

COMMIT;
GO


