param(
		[Parameter(Mandatory=$true)]
		$ComputerName 
	)

	
	Get-Service winrm
	
	Enable-PSRemoting -Force
