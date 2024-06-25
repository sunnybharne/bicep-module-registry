using '../main.bicep'

// Parameter file for the main Bicep template

@description('Location of the resources')
param location string = 'swedencentral'

@description('Subscription ID')
param subscriptionId string = 'ce5d875c-f189-49cf-8099-678b1a071852'

@description('Name of the resource group')
param resourceGroupName string = 'tuttu-rg-platformiac-sc-01'

@description('Name of the container registry')
param containerRegistryName string = 'tuttuacrplatformiacsc01'

@description('Name of the managed identity for the container registry')
param userAssignedManagedIdentityName string = 'tuttu-acrplatformiacsc-sc-01'

@description('Tags for the resource group')
param tags = {  
  environment: 'nonprod'
}

@description('Role definition ID for the ACR Push role')
param acrPushRoleDefinitionId string = '8311e382-0749-4cb8-b61a-304f252e45ec'

@description('Name of the Virtual Network')
param vnetName string = 'acrvnet'

@description('Address prefix for the Virtual Network')
param vnetAddressPrefix string = '10.0.0.0/24'

@description('Name of the first subnet')
param subnet1Name string = 'subnet1'

@description('Address prefix for the first subnet')
param subnet1AddressPrefix string = '10.0.0.0/25'

@description('Name of the second subnet')
param subnet2Name string = 'subnet2'

@description('Address prefix for the second subnet')
param subnet2AddressPrefix string = '10.0.0.128/25'
