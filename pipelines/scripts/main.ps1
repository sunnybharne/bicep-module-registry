#!/usr/bin/env pwsh

#Variables
# Define the path to the script to be called

$repoName = 'bicep-module-registry'
$psSriptsPath = $Env:BUILD_REPOSITORY_LOCALPATH + '/' + $repoName + '/pipelines/scripts'
$changedFileScript = './pipelines/scripts/Get-ChangedFiles.ps1'
#$publishTargetScript = './pipelines/scripts/.ps1'
$gitDiffPath = 'modules/resources/*.bicep'
$acrName =  "tuttuacrplatformiacsc01.azurecr.io"
$version = 1.0.1.1

Write-Output 'echoing build repository location'
Write-Output $changedFileScript
Write-Output $publishTargetScript
Write-Output $diffPath

# Change the directory to the repository root
Set-Location -Path $Env:BUILD_REPOSITORY_LOCALPATH

# Call the script and capture the returned value using the call operator
$changedFiles = & $changedFileScript -gitDiffPath  $gitDiffPath

Write-Output 'writing changefiles'
Write-Output $changedFiles

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
#}
