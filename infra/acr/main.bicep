targetScope = 'subscription'

// Description: Location of the resource group
@description('Location of the resource group')
param location string

// Description: Tags for the resource group
@description('Tags for the resource group')
param tags object

// Description: Subscription ID
@description('Subscription ID')
param subscriptionId string

// Description: Name of the resource group
@description('Name of the resource group')
param resourceGroupName string

// Description: Name of the container registry
@description('Name of the container registry')
param containerRegistryName string

// Description: Name of the managed identity
@description('Name of the managed identity')
param userAssignedManagedIdentityName string

// Description: Role definition ID for the ACR Push role
@description('Role definition ID for the ACR Push role')
param acrPushRoleDefinitionId string

// Variable: Name for the ACR role assignment
// var acrRollAssignementName = 'acr-push-roleassignment-sc-nonprod-01'

// Description: The name of the Virtual Network
@description('The name of the Virtual Network')
param vnetName string

// Description: The address prefix for the Virtual Network
@description('The address prefix for the Virtual Network')
param vnetAddressPrefix string

// Description: The name of the first subnet
@description('The name of the first subnet')
param subnet1Name string

// Description: The address prefix for the first subnet
@description('The address prefix for the first subnet')
param subnet1AddressPrefix string

// Description: The name of the second subnet
@description('The name of the second subnet')
param subnet2Name string

// Description: The address prefix for the second subnet
@description('The address prefix for the second subnet')
param subnet2AddressPrefix string

// Module: Create resource group for ACR
@description('Resource group for ACR')
module acrResourceGroup 'modules/resourceGroup.bicep' = {
  name: 'acrResourceGroupDeployment'
  params:{
    resourceGroupName: resourceGroupName
    tags: tags
    location: location
  }
  scope: subscription(subscriptionId)
}

// Module: Create VNet with two subnets
@description('Virtual Network with two subnets')
module vnetModule 'modules/acrVnet.bicep' = {
  name: 'vnetModuleDeployment'
  params: {
    vnetName: vnetName
    vnetAddressPrefix: vnetAddressPrefix
    subnet1Name: subnet1Name
    subnet1AddressPrefix: subnet1AddressPrefix
    subnet2Name: subnet2Name
    subnet2AddressPrefix: subnet2AddressPrefix
  }
  scope: resourceGroup(resourceGroupName)
}

// Module: Create user-assigned managed identity
@description('User-assigned managed identity')
module userAssignedManagedIdentity 'modules/userAssignedManagedIdentity.bicep' = {
  name: 'userAssignedManagedIdentityDeployment'
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

// Module: Create container registry
@description('Container registry')
module containerRegistry 'modules/containerRegistry.bicep' = {
  name: 'containerRegistryDeployment'
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

// Module: Create private endpoint for ACR
@description('Private endpoint for ACR')
module privateEndpoint 'modules/privateEndpoint.bicep' = {
  name: 'privateEndpointDeployment'
  params: {
    location: location
    tags: tags
    vnetName: vnetName
    subnetName: subnet1Name
    containerRegistryName: containerRegistryName
  }
  scope: resourceGroup(resourceGroupName)
  dependsOn: [
    containerRegistry
    vnetModule
  ]
}

// Module: Assign ACR Push role to managed identity
@description('Assign ACR Push role to managed identity')
module acrRoleAssignment 'modules/acrRoleAssignment.bicep' = {
  name: 'acrRoleAssignmentDeployment'
  params:{
    roleDefinitionID: acrPushRoleDefinitionId
    containerRegistryName: containerRegistryName
    principalID: userAssignedManagedIdentity.outputs.id
  }
  scope: resourceGroup(resourceGroupName)
  dependsOn: [
    containerRegistry
    userAssignedManagedIdentity
  ]
}
