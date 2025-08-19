$text = @"

                         _)\.-.                                                _/\__
         .-.__,___,_.-=-. )\`  a`\_                                        ---==/    \\
     .-.__\__,__,__.-=-. `/  \     `\     ___  _ _ _  ___           ___  ___    |.    \|\
    {~,-~-,-~.-~,-,;;;;\ |   '--;`)/     | __|| | | || _ \        | __|| __|   |  )   \\
    \-,~_-~_-,~-,(_(_(;\/   ,;/         | _| | | | |||_| |       | _| | _|    \_/ |  //|\\
     ",-.~_,-~,-~,)_)_)'.  ;;(          |_|  \_____/|___/    VS  |___||_|         /   \\\/\\
        `~-,_-~,-~(_(_(_(_\  `;\                                                   \    \/\\/\/

                   Hybrid model (deploy to PROD)
"@
#Created by: THR-2025-@promicroNL

Write-Host $text

# Specify the paths to the EF Core project and this Flyway project
$flywayProjectPath = $PSScriptRoot
# Make sure we run all commands in the Flyway project folder
Set-Location $flywayProjectPath

# Migrate and baseline production DB (schema history table doesn’t exist yet)
$flywayMigrateParams = @{
    FilePath     = "flyway"
    ArgumentList = @(
        "migrate",
        "-baselineOnMigrate=true",
        "-environment=PROD"
    )
}
& $flywayMigrateParams.FilePath @($flywayMigrateParams.ArgumentList)
