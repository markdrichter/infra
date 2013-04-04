param(
		[Parameter(Mandatory=$true)]
		$ComputerName 
	)

Write-Host "Beging installing IIS features..."
Enable-PSRemoting –force
Import-Module .\OSFeatures.psm1

#$result = Test-PSRemoting -ComputerName 08Web

#Write-Host $result

#if ($result -ne $true)
#{
#	Write-Host "PowerShell remoting on $ComputerName is not enabled. It needs to be."
#	return $result
#}

#Get-OSFeature -ComputerName 08WEB >> .\windows_features.txt

Write-Host "...finished installing IIS features."

return $result
