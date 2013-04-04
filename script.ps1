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
		if ($result -eq "false") { Exit 1 }
		Add-OSFeature -ComputerName $ComputerName -FeatureName Web-Server
		Write-Host $error
	}
	catch {
		Write-Host $_
		Exit 1
	}
	
	Exit 0