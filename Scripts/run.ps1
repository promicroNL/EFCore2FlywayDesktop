# clean ef database update
$efCore = "$PSScriptRoot\..\EFCore"
Set-Location $efCore
dotnet ef database update --connection "Server=.\bartender;Database=Demo-Inverted-EF;Trusted_Connection=True;Trust Server Certificate=True;"

