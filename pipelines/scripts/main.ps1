#!/usr/bin/env pwsh

Write-Output 'echoing build repository location'
Write-Output $Env:BUILD_REPOSITORY_LOCALPATH

#Variables
# Define the path to the script to be called
#$scriptPath = "./Get-ChangedFiles.ps1"
## Define the parameter for the called script
#$gitDiffPath = "modules/resources/*.bicep"
## Define the path to the script to be called
#$publishTargetScript = "./Get-PublishTarget.ps1"
## Acr name
#$acrName =  "tuttuacrplatformiacsc01.azurecr.io"
## version
#$version = 1.0.1.1
#
## Change the directory to the repository root
#Set-Location -Path $Env:BUILD_REPOSITORY_LOCALPATH
#
## Call the script and capture the returned value using the call operator
#$changedFiles = & $scriptPath -gitDiffPath $gitDiffPath
#
#az acr login -n tuttuacrplatformiacsc01
#
## Loop through each changed .bicep file and publish to ACR
#foreach ($file in $changedFiles) {
#
#  $target = & $publishTargetScript -acr $acrName -file $file -version $version 
#
#  Write-Output 'Target is below'
#  Write-Output $target


  #az bicep publish -f $file --target $publishtarget

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
}
