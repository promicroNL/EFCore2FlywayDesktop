/*
                           _)\.-.                                                _/\__          
         .-.__,___,_.-=-. )\`  a`\_                                        ---==/    \\         
     .-.__\__,__,__.-=-. `/  \     `\     ___  _ _ _  ___           ___  ___    |.    \|\       
     {~,-~-,-~.-~,-,;;;;\ |   '--;`)/     | __|| | | || _ \        | __|| __|   |  )   \\\      
      \-,~_-~_-,~-,(_(_(;\/   ,;/         | _| | | | |||_| |       | _| | _|    \_/ |  //|\\    
       ",-.~_,-~,-~,)_)_)'.  ;;(          |_|  \_____/|___/    VS  |___||_|         /   \\\/\\  
         `~-,_-~,-~(_(_(_(_\  `;\                                                   \    \/\\/\/

Created by: THR-2023-@promicroNL
*/

DECLARE @database_name VARCHAR(100)
SELECT @database_name = DB_NAME() 

EXEC msdb.dbo.sp_delete_database_backuphistory @database_name = @database_name
GO
use [master];
GO
USE [master]
GO
ALTER DATABASE TasteWhisky_FWD SET  SINGLE_USER WITH ROLLBACK IMMEDIATE
GO
USE [master]
GO
/****** Object:  Database [TW]    Script Date: 6-1-2023 14:45:15 ******/
DROP DATABASE TasteWhisky_FWD
GO
CREATE DATABASE TasteWhisky_FWD