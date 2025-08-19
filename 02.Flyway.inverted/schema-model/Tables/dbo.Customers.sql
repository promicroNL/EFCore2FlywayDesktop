CREATE TABLE [dbo].[Customers]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (max) NULL,
[LastName] [nvarchar] (max) NULL,
[DateOfBirth] [datetime2] NOT NULL,
[Address] [nvarchar] (max) NULL
)
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([Id])
GO
