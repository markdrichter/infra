	param(
		[Parameter(Mandatory=$true)]
		$ComputerName 
	)
	
	Import-Module ./OSFeatures.psm1
	Enable-PSRemoting -Force
	
	try {
	
		$ErrorActionPreference = "Stop"
		$result = Test-PSRemoting -ComputerName $ComputerName
		Write-Host $result
		if ($result -eq $False) { 
			Exit 1 
			return
		}
		Add-OSFeature -ComputerName $ComputerName -FeatureName Web-Server
	}
	catch {
		Write-Host $_
		Exit 1
		return
	}
	
	Exit 0