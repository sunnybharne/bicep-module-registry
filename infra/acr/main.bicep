targetScope = 'subscription'

@description('Location of the resource group')
param location string

@description('Tags for the resource group')
param tags object

@description('Subscription ID')
param subscriptionId string

@description('Name of the resource group')
param resourceGroupName string

@description('Name of the container registry')
param containerRegistryName string

@description('Name of the managed identity')
param userAssignedManagedIdentityName string

param acrPushRoleDefinitionId string

var acrRollAssignementName = 'acr-push-roleassignment-sc-nonprod-01'

// @description('roleDefinitionResourceId for the acr push role')
// param roleDefinitionResourceId string

//@description('Allowed IP addresses for the container registry')
//param allowedIpAddresses string 

//@description('acrPull Principal ID')
//param acrPullPrincipalId string

//@description('acrPull Role Definition ID')
//param acrPullRoleId string

@description('acr resource group')
module acrResourceGroup 'modules/resourceGroup.bicep' = {
  name: resourceGroupName
  params:{
    resourceGroupName: resourceGroupName
    tags: tags
    location: location
  }
  scope: subscription(subscriptionId)
}

module userAssignedManagedIdentity 'modules/userAssignedManagedIdentity.bicep' = {
  name: userAssignedManagedIdentityName
  params:{
    location: location
    tags: tags
    userAssignedManagedIdentityName: userAssignedManagedIdentityName
  }
  scope: resourceGroup(resourceGroupName)
  dependsOn: [
    acrResourceGroup
  ]
}


@description('container registry')
module containerRegistry 'modules/containerRegistry.bicep' = {
  name: containerRegistryName
  params:{
    acrSku: 'Premium'
    location: location
    registryName: containerRegistryName
    tags: tags
  }
  scope: resourceGroup(resourceGroupName) 
  dependsOn: [
    acrResourceGroup 
    userAssignedManagedIdentity
  ]
}

module geoReplication 'modules/acrGeoReplication.bicep' = {
  scope: resourceGroup(resourceGroupName)
  dependsOn: [
    containerRegistry
  ]
  name: 'geoReplication'
  params:{
    containerRegistryName: containerRegistryName
  }
}

module acrRoleAssignment 'modules/acrRoleAssignment.bicep' = {
  scope: resourceGroup(resourceGroupName)
  dependsOn: [
    containerRegistry
    userAssignedManagedIdentity
  ]
  name: acrRollAssignementName
  params:{
    roleDefinitionID: acrPushRoleDefinitionId
    containerRegistryName: containerRegistryName
    principalID: userAssignedManagedIdentity.outputs.id
  }
}
