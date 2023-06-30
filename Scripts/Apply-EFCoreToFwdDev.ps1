$flywayDevUser = get-content "$flywayProjectPath/flyway-dev.user.json" | ConvertFrom-Json
$url = $flywayDevUser.developmentDatabase.connectionProvider.url

# use this information for our own local data
if (!([string]::IsNullOrEmpty($url)))
{
	$FlywayURLRegex =
	'jdbc:(?<RDBMS>[\w]{1,20})://(?<server>[\w\\\-\.]{1,40})(;instanceName=|/)(?<instanceName>[\w\\\-\.]{1,40})(?<port>:[\d]{1,4}|)(;.*databaseName=|/)(?<databaseName>[\w]{1,20})';
	
	if ($url -imatch $FlywayURLRegex) #This copes with having no port.
	{
        if ($matches["RDBMS"] -eq 'sqlserver'){
		$ConnectionString = ('Data Source={0}\{1}; Initial Catalog={2};Trusted_Connection={3};TrustServerCertificate=True' -f $converted.Server, $converted.InstanceName, $converted.DatabaseName, $converted.integratedSecurity) 
        }
	}
}

$ConnectionString 