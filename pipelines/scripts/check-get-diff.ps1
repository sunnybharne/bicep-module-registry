#!/usr/bin/env pwsh

#param(
#[string]$FolderPath
#)

Write-Output "Azure devops Script started"

# Run git diff and capture output
$pipelines = git diff HEAD -- $pipelines
$modules = git diff HEAD -- $modules

Write-Output $pipelines "Diff in pipelinefolder" 
Write-Output $modules "Diff in modules folder" 

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
