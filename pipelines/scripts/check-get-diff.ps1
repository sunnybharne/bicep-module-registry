#!/usr/bin/env pwsh

# Parameters
#param (
#    [string]$acrName = "yourACRName",
#    [string]$resourceGroupName = "yourResourceGroupName",
#    [string]$subscriptionId = "yourSubscriptionId",
#    [string]$acrRepository = "yourRepositoryName"
#)

Write-Output "Azure devops Script started"

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

# Check if there are changes in .bicep files in the 'modules/resources' folder between the current and parent commits
$diffOutput = git diff --name-only $parentCommitHash $currentCommitHash -- modules/resources/*.bicep

# Print all changed .bicep files
if ($diffOutput) {
    Write-Output "Changed modules"
    Write-Output "---------------------"
    $diffOutput | ForEach-Object { Write-Output $_ }
} else {
    Write-Output "No .bicep files changed"
    Write-Output "-----------------------"
}



## Check if there are changes in files under the 'pipelines/' folder
#$diffOutput = git diff HEAD~1 --name-only -- pipelines/
#
## Check the output of git diff
#if ($diffOutput) {
#    Write-Output "Changed"
#} else {
#    Write-Output "Not changed"
#}

# Check if there are changes in files under the 'pipelines/' folder between current and parent commits
#$diffOutput = git diff HEAD^ --name-only -- modules/resources/*.bicep

#$changedFiles = $diffOutput -split "`n"


#Write-Output "Below is the diffoutupt"
#Write-Output $changedFile
#
#Write-Output "Below is the changedfilesarray"
#Write-Output $changedFiles
#
#
#
## Check if there are any changes to the modules
#if ($diffOutput) {
#    Write-Output "Found changed to the x folder"
#    foreach ($file in $changedFiles) {
#      az bicep publish --file $file --target akdsjdskdj.azurecr.io
#    }
#} else {
#    Write-Output "No changes were found on the x folders"
#}



#if ($diffOutput) {
#    Write-Output "Changes found in folder '$folder'"
#    $isDiff = $true
#} else {
#    Write-Output "No changes found in folder '$folder'"
#    $isDiff = $false
#}

#return $isDiff

#echo Started Script
#if git diff --name-only HEAD HEAD~ | grep -q '^modules/resource/.*\.bicep$'; then
#  echo "Changes detected in ./modules/resource folder."
#  echo "Publishing modules to Azure DevOps Artifacts."
#else
#  echo "No changes in ./modules/resource folder."
#fi
#echo "Printing Git Diff"
