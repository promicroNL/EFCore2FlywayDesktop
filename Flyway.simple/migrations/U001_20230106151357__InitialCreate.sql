

BEGIN TRANSACTION;
GO

DROP TABLE [Orders];
GO

DROP TABLE [Tastings];
GO

DROP TABLE [Bottles];
GO

DROP TABLE [Customers];
GO

DROP TABLE [Distilleries];
GO

DELETE FROM [__EFMigrationsHistory]
WHERE [MigrationId] = N'20230106151357_InitialCreate';
GO

COMMIT;
GO


