#!/usr/bin/env pwsh

# Change the directory to the repository root
Set-Location -Path $Env:BUILD_REPOSITORY_LOCALPATH

# Define the path to the script to be called
$scriptPath = "./Get-ChangedFiles.ps1"

# Define the parameter for the called script
$gitDiffPath = "modules/resources/*.bicep"

# Call the script and capture the returned value using the call operator
$changedFiles = & $scriptPath -gitDiffPath $gitDiffPath

Write-Output $changedFiles

## Get the number of commits in the repository
#$commitCount = git rev-list --count HEAD
#
## Check if there are at least two commits
#if ($commitCount -lt 2) {
#    Write-Output "Not enough commits to perform diff"
#    exit 0
#}
#
## Get the hash of the latest commit in the current branch
#$currentCommitHash = git rev-parse HEAD
#
## Get the hash of the parent commit
#$parentCommitHash = git rev-parse HEAD^
#
## Check if there are changes in .bicep files in the 'modules/resources' folder between the current and parent commits
#$diffOutput = git diff --name-only $parentCommitHash $currentCommitHash -- modules/resources/*.bicep
#
## Print all changed .bicep files
#if ($diffOutput) {
#    Write-Output "Changed modules"
#    Write-Output "---------------------"
#    $diffOutput | ForEach-Object { Write-Output $_ }
#} else {
#    Write-Output "No .bicep files changed"
#    Write-Output "-----------------------"
#}
#
## Split the diff output into an array of file paths
#$changedFiles = $diffOutput -split "`n"



#az acr login -n tuttuacrplatformiacsc01
#
## Loop through each changed .bicep file and publish to ACR
#foreach ($file in $changedFiles) {
#
#  # Remove the "modules/" prefix
#  $stringWithoutPrefix = $file -replace 'modules/resources/', ''
#
#  # Remove the ".bicep" suffix
#  $moduleRepoName = $stringWithoutPrefix -replace '.bicep', ''
#
#  $publishtarget = 'br:tuttuacrplatformiacsc01.azurecr.io/resource/'+ $moduleRepoName + ':1.0.1'
#
#  Write-Output $publishtarget
#
#  az bicep publish -f $file --target $publishtarget
 
  #if ($file) {
    # Construct the ACR image name and tag
    #$imageName = [System.IO.Path]::GetFileNameWithoutExtension($file)
    #$acrImageTag = "$acrName.azurecr.io/$acrRepository/$imageName:latest"

    # Publish the Bicep file to ACR
    #Write-Output "Publishing $file to $acrImageTag"
    #az bicep publish --file $file --target $acrImageTag

    # Check if the publish was successful
    #if ($LASTEXITCODE -ne 0) {
    #Write-Output "Failed to publish $file"
    #exit 1
    #}
#}
