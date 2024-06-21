#!/usr/bin/env pwsh

#param(
#[string]$FolderPath
#)

Write-Output "Azure devops Script started"

## Check if there are changes in files under the 'pipelines/' folder
#$diffOutput = git diff HEAD~1 --name-only -- pipelines/
#
## Check the output of git diff
#if ($diffOutput) {
#    Write-Output "Changed"
#} else {
#    Write-Output "Not changed"
#}


# Get the hash of the latest commit in the current branch
$currentCommitHash = git rev-parse HEAD

# Get the hash of the parent commit
$parentCommitHash = git rev-parse HEAD~1

# Check if there are changes in files under the 'pipelines/' folder between current and parent commits
$diffOutput = git diff --name-only $parentCommitHash $currentCommitHash -- pipelines/

# Check the output of git diff
if ($diffOutput) {
    Write-Output "Changed"
} else {
    Write-Output "Not changed"
}



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
