

BEGIN TRANSACTION;
GO

ALTER TABLE [Bottles] ADD [WhiskyBaseId] int NOT NULL DEFAULT 0;
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230106151419_AddedWhiskyBaseId', N'7.0.1');
GO

COMMIT;
GO


