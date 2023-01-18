CREATE TABLE [dbo].[Customers]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[FirstName] [nvarchar] (max) NOT NULL,
[LastName] [nvarchar] (max) NOT NULL,
[DateOfBirth] [datetime2] NOT NULL,
[Address] [nvarchar] (max) NOT NULL CONSTRAINT [DF__Customers__Addre__5CD6CB2B] DEFAULT (N'')
)
GO
ALTER TABLE [dbo].[Customers] ADD CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([Id])
GO
