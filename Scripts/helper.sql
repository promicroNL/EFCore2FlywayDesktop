-- joined migrations tables

SELECT *
  FROM [NYC-Simple-Production].[dbo].__EFMigrationsHistory ef
  join flyway_schema_history fw on fw.installed_rank = ef.FlywayInstallRank
