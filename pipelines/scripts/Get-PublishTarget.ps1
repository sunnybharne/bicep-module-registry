#!/usr/bin/env pwsh

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Bicep module location")]
    [ValidateNotNullOrEmpty()]
    [ValidateSet("modules/resources/*.bicep", "modules/services/*.bicep", "modules/products/*.bicep")]
    [string]$gitDiffPath
)

# Remove the "modules/" prefix
$stringWithoutPrefix = $file -replace 'modules/resources/', ''

# Remove the ".bicep" suffix
$moduleRepoName = $stringWithoutPrefix -replace '.bicep', ''

$publishtarget = 'br:tuttuacrplatformiacsc01.azurecr.io/resource/'+ $moduleRepoName + ':1.0.1'

Write-Output $publishtarget

