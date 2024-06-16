targetScope = 'subscription' 

@allowed([
  'swedencentral'
  'westeurope'
  ])
@description('The location of the Resource Group')
param location string

@description('The tags of the Resource Group')
param tags object 

@description('The name of the Resource Group')
param resourceGroupName string

@description('Resource Group')
resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

@description('The name of the Resource Group created')
output resourceGroupName string = resourceGroup.id
