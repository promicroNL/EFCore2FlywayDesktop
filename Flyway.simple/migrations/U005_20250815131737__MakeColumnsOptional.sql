

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
UPDATE [Tastings] SET [Notes] = N'' WHERE [Notes] IS NULL;
ALTER TABLE [Tastings] ALTER COLUMN [Notes] nvarchar(max) NOT NULL;
ALTER TABLE [Tastings] ADD DEFAULT N'' FOR [Notes];
GO

DROP INDEX [IX_Tastings_CustomerId] ON [Tastings];
DECLARE @var1 sysname;
SELECT @var1 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Tastings]') AND [c].[name] = N'CustomerId');
IF @var1 IS NOT NULL EXEC(N'ALTER TABLE [Tastings] DROP CONSTRAINT [' + @var1 + '];');
UPDATE [Tastings] SET [CustomerId] = 0 WHERE [CustomerId] IS NULL;
ALTER TABLE [Tastings] ALTER COLUMN [CustomerId] int NOT NULL;
ALTER TABLE [Tastings] ADD DEFAULT 0 FOR [CustomerId];
CREATE INDEX [IX_Tastings_CustomerId] ON [Tastings] ([CustomerId]);
GO

DROP INDEX [IX_Tastings_BottleId] ON [Tastings];
DECLARE @var2 sysname;
SELECT @var2 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Tastings]') AND [c].[name] = N'BottleId');
IF @var2 IS NOT NULL EXEC(N'ALTER TABLE [Tastings] DROP CONSTRAINT [' + @var2 + '];');
UPDATE [Tastings] SET [BottleId] = 0 WHERE [BottleId] IS NULL;
ALTER TABLE [Tastings] ALTER COLUMN [BottleId] int NOT NULL;
ALTER TABLE [Tastings] ADD DEFAULT 0 FOR [BottleId];
CREATE INDEX [IX_Tastings_BottleId] ON [Tastings] ([BottleId]);
GO

DROP INDEX [IX_Orders_CustomerId] ON [Orders];
DECLARE @var3 sysname;
SELECT @var3 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Orders]') AND [c].[name] = N'CustomerId');
IF @var3 IS NOT NULL EXEC(N'ALTER TABLE [Orders] DROP CONSTRAINT [' + @var3 + '];');
UPDATE [Orders] SET [CustomerId] = 0 WHERE [CustomerId] IS NULL;
ALTER TABLE [Orders] ALTER COLUMN [CustomerId] int NOT NULL;
ALTER TABLE [Orders] ADD DEFAULT 0 FOR [CustomerId];
CREATE INDEX [IX_Orders_CustomerId] ON [Orders] ([CustomerId]);
GO

DROP INDEX [IX_Orders_BottleId] ON [Orders];
DECLARE @var4 sysname;
SELECT @var4 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Orders]') AND [c].[name] = N'BottleId');
IF @var4 IS NOT NULL EXEC(N'ALTER TABLE [Orders] DROP CONSTRAINT [' + @var4 + '];');
UPDATE [Orders] SET [BottleId] = 0 WHERE [BottleId] IS NULL;
ALTER TABLE [Orders] ALTER COLUMN [BottleId] int NOT NULL;
ALTER TABLE [Orders] ADD DEFAULT 0 FOR [BottleId];
CREATE INDEX [IX_Orders_BottleId] ON [Orders] ([BottleId]);
GO

DECLARE @var5 sysname;
SELECT @var5 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Distilleries]') AND [c].[name] = N'Name');
IF @var5 IS NOT NULL EXEC(N'ALTER TABLE [Distilleries] DROP CONSTRAINT [' + @var5 + '];');
UPDATE [Distilleries] SET [Name] = N'' WHERE [Name] IS NULL;
ALTER TABLE [Distilleries] ALTER COLUMN [Name] nvarchar(max) NOT NULL;
ALTER TABLE [Distilleries] ADD DEFAULT N'' FOR [Name];
GO

DECLARE @var6 sysname;
SELECT @var6 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Distilleries]') AND [c].[name] = N'Location');
IF @var6 IS NOT NULL EXEC(N'ALTER TABLE [Distilleries] DROP CONSTRAINT [' + @var6 + '];');
UPDATE [Distilleries] SET [Location] = N'' WHERE [Location] IS NULL;
ALTER TABLE [Distilleries] ALTER COLUMN [Location] nvarchar(max) NOT NULL;
ALTER TABLE [Distilleries] ADD DEFAULT N'' FOR [Location];
GO

