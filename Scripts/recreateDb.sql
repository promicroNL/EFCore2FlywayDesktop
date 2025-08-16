-- Ensure demo databases exist
CREATE DATABASE [NYC-Hybrid-EF];
CREATE DATABASE [NYC-Hybrid-Flyway];
CREATE DATABASE [NYC-Hybrid-Shadow];
CREATE DATABASE [NYC-Hybrid-Production];

CREATE DATABASE [NYC-Inverted-EF];
CREATE DATABASE [NYC-Inverted-Flyway];
CREATE DATABASE [NYC-Inverted-Shadow];
CREATE DATABASE [NYC-Inverted-Production];

CREATE DATABASE [NYC-Simple-EF];
CREATE DATABASE [NYC-Simple-Flyway];
CREATE DATABASE [NYC-Simple-Shadow];
CREATE DATABASE [NYC-Simple-Production];

/*
                           _)\.-.                                                _/\__
         .-.__,___,_.-=-. )\`  a`\_                                        ---==/    \\
     .-.__\__,__,__.-=-. `/  \     `\     ___  _ _ _  ___           ___  ___    |.    \|\
     {~,-~-,-~.-~,-,;;;;\ |   '--;`)/     | __|| | | || _ \        | __|| __|   |  )   \\
      \-,~_-~_-,~-,(_(_(;\/   ,;/         | _| | | | |||_| |       | _| | _|    \_/ |  //|\\
       ",-.~_,-~,-~,)_)_)'.  ;;(          |_|  \_____/|___/    VS  |___||_|         /   \\\/\\
         `~-,_-~,-~(_(_(_(_\  `;\                                                   \    \/\\/\\

                   All models

Created by: THR-2025-@promicroNL
*/

DECLARE @database_name VARCHAR(100);
SELECT @database_name = DB_NAME();

-- Remove old backups for the current database
EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = @database_name;
GO
USE [master];
GO
ALTER DATABASE TasteWhisky_FWD SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
-- Recreate the TasteWhisky_FWD database
/****** Object:  Database [TW]    Script Date: 6-1-2025 14:45:15 ******/
DROP DATABASE IF EXISTS TasteWhisky_FWD;
GO
CREATE DATABASE TasteWhisky_FWD;

