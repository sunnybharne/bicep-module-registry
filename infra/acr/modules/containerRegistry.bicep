@minLength(5)
@maxLength(50)
@description('Registry Name')
param registryName string

@description('Registry location, locaiton of the resource group')
param location string = resourceGroup().location

@description('Tags for the resource group')
param tags object

@allowed([
  'Basic'
  'Standard'
  'Premium'
])
@description('ACR SKU Choose Basic,Standard or Premium')
param acrSku string

@description('Create an Azure Container Registry')
resource acrResource 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: registryName
  location: location
  sku: {
    name: acrSku
  }
  tags: tags
  properties: {
    adminUserEnabled: false
    zoneRedundancy: 'Enabled'
  }
}

@description('Output login server property')
output id string = acrResource.id
