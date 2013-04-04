#############################################################################
#Script: OSFeatures.psm1
#Author: Ravikanth (http://www.ravichaganti.com/blog)
#version: 1.0
#############################################################################            

#Check if remote computer has PS remoting enabled or not
#This function is by Lee Homles
#http://www.leeholmes.com/blog/2009/11/20/testing-for-powershell-remoting-test-psremoting/
function Test-PsRemoting
{
    param(
        [Parameter(Mandatory = $true)]
        $computername
    )            

    try
    {
        $errorActionPreference = "Stop"
        $result = Invoke-Command -ComputerName $computername { 1 }
    }
    catch
    {
        Write-Verbose $_
        return $false
    }             

    ## I've never seen this happen, but if you want to be 
    ## thorough.... 
    if($result -ne 1)
    {
        Write-Verbose "Remoting to $computerName returned an unexpected result."
        return $false
    }
    $true
}            

#Add OS Feature
#Tested with Windows 2008 R2 and ServerCore OS
Function Add-OSFeature
{
 Param(
  [Parameter(Mandatory=$true)]
  $computername,
  [Parameter(Mandatory=$true)]
  $featurename,
  [switch]$IncludeAllSubFeature
 )
 if ($IncludeAllSubFeature) {
  Write-Verbose "IncludeAllSubFeature will be added to Add-WindowsFeature"
  $cmd = "Add-WindowsFeature -Name $featureName -LogPath `"`$(`$env:temp)\$($featureName).log`" -IncludeAllSubFeature"
 } else {
  $cmd = "Add-WindowsFeature -Name $featureName -LogPath `"`$(`$env:temp)\$($featureName).log`""
 }
 $cmdBlock = "Import-Module ServerManager `
`$featureInstall = $cmd
if (`$featureInstall.Success) {
	Write-Host `"$featureName installed successfully`"
	if (`$featureInstall.RestartNeeded -eq `"Yes`") {
		Write-Host `"This feature install requires restart. Pls restart $computerName`"
	}
} else {
	Write-Error `"`$featureName could not be installed`"
	Get-Content `"`$(`$env:temp)\$($featureName).log`" | Out-Host
}"
Write-Verbose $cmdBlock
$scriptBlock = $ExecutionContext.InvokeCommand.NewScriptBlock($cmdBlock)
 Write-Verbose "Verifying if $computername has remoting enabled"
 if (Test-PSRemoting -ComputerName $computername) {
  try {
   Write-Verbose "Installing OS Feature: $featureName"
   Invoke-Command -ComputerName $computername -ScriptBlock $scriptBlock
  }
  catch {
   Write-Verbose $_
   return $false
  }
 } else {
  Write-Error "PowerShell remoting must be enabled to run this command"
  Return $false
 }
}            

#Remove an OS feature
#Tested with Windows 2008 R2 and ServerCore OS
Function Remove-OSFeature
{
 Param(
  [Parameter(Mandatory=$true)]
  $computername,
  [Parameter(Mandatory=$true)]
  $featurename
 )
 $cmdBlock = "Import-Module ServerManager `
`$featureInstall = Remove-WindowsFeature -Name $featureName -LogPath `"`$(`$env:temp)\$($featureName).log`"
if (`$featureInstall.Success) {
	Write-Host `"$featureName removed successfully`"
	if (`$featureInstall.RestartNeeded -eq `"Yes`") {
		Write-Host `"This feature removal requires restart. Pls restart $computerName`"
	}
} else {
	Write-Error `"`$featureName could not be installed`"
	Get-Content `"`$(`$env:temp)\$($featureName).log`" | Out-Host
}"
Write-Verbose $cmdBlock
$scriptBlock = $ExecutionContext.InvokeCommand.NewScriptBlock($cmdBlock)
 Write-Verbose "Verifying if $computername has remoting enabled"
 if (Test-PSRemoting -ComputerName $computername) {
  try {
   Write-Verbose "Removing OS Feature: $featureName"
   Invoke-Command -ComputerName $computername -ScriptBlock $scriptBlock
  }
  catch {
   Write-Verbose $_
   return $false
  }
 } else {
  Write-Error "PowerShell remoting must be enabled to run this command"
  Return $false
 }
}            

#Get OS features
#Tested with Windows 2008 R2 and ServerCore OS
Function Get-OSFeature
{
 Param(
  [Parameter(Mandatory=$true)]
  $computername,
  $featurename
 )
 $cmdBlock = "Import-Module ServerManager `
if (`"$featureName`".Trim() -ne `"`") {
	`$osFeature = Get-WindowsFeature $featureName
	if (`$osFeature){
		return `$osFeature
	} else {
		Write-Host `"Windows Feature `"$featureName`" does not exist`" -ForegroundColor RED
	}
} else {
	Get-WindowsFeature
}"
 Write-Verbose $cmdBlock
 $scriptBlock = $ExecutionContext.InvokeCommand.NewScriptBlock($cmdBlock)
 Write-Verbose "Verifying if $computername has remoting enabled"
 if (Test-PSRemoting -ComputerName $computername) {
  try {
   Write-Verbose "Getting OS Feature"
   Invoke-Command -ComputerName $computername -ScriptBlock $scriptBlock -HideComputerName
  }
  catch {
   Write-Verbose $_
   return $false
  }
 } else {
  Write-Error "PowerShell remoting must be enabled to run this command"
  Return $false
 }
}