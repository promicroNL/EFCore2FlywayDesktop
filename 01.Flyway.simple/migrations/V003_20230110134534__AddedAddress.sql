

BEGIN TRANSACTION;
GO

ALTER TABLE [Customers] ADD [Address] nvarchar(max) NOT NULL DEFAULT N'';
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230110134534_AddedAddress', N'7.0.1');
GO

COMMIT;
GO


