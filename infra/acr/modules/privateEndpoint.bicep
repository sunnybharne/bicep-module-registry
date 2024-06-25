// Module to create a private endpoint for ACR

@description('Location of the private endpoint')
param location string

@description('Tags for the private endpoint')
param tags object

@description('Name of the Virtual Network')
param vnetName string

@description('Name of the subnet')
param subnetName string

@description('Name of the container registry')
param containerRegistryName string

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-11-01' = {
  name: '${containerRegistryName}-private-endpoint'
  location: location
  tags: tags
  properties: {
    subnet: {
      id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, subnetName)
    }
    privateLinkServiceConnections: [
      {
        name: '${containerRegistryName}-plsc'
        properties: {
          privateLinkServiceId: resourceId('Microsoft.ContainerRegistry/registries', containerRegistryName)
          groupIds: ['registry']
        }
      }
    ]
  }
}

resource privateDnsZoneGroup 'Microsoft.Network/privateDnsZoneGroups@2021-02-01' = {
  name: '${containerRegistryName}-private-dns-zone-group'
  location: location
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'privatelink.azurecr.io'
        properties: {
          privateDnsZoneId: resourceId('Microsoft.Network/privateDnsZones', 'privatelink.azurecr.io')
        }
      }
    ]
  }
  dependsOn: [
    privateEndpoint
  ]
}

// Output the ID of the private endpoint
output id string = privateEndpoint.id

