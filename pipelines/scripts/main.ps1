#!/usr/bin/env pwsh
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Name of the Azure Container Registry")]
    [ValidateNotNullOrEmpty()]
    [string]$acrName,

    [Parameter(Mandatory = $true, Position = 1, HelpMessage = "Modules path with /*.bicep extention")]
    [ValidateNotNullOrEmpty()]
    [ValidateSet("modules/resources/*/*.bicep", "modules/services/*/*.bicep", "modules/products/*/*.bicep")]
    [string]$gitDiffPath

    #[Parameter(Mandatory = $true, Position = 2, HelpMessage = "Version")]
    #[ValidateNotNullOrEmpty()]
    #[string]$version
)
#
## Load the token from the saved file
#$authToken = Get-Content -Path "ureAuth.json" -Raw | ConvertFrom-Json
#
## Set the token as the environment variable
#$env:AZURE_AUTH_TOKEN = $authToken.accessToken
#
## Use the token to authenticate Azure PowerShell commands
#Connect-AzAccount -AccessToken $env:AZURE_AUTH_TOKEN -AccountId 'b142e119-024f-4143-83b8-3311ccf34d3c' -TenantId '7d8e621a-3561-4cc4-9ee6-f03bc8610835'
#
## Verify the login
#Get-AzContext


# Get the number of commits in the repository
$commitCount = git rev-list --count HEAD

# Check if there are at least two commits
if ($commitCount -lt 2) {
    Write-Output "Not enough commits to perform diff"
    exit 0
}

# Get the hash of the latest commit in the current branch
$currentCommitHash = git rev-parse HEAD

# Get the hash of the parent commit
$parentCommitHash = git rev-parse HEAD^

# Check if there are changes in .bicep files in the 'modules/xyz' folder between the current and parent commits
$diffOutput = git diff --name-only $parentCommitHash $currentCommitHash -- $gitDiffPath

# Print all changed .bicep files
if ($diffOutput) {
    Write-Output "Moified module files"
    Write-Output "---------------------"
    $diffOutput | ForEach-Object { Write-Output $_ }

    # Split the diff output into an array of file paths
    $changedFiles = $diffOutput -split "`n"

    # acr login -n $acrName

    # Loop through each changed .bicep file and publish to ACR
    foreach ($file in $changedFiles) {

      if ($file) {

        # Remove the "modules/" prefix
        $stringWithoutPrefix = $file -replace '\/[^\/]+\.bicep', ''

        # Define the path to the JSON file
        $jsonFilePath = "$stringWithoutPrefix/metadata.json"

        # Check if the file exists
        if (-Not (Test-Path -Path $jsonFilePath)) {
            Write-Error "The file $jsonFilePath does not exist."
            exit 1
        }

        # Read the JSON file content
        $jsonContent = Get-Content -Path $jsonFilePath -Raw

        # Convert the JSON content to a PowerShell object
        $jsonObject = $jsonContent | ConvertFrom-Json

        # Check if the version property exists
        if (-Not $jsonObject.PSObject.Properties["version"]) {
            Write-Error "The version property does not exist in the JSON file."
            exit 1
        }

        # Extract the version value
        $version = $jsonObject.version

        # Construct the target
        Write-Output "File"
        Write-Output "----"
        Write-Output $jsonFilePath
        
        $moduleRepoName = $stringWithoutPrefix -replace 'modules/', ''

        # Publish target
        $publishtarget = 'br:' + $acrName + '.urecr.io/'+ $moduleRepoName + ':' + $version

        # Publish the Bicep file to ACR
        Write-Output "Publishing $file to $publishtarget"
        az bicep publish -f $file --target $publishtarget

        ## Check if the publish was successful
        if ($LASTEXITCODE -ne 0) {
        Write-Output "Failed to publish $file with target $publishtarget"
        exit 1
        }
      }
    }

    Write-Output "End of script"
} else {
    Write-Output "No .bicep files changed"
    Write-Output "-----------------------"
    Write-Output "End of script"
}

