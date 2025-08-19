# Define paths
$basePath = "$PSScriptRoot"
$migrationPath = Join-Path $basePath "migrations"
$schemaPath    = Join-Path $basePath "schema-model"

# Remove everything under /migration except AfterMigrate.sql
Get-ChildItem -Path $migrationPath -File |
    Where-Object { $_.Name -ne "AfterMigrate.sql" } |
    Remove-Item -Force

# Remove everything under /schemamodel
Get-ChildItem -Path $schemaPath -File | Remove-Item -Force