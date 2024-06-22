#!/usr/bin/env pwsh

[CmdletBinding()]
param (
    [Parameter(Mandatory =$true, Position = 1, HelpMessage = "Container registry")]
    [ValidateNotNullOrEmpty()]
    [string]$acr

    [Parameter(Mandatory =$true, Position = 0, HelpMessage = "Module file location")]
    [ValidateNotNullOrEmpty()]
    [ValidateSet("modules/resources/*.bicep", "modules/services/*.bicep", "modules/products/*.bicep")]
    [string]$file

    [Parameter(Mandatory =$true, Position = 2, HelpMessage = "Module version")]
    [ValidateNotNullOrEmpty()]
    [string]$version
)

# Remove the "modules/" prefix
$stringWithoutPrefix = $file -replace 'modules/', ''

# Remove the ".bicep" suffix
$moduleRepoName = $stringWithoutPrefix -replace '.bicep', ''

$publishtarget = 'br:' + $acr + '/'+ $moduleRepoName + ':' + $version

Write-Output $publishtarget

