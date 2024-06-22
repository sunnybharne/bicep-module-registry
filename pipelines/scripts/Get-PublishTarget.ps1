#!/usr/bin/env pwsh

[CmdletBinding()]
param (
    [Parameter(Mandatory =$true, Position = 0, HelpMessage = "Container registry")]
    [ValidateNotNullOrEmpty()]
    [string]$acr,
    [Parameter(Mandatory =$true, Position = 1, HelpMessage = "Module file location")]
    [ValidateNotNullOrEmpty()]
    [string]$file,
    [Parameter(Mandatory =$true, Position = 2, HelpMessage = "Module version")]
    [ValidateNotNullOrEmpty()]
    [string]$version
)

# Remove the "modules/" prefix
$stringWithoutPrefix = $file -replace 'modules/', ''

# Remove the ".bicep" suffix
$moduleRepoName = $stringWithoutPrefix -replace '.bicep', ''

#Write-Output 'Cueent modules repo name is: --->'
Write-Output "final modules"
Write-Output $moduleRepoName

#$publishtarget = 'br:' + $acr + '/'+ $moduleRepoName + ':' + $version
#
#Write-Output 'Cueent targer is: --->'
#Write-Output $publishtarget
#
#return $publishtarget