DECLARE @var7 sysname;
SELECT @var7 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Customers]') AND [c].[name] = N'LastName');
IF @var7 IS NOT NULL EXEC(N'ALTER TABLE [Customers] DROP CONSTRAINT [' + @var7 + '];');
UPDATE [Customers] SET [LastName] = N'' WHERE [LastName] IS NULL;
ALTER TABLE [Customers] ALTER COLUMN [LastName] nvarchar(max) NOT NULL;
ALTER TABLE [Customers] ADD DEFAULT N'' FOR [LastName];
GO

DECLARE @var8 sysname;
SELECT @var8 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Customers]') AND [c].[name] = N'FirstName');
IF @var8 IS NOT NULL EXEC(N'ALTER TABLE [Customers] DROP CONSTRAINT [' + @var8 + '];');
UPDATE [Customers] SET [FirstName] = N'' WHERE [FirstName] IS NULL;
ALTER TABLE [Customers] ALTER COLUMN [FirstName] nvarchar(max) NOT NULL;
ALTER TABLE [Customers] ADD DEFAULT N'' FOR [FirstName];
GO

DECLARE @var9 sysname;
SELECT @var9 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Customers]') AND [c].[name] = N'Address');
IF @var9 IS NOT NULL EXEC(N'ALTER TABLE [Customers] DROP CONSTRAINT [' + @var9 + '];');
UPDATE [Customers] SET [Address] = N'' WHERE [Address] IS NULL;
ALTER TABLE [Customers] ALTER COLUMN [Address] nvarchar(max) NOT NULL;
ALTER TABLE [Customers] ADD DEFAULT N'' FOR [Address];
GO

DECLARE @var10 sysname;
SELECT @var10 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Bottles]') AND [c].[name] = N'Name');
IF @var10 IS NOT NULL EXEC(N'ALTER TABLE [Bottles] DROP CONSTRAINT [' + @var10 + '];');
UPDATE [Bottles] SET [Name] = N'' WHERE [Name] IS NULL;
ALTER TABLE [Bottles] ALTER COLUMN [Name] nvarchar(max) NOT NULL;
ALTER TABLE [Bottles] ADD DEFAULT N'' FOR [Name];
GO

DROP INDEX [IX_Bottles_DistilleryId] ON [Bottles];
DECLARE @var11 sysname;
SELECT @var11 = [d].[name]
FROM [sys].[default_constraints] [d]
INNER JOIN [sys].[columns] [c] ON [d].[parent_column_id] = [c].[column_id] AND [d].[parent_object_id] = [c].[object_id]
WHERE ([d].[parent_object_id] = OBJECT_ID(N'[Bottles]') AND [c].[name] = N'DistilleryId');
IF @var11 IS NOT NULL EXEC(N'ALTER TABLE [Bottles] DROP CONSTRAINT [' + @var11 + '];');
UPDATE [Bottles] SET [DistilleryId] = 0 WHERE [DistilleryId] IS NULL;
ALTER TABLE [Bottles] ALTER COLUMN [DistilleryId] int NOT NULL;
ALTER TABLE [Bottles] ADD DEFAULT 0 FOR [DistilleryId];
CREATE INDEX [IX_Bottles_DistilleryId] ON [Bottles] ([DistilleryId]);
GO

ALTER TABLE [Bottles] ADD CONSTRAINT [FK_Bottles_Distilleries_DistilleryId] FOREIGN KEY ([DistilleryId]) REFERENCES [Distilleries] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [Orders] ADD CONSTRAINT [FK_Orders_Bottles_BottleId] FOREIGN KEY ([BottleId]) REFERENCES [Bottles] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [Orders] ADD CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [Tastings] ADD CONSTRAINT [FK_Tastings_Bottles_BottleId] FOREIGN KEY ([BottleId]) REFERENCES [Bottles] ([Id]) ON DELETE CASCADE;
GO

ALTER TABLE [Tastings] ADD CONSTRAINT [FK_Tastings_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]) ON DELETE CASCADE;
GO

DELETE FROM [__EFMigrationsHistory]
WHERE [MigrationId] = N'20250815131737_MakeColumnsOptional';
GO

COMMIT;
GO


