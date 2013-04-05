	param(
		[Parameter(Mandatory=$true)]
		$ComputerName 
	)
	
	Import-Module ./OSFeatures.psm1
	Enable-PSRemoting -Force
	
	try {
	
		$ErrorActionPreference = "Stop"
		Test-PSRemoting -ComputerName $ComputerName
		Write-Host "Test-PSRemoting returned: " + $?
		Write-Host "LastExitCode: " + $LastExitCode
		Add-OSFeature -ComputerName $ComputerName -FeatureName Web-Server
	}
	catch {
		Write-Host "Caught Error: "
		Write-Host $_
	}
	
		Write-Host "LastExitCode: " + $LastExitCode
	