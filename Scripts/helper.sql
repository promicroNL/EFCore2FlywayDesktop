-- joined migrations tables

SELECT *
  FROM [Demo-Simple-Production].[dbo].__EFMigrationsHistory ef
  join flyway_schema_history fw on fw.installed_rank = ef.FlywayInstallRank
