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

# Check if there are changes in files under the 'pipelines/' folder between current and parent commits
$diffOutput = git diff HEAD^ --name-only -- modules/resources/*.bicep

$changedFiles = $diffOutput -split "`n"


Write-Output "Below is the diffoutupt"
Write-Output $changedFile

Write-Output "Below is the changedfilesarray"
Write-Output $changedFiles



# Check if there are any changes to the modules
if ($diffOutput) {
    Write-Output "Found changed to the x folder"
} else {
    Write-Output "No changes were found on the x folders"
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
