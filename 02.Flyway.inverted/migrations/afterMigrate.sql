/*
                           _)\.-.                                                _/\__          
         .-.__,___,_.-=-. )\`  a`\_                                        ---==/    \\         
     .-.__\__,__,__.-=-. `/  \     `\     ___  _ _ _  ___           ___  ___    |.    \|\       
     {~,-~-,-~.-~,-,;;;;\ |   '--;`)/     | __|| | | || _ \        | __|| __|   |  )   \\\      
      \-,~_-~_-,~-,(_(_(;\/   ,;/         | _| | | | |||_| |       | _| | _|    \_/ |  //|\\    
       ",-.~_,-~,-~,)_)_)'.  ;;(          |_|  \_____/|___/    VS  |___||_|         /   \\\/\\  
        `~-,_-~,-~(_(_(_(_\  `;\                                                   \    \/\\/\/

                   Inverted model

Description: update the install rank of flyway migration in the __EFMigrationsHistory table

Created by: THR-2025-@promicroNL
 */

UPDATE
      emh
SET
      emh.FlywayInstallRank = fsh.installed_rank
FROM   ${flyway:defaultSchema}.${flyway:table} AS fsh
      LEFT JOIN dbo.__EFMigrationsHistory AS emh ON CONCAT(
                                                             SUBSTRING(
                                                                         fsh.version,
                                                                         CHARINDEX(
                                                                                     '.',
                                                                                     fsh.version
                                                                                  )
                                                                         + 1,
                                                                         LEN(fsh.version)
                                                                      ),
                                                             '_',
                                                             fsh.description
                                                          ) = emh.MigrationId
WHERE fsh.type = 'SQL' AND  fsh.success = 1 AND  fsh.installed_on > '${flyway:timestamp}' 