#!/usr/bin/env pwsh

#Variables
# Define the path to the script to be called
$repoName = 'bicep-module-registry'
$psSriptsPath = $Env:BUILD_REPOSITORY_LOCALPATH + '/' + $repoName + '/pipelines/scripts'
$changedFileScript = './pipelines/scripts/Get-ChangedFiles.ps1'
$publishTargetScript = './pipelines/scripts/Get-PublishTarget.ps1'
$gitDiffPath = 'modules/resources/*.bicep'
$acrName =  "tuttuacrplatformiacsc01.azurecr.io"
$version = "1.0.1.1"

# Change the directory to the repository root
Set-Location -Path $Env:BUILD_REPOSITORY_LOCALPATH

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
} else {
    Write-Output "No .bicep files changed"
    Write-Output "-----------------------"
}

# Split the diff output into an array of file paths
$changedFiles = $diffOutput -split "`n"

az acr login -n $acrName

# Loop through each changed .bicep file and publish to ACR
foreach ($file in $changedFiles) {

  if ($file) {
    # Construct the target
    # Remove the "modules/" prefix
    $stringWithoutPrefix = $file -replace 'modules/', ''
    # Remove the ".bicep" suffix
    $moduleRepoName = $stringWithoutPrefix -replace '.bicep', ''
    # Publish target
    $publishtarget = 'br:' + $acrName + '/'+ $moduleRepoName + ':' + $version

    # Publish the Bicep file to ACR
    Write-Output "Publishing $file to $publishtarget"
    az bicep publish -f $file --target $publishtarget

    ## Check if the publish was successful
    #if ($LASTEXITCODE -ne 0) {
    #Write-Output "Failed to publish $file with target $publishtarget"
    #exit 1
    #}
  }
}
