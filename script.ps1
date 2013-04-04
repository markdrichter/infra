param(
		[Parameter(Mandatory=$true)]
		$ComputerName 
	)

	
	Get-Service winrm
	
	Enable-PSRemoting -Force
	
	Import-Module ./OSFeatures.psm1

	$result = Test-PSRemoting -ComputerName 08WEB
	
	return $result