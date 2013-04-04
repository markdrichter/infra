param(
		[Parameter(Mandatory=$true)]
		$ComputerName 
	)

	
	Get-Service winrm
	
	Enable-PSRemoting -Force

	$result = Test-PSRemoting -ComputerName 08WEB
	
	return $result