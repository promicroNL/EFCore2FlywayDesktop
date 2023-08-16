$text = @"

                         _)\.-.                                                _/\__           
         .-.__,___,_.-=-. )\`  a`\_                                        ---==/    \\        
     .-.__\__,__,__.-=-. `/  \     `\     ___  _ _ _  ___           ___  ___    |.    \|\      
    {~,-~-,-~.-~,-,;;;;\ |   '--;`)/     | __|| | | || _ \        | __|| __|   |  )   \\\      
    \-,~_-~_-,~-,(_(_(;\/   ,;/         | _| | | | |||_| |       | _| | _|    \_/ |  //|\\     
     ",-.~_,-~,-~,)_)_)'.  ;;(          |_|  \_____/|___/    VS  |___||_|         /   \\\/\\   
        `~-,_-~,-~(_(_(_(_\  `;\                                                   \    \/\\/\/

"@
#Created by: THR-2023-@promicroNL

Write-Host $text

# Specify the paths to the EF Core and Flyway migration files
$efCore = "C:\work\EFCore2FlywayDesktop\EFCore"
$efCoreMigrationFilesPath = "C:\work\EFCore2FlywayDesktop\EFCore\Migrations\"
$flywayProjectPath = "C:\work\EFCore2FlywayDesktop\Flyway\"
$fwMigrationFilesPath = Join-Path $flywayProjectPath "migrations"

# Get a list of the EF Core migration files
$efCoreMigrationFiles = Get-ChildItem $efCoreMigrationFilesPath

# determine the status of already in place flyway migrations
$migrationfiles = Get-ChildItem $fwMigrationFilesPath | Select-Object Name | Where-Object { $_.Name -match '(^V)' }

# extract migration name, same as EF Core migration name, from flyway migration files
$migrationfilesWithoutNumber = $migrationfiles | Select-Object Name |  ForEach-Object { $_.Name.Substring(5, $_.Name.Length - 5).replace('.sql', '') }  

$lastMigrationFile = $migrationfiles.Name | Select-Object -last 1
# what was the last migration, start here with iterating
if ($null -eq $lastMigrationFile) {
    Write-Host "Starting migration, no flyway migration found"
    [int]$version = 0
    $migrationfilesWithoutNumber = @()
}
else {
    Write-Host "Starting migration, last flyway migration was $lastMigrationFile"
    [int]$version = $lastMigrationFile.Substring(1, 3)    
}

## Loop through each EF Core migration file 
$PreviousEfCoreMigrationFileBaseName = "0"

# Set the working directory to the project directory for the dotnet call
Set-Location $efCore

foreach ($efCoreMigrationFile in $efCoreMigrationFiles) {
    if ($efCoreMigrationFile.BaseName -notlike '*ModelSnapshot' -and $efCoreMigrationFile.BaseName -notlike '*designer') {
        $CurrentEfCoreMigrationFileBaseName = $efCoreMigrationFile.BaseName

        # Create a Flyway migration filename
        Write-Host "Converting $CurrentEfCoreMigrationFileBaseName"
        $migrationName = $CurrentEfCoreMigrationFileBaseName.Replace("_", "__")
        
        # skip all files that are already converted to Flyway
        if ($migrationfilesWithoutNumber.Contains($migrationName)) {
            Write-Host "SKIPPED conversion" -ForegroundColor "Yellow"
            Write-Host "$CurrentEfCoreMigrationFileBaseName already part of the Flyway migration folder"
        }
        # converts the EF Core migration file to the Flyway format
        else {
            $migrationType = "V" # first the V(ersion) migration

            $version += 1
            $versionPadded= ([string]$version).PadLeft(3, '0')
            Write-Host "Flyway version = $versionPadded"

            while ($undoMigrationStarted -eq $false) { # this will loop twice, for the MigrationType V and U
                Write-Host "Extracting the $migrationType SQL-script from EF Core for $PreviousEfCoreMigrationFileBaseName vs $CurrentEfCoreMigrationFileBaseName" 
                if ($migrationType -eq "V") {
                       $fileContent = dotnet ef migrations script $PreviousEfCoreMigrationFileBaseName $CurrentEfCoreMigrationFileBaseName
                }
                else {
                    $fileContent = dotnet ef migrations script $CurrentEfCoreMigrationFileBaseName $PreviousEfCoreMigrationFileBaseName
                    $undoMigrationStarted = $true
                }

                Write-Host "Trying to flywayify the $migrationType for: $CurrentEfCoreMigrationFileBaseName"                       
          
                $flywayFileContent = $fileContent | Foreach-Object { $_ `
                        -replace [regex]::escape('[ProductVersion] nvarchar(32) NOT NULL,'), '[ProductVersion] nvarchar(32) NOT NULL, [FlywayInstallRank] INT NULL' `
                        -replace [regex]::escape('Build started...'), '' `
                        -replace [regex]::escape('Build succeeded.'), '' 
                }

                $path = ("{0}\{1}{2}_{3}.sql" -f $fwMigrationFilesPath, $migrationType, $versionPadded, $migrationName)

                Set-Content -Path $path -Value $flywayFileContent
                Write-Host "COMPLETED $migrationType conversion to $path" -ForegroundColor "Green"

                $migrationType = "U" # next create the (U)ndo migration
            }

        }

        Write-Host "..." -ForegroundColor "DarkBlue"
        # finishing up this iteration
        $PreviousEfCoreMigrationFileBaseName = $CurrentEfCoreMigrationFileBaseName
        $undoMigrationStarted = $false
    }
}

# Apply the migrations to shadow database
# prepare other information for Flyway commands.
$flywayDevUser = get-content "$flywayProjectPath/flyway-dev.user.json" | ConvertFrom-Json
$url = $flywayDevUser.deployment.shadowDatabase.connectionProvider.url

# Parameters for Flyway command.
$params = @("migrate", "-configFiles=flyway.conf", "-workingDirectory=$flywayProjectPath",  "-url=$url")

# Migrate command
flyway @params

# Populate the schema model from the migrations
# Define temporary diff file and path
$tempFilePath = Join-Path $env:LOCALAPPDATA "Temp\Redgate\Flyway Desktop\comparison_artifacts_Migrations_SchemaModel" 
$diffArtifactFileName = New-Guid 
$null = New-Item -ItemType Directory -Force -Path $tempFilePath
$diffArtifactFilePath = Join-Path $tempFilePath  $diffArtifactFileName


# Parameters for Flyway dev
$commonParams =
@("--artifact=$diffArtifactFilePath",
"--project=$flywayProjectPath",
"--i-agree-to-the-eula")

$diffParams = @("diff", "--from=Migrations", "--to=Schemamodel") + $commonParams
$takeParams = @("take") + $commonParams
$applyParams = @("apply") + $commonParams

flyway-dev @diffParams
flyway-dev @takeParams | flyway-dev @applyParams

Remove-Item $diffArtifactFilePath