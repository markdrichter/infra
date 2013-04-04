param(
		[Parameter(Mandatory=$true)]
		$ComputerName 
	)

Write-Host "Beging installing IIS features..."

Enable-PSRemoting –force
