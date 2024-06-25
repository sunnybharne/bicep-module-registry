using '../main.bicep'

// Description: Location of the resource group and other resources
@description('Name of the location')
param location = 'swedencentral'

// Description: Subscription ID for the Azure subscription
@description('Subscription ID')
param subscriptionId = 'ce5d875c-f189-49cf-8099-678b1a071852'

// Description: Name of the resource group where resources will be deployed
@description('Name of the resource group')
param resourceGroupName = 'tuttu-rg-platformiac-sc-01'

// Description: Name of the container registry
@description('Name of the container registry')
param containerRegistryName = 'tuttuacrplatformiacsc01'

// Description: Name of the user-assigned managed identity for the container registry
@description('Name of the managed identity for the container registry')
param userAssignedManagedIdentityName = 'tuttu-acrplatformiacsc-sc-01'

// Description: Tags to be assigned to the resource group
@description('Tags for the resource group')
param tags = {  
  environment: 'nonprod'
}

// Description: Role definition ID for the ACR Push role
param acrPushRoleDefinitionId = '8311e382-0749-4cb8-b61a-304f252e45ec'

// Description: The name of the Virtual Network
@description('Name of the Virtual Network')
param vnetName = 'acrvnet'

// Description: The address prefix for the Virtual Network
@description('Address prefix for the Virtual Network')
param vnetAddressPrefix = '10.0.0.0/24'

// Description: The name of the first subnet
@description('Name of the first subnet')
param subnet1Name = 'subnet1'

// Description: The address prefix for the first subnet
@description('Address prefix for the first subnet')
param subnet1AddressPrefix = '10.0.0.0/25'

// Description: The name of the second subnet
@description('Name of the second subnet')
param subnet2Name = 'subnet2'

// Description: The address prefix for the second subnet
@description('Address prefix for the second subnet')
param subnet2AddressPrefix = '10.0.0.128/25'

