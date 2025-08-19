$text = @"

                         _)\.-.                                                _/\__
         .-.__,___,_.-=-. )\`  a`\_                                        ---==/    \\
     .-.__\__,__,__.-=-. `/  \     `\     ___  _ _ _  ___           ___  ___    |.    \|\
    {~,-~-,-~.-~,-,;;;;\ |   '--;`)/     | __|| | | || _ \        | __|| __|   |  )   \\
    \-,~_-~_-,~-,(_(_(;\/   ,;/         | _| | | | |||_| |       | _| | _|    \_/ |  //|\\
     ",-.~_,-~,-~,)_)_)'.  ;;(          |_|  \_____/|___/    VS  |___||_|         /   \\\/\\
        `~-,_-~,-~(_(_(_(_\  `;\                                                   \    \/\\/\/

                   Hybrid model (convert)
"@
#Created by: THR-2025-@promicroNL

Write-Host $text

# Specify the paths to the EF Core project and this Flyway project
$efCore = "$PSScriptRoot\..\EFCore"
$flywayProjectPath = $PSScriptRoot

# Install module (once)
# Install-Module PSToml -Scope CurrentUser

# Import module for parsing TOML
Import-Module PSToml

# Read TOML file into a PowerShell object
$tomlPath = Join-Path $flywayProjectPath "flyway.user.toml"
$tomlContent = Get-Content $tomlPath -Raw
$data = ConvertFrom-Toml -InputObject $tomlContent

# Access values
$url = $data.environments.development.url
$data.environments.PROD.displayName | Out-Null

Write-Host 'Attempt to convert the Flyway url to an ADO connection string'

# use this information for our own local data
if (!([string]::IsNullOrEmpty($url))) {
    $FlywayURLRegex =
    'jdbc:(?<RDBMS>[\w]{1,20})://(?<server>[\w\\\-\.]{1,40})(;instanceName=|/)(?<instanceName>[\w\\\-\.]{1,40})(?<port>:[\d]{1,4}|)(;.*databaseName=|/)(?<databaseName>[\w]{1,20})';

    if ($url -imatch $FlywayURLRegex) {
        # This copes with having no port.
        if ($matches["RDBMS"] -eq 'sqlserver') {
            $converted = $url -replace "jdbc:sqlserver://", "server=" -split ";" | ConvertFrom-StringData
            $ConnectionString = ('Data Source={0}\{1}; Initial Catalog={2};Trusted_Connection={3};TrustServerCertificate=True' -f $converted.Server, $converted.InstanceName, $converted.DatabaseName, $converted.integratedSecurity)
        }
    }
}

# Set the working directory to the project directory for the dotnet call
Set-Location $efCore

$efParams = @{
    FilePath     = "dotnet"
    ArgumentList = @(
        "ef", "database", "update",
        "--connection", $ConnectionString
    )
    ErrorAction  = "Continue"  # we still want the output, even on error
}

# Run EF Core command natively and capture ALL output
$output = & $efParams.FilePath @($efParams.ArgumentList) 2>&1

# Extract migration names
$migrations = $output |
Where-Object { $_ -match 'Applying migration|Reverting migration|Done.*migration' } |
ForEach-Object {
    if ($_ -match "'([^']+)'") { $matches[1] } else { $_ }
} |
Sort-Object -Unique -Descending -CaseSensitive

# Create summary variable
$EFCoreMigrationSummary = $migrations -join ', '

Write-Host "Migrations applied (partial or complete): $EFCoreMigrationSummary"

# Make sure we run all commands in the Flyway project folder
Set-Location $flywayProjectPath

# Get the difference between the deployed Dev DB and the empty schema model
$flywayDiffParams = @{
    FilePath     = "flyway"
    ArgumentList = @(
        "diff",
        "-diff.source=development",
        "-diff.target=schemaModel"
    )
}
& $flywayDiffParams.FilePath @($flywayDiffParams.ArgumentList)

# Apply all changes to the schema model on disk
$flywayModelParams = @{
    FilePath     = "flyway"
    ArgumentList = @("model")
}
& $flywayModelParams.FilePath @($flywayModelParams.ArgumentList)

# Generate migrations using the EF Core migration summary in the description
$flywayGenerateParams = @{
    FilePath     = "flyway"
    ArgumentList = @(
        "diff", "generate", 
        "-diff.source=schemaModel",
        "-diff.target=migrations",
        "-diff.buildEnvironment=shadow",
        "-generate.types=versioned,undo",
        ("-generate.description={0}" -f $EFCoreMigrationSummary)
    )
}
& $flywayGenerateParams.FilePath @($flywayGenerateParams.ArgumentList)

