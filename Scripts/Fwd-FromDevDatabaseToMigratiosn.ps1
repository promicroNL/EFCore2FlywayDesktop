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
$flywayProjectPath = "C:\work\EFCoreFWD\Flyway_alt\"
$flywayProjectMigrationPath = Join-Path $flywayProjectPath "Migrations"

# Apply the dev database to schema-model

# Populate the schema model from the migrations
$diffArtifactFileName = New-Guid 
$diffArtifactFilePath = Join-Path $env:LOCALAPPDATA 'Temp' $diffArtifactFileName

# Parameters for Flyway dev
$commonParams = 
"--artifact=$diffArtifactFilePath",
"--project=$flywayProjectPath",
"--i-agree-to-the-eula"

$diffParams = "diff --from=Dev --to=SchemaModel " + $commonParams
$takeParams = "take " + $commonParams
$applyParams = "apply " + $commonParams

$diffCommand = ('flyway-dev {0}' -f $diffParams)
Write-Host $diffCommand
Invoke-Expression $diffCommand

$takeAndApplyCommand = ('flyway-dev {0} | flyway-dev {1}' -f $takeParams, $applyParams)     
Write-Host $takeAndApplyCommand
Invoke-Expression $takeAndApplyCommand

Remove-Item $diffArtifactFilePath

#now create migrations for these steps
Write-Host "--------------------> NEXT, let's make migrations" 

# Populate the schema model from the migrations
$tempFilePath = Join-Path $env:LOCALAPPDATA "Temp" "Redgate" "Flyway Desktop"
$diffArtifactFileName = New-Guid 

New-Item -ItemType Directory -Force -Path $tempFilePath

$diffArtifactFilePath = Join-Path $tempFilePath "comparison_artifacts_SchemaModel_Migrations" $diffArtifactFileName

Write-Host $nextMigrationDescription

# Parameters for Flyway dev
$commonParams = 
"--project=$flywayProjectPath",
"--i-agree-to-the-eula "

$artifactParam =
"--artifact='$diffArtifactFilePath' "

$diffParams = "diff " + $commonParams + "--from=SchemaModel --to=Migrations " + $artifactParam

$generateParams = "generate " + $commonParams + " --outputFolder=$flywayProjectMigrationPath --changes - " + $artifactParam

$takeParams = "take " + $commonParams + $artifactParam

$diffCommand = ("flyway-dev {0}" -f $diffParams)
Write-Host $diffCommand
Invoke-Expression $diffCommand

$applyCommand = ("flyway-dev {0} | flyway-dev {1}" -f $takeParams, $generateParams)  
Write-Host $applyCommand
$result = Invoke-Expression $applyCommand

Write-host $result | ConvertFrom-Json

Remove-Item $diffArtifactFilePath
