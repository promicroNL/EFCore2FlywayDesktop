

IF OBJECT_ID(N'[__EFMigrationsHistory]') IS NULL
BEGIN
    CREATE TABLE [__EFMigrationsHistory] (
        [MigrationId] nvarchar(150) NOT NULL,
        [ProductVersion] nvarchar(32) NOT NULL, [FlywayInstallRank] INT NULL
        CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY ([MigrationId])
    );
END;
GO

BEGIN TRANSACTION;
GO

CREATE TABLE [Customers] (
    [Id] int NOT NULL IDENTITY,
    [FirstName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [DateOfBirth] datetime2 NOT NULL,
    CONSTRAINT [PK_Customers] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Distilleries] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [Location] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Distilleries] PRIMARY KEY ([Id])
);
GO

CREATE TABLE [Bottles] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [DistilleryId] int NOT NULL,
    [Age] int NOT NULL,
    [AlcoholByVolume] real NOT NULL,
    CONSTRAINT [PK_Bottles] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Bottles_Distilleries_DistilleryId] FOREIGN KEY ([DistilleryId]) REFERENCES [Distilleries] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Orders] (
    [Id] int NOT NULL IDENTITY,
    [CustomerId] int NOT NULL,
    [Date] datetime2 NOT NULL,
    [Total] decimal(18,2) NOT NULL,
    [BottleId] int NOT NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Orders_Bottles_BottleId] FOREIGN KEY ([BottleId]) REFERENCES [Bottles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Orders_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]) ON DELETE CASCADE
);
GO

CREATE TABLE [Tastings] (
    [Id] int NOT NULL IDENTITY,
    [BottleId] int NOT NULL,
    [CustomerId] int NOT NULL,
    [Date] datetime2 NOT NULL,
    [Rating] int NOT NULL,
    [Notes] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Tastings] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Tastings_Bottles_BottleId] FOREIGN KEY ([BottleId]) REFERENCES [Bottles] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Tastings_Customers_CustomerId] FOREIGN KEY ([CustomerId]) REFERENCES [Customers] ([Id]) ON DELETE CASCADE
);
GO

CREATE INDEX [IX_Bottles_DistilleryId] ON [Bottles] ([DistilleryId]);
GO

CREATE INDEX [IX_Orders_BottleId] ON [Orders] ([BottleId]);
GO

CREATE INDEX [IX_Orders_CustomerId] ON [Orders] ([CustomerId]);
GO

CREATE INDEX [IX_Tastings_BottleId] ON [Tastings] ([BottleId]);
GO

CREATE INDEX [IX_Tastings_CustomerId] ON [Tastings] ([CustomerId]);
GO

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20230106151357_InitialCreate', N'7.0.1');
GO

COMMIT;
GO


