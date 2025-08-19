CREATE TABLE [dbo].[__EFMigrationsHistory]
(
[MigrationId] [nvarchar] (150) NOT NULL,
[ProductVersion] [nvarchar] (32) NOT NULL,
[FlywayInstallRank] [int] NULL
)
GO
ALTER TABLE [dbo].[__EFMigrationsHistory] ADD CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED ([MigrationId])
GO
