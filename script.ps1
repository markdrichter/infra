	param(
		[Parameter(Mandatory=$true)]
		$ComputerName 
	)
	
	Import-Module ./OSFeatures.psm1
	Enable-PSRemoting -Force
	
	try {
	
		$ErrorActionPreference = "Stop"
		$result = Test-PSRemoting -ComputerName $ComputerName
		if ($result -eq $False) { 
			Write-Host $result
			%ERRORLEVEL% = 1
			Exit
		}
		Add-OSFeature -ComputerName $ComputerName -FeatureName Web-Server
	}
	catch {
		Write-Host $_
		Exit -1
	}
	