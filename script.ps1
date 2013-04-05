	param(
		[Parameter(Mandatory=$true)]
		$ComputerName 
	)
	
	Import-Module ./OSFeatures.psm1
	Enable-PSRemoting -Force
	
	try {
	
		$ErrorActionPreference = "Stop"
		Test-PSRemoting -ComputerName $ComputerName
		Write-Host $?
		Exit 1
		Add-OSFeature -ComputerName $ComputerName -FeatureName Web-Server
	}
	catch {
		Write-Host $_
		Exit 1
	}
	