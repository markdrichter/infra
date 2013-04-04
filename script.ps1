	param(
		[Parameter(Mandatory=$true)]
		$ComputerName 
	)
	
	Import-Module ./OSFeatures.psm1
	Enable-PSRemoting -Force
	
	try {
	
		$ErrorActionPreference = "Stop"
		$result = Test-PSRemoting -ComputerName 08WEB
		Add-OSFeature -ComputerName 08WEB -FeatureName Web-Server
	}
	catch {
		Write-Host $_
		Exit 1
	}
	
	
	Exit 0