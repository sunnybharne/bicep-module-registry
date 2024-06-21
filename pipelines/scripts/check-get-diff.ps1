#!/usr/bin/env pwsh

param(
[string]$FolderPath
)

Write-Output "Azure devops Script started"

Get-ChildItem



# Set the working directory to the Git repository root
#Set-Location -Path (Get-Item -Path ".\" -Verbose).FullName
#
## Run git diff and capture output
#$diffOutput = git diff HEAD~ -- $folder
#
#if ($diffOutput) {
#    Write-Output "Changes found in folder '$folder'"
#    $isDiff = $true
#} else {
#    Write-Output "No changes found in folder '$folder'"
#    $isDiff = $false
#}
#
#return $isDiff
