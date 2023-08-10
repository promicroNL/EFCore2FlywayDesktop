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
$flywayProjectPath = "C:\work\EFCore2FlywayDesktop\Flyway_alt\"

$flywayDevUser = get-content "$flywayProjectPath/flyway-dev.user.json" | ConvertFrom-Json
$url = $flywayDevUser.developmentDatabase.connectionProvider.url

Write-Host 'Attempt to convert the Flyway url to an ADO connection string'

# use this information for our own local data
if (!([string]::IsNullOrEmpty($url))) {
	$FlywayURLRegex =
	'jdbc:(?<RDBMS>[\w]{1,20})://(?<server>[\w\\\-\.]{1,40})(;instanceName=|/)(?<instanceName>[\w\\\-\.]{1,40})(?<port>:[\d]{1,4}|)(;.*databaseName=|/)(?<databaseName>[\w]{1,20})';
	
	if ($url -imatch $FlywayURLRegex) { #This copes with having no port.
		if ($matches["RDBMS"] -eq 'sqlserver') {
			$converted = $url -replace "jdbc:sqlserver://", "server=" -split ";" | ConvertFrom-StringData
			$ConnectionString = ('Data Source={0}\{1}; Initial Catalog={2};Trusted_Connection={3};TrustServerCertificate=True' -f $converted.Server, $converted.InstanceName, $converted.DatabaseName, $converted.integratedSecurity) 
		}
	}
}

# Set the working directory to the project directory for the dotnet call
Set-Location $efCore

$efCall = ('dotnet ef database  update --connection "{0}"' -f $ConnectionString)
write-host ('Run: {0}' -f $efCall)
Invoke-Expression $efCall

# run the script RunFwd-FromDevDatabaseToMigrations
# provided in the repo: https://github.com/promicroNL/flyway-dev-automation