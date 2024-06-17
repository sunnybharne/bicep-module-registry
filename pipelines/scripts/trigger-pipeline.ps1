[CmdletBinding()]
param(
    [Parameter(Mandatory = $True)]
    [string]$patchVersion
    [Parameter(Mandatory = $True)]
    [string]$pipelineName
    [Parameter(Mandatory = $True)]
    [string]$bicepVersionFile
    [Parameter(Mandatory = $True)]
    [string]$bicepFile
    [Parameter(Mandatory = $false)]
    [string]$prPipeline
    [Parameter(Mandatory = $false)]
    [string]$isSolution
)

$auth = "Bearer $env:SYSTEM_ACCESSTOKEN"

