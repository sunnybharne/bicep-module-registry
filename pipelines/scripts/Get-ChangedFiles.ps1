#!/usr/bin/env pwsh

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0, HelpMessage = "Bicep module location")]
    [ValidateNotNullOrEmpty()]
    [ValidateSet("modules/resources/*.bicep", "modules/services/*.bicep", "modules/products/*.bicep")]
    [string]$gitDiffPath
)

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

Write-Output changedFiles.Length

# Return changedFiles
#$diffOutput
