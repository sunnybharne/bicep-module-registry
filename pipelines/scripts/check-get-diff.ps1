#!/usr/bin/env pwsh

#Variables
# Define the path to the script to be called
$scriptPath = "./Get-ChangedFiles.ps1"
# Define the parameter for the called script
$gitDiffPath = "modules/resources/*.bicep"

# Change the directory to the repository root
Set-Location -Path $Env:BUILD_REPOSITORY_LOCALPATH

# Call the script and capture the returned value using the call operator
$changedFiles = & $scriptPath -gitDiffPath $gitDiffPath

#az acr login -n tuttuacrplatformiacsc01
#
## Loop through each changed .bicep file and publish to ACR
#foreach ($file in $changedFiles) {
#
#  az bicep publish -f $file --target $publishtarget
#
#  #if ($file) {
#    # Construct the ACR image name and tag
#    #$imageName = [System.IO.Path]::GetFileNameWithoutExtension($file)
#    #$acrImageTag = "$acrName.azurecr.io/$acrRepository/$imageName:latest"
#
#    # Publish the Bicep file to ACR
#    #Write-Output "Publishing $file to $acrImageTag"
#    #az bicep publish --file $file --target $acrImageTag
#
#    # Check if the publish was successful
#    #if ($LASTEXITCODE -ne 0) {
#    #Write-Output "Failed to publish $file"
#    #exit 1
#    #}
#}
