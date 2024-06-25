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

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
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

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: '${containerRegistryName}-privateDns'
  location: 'global'
  properties: {}
  tags: tags
}

resource privateDnsZoneLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: privateDnsZone
  name: '${containerRegistryName}-link'
  location: 'global'
  properties: {
    registrationEnabled: false
    virtualNetwork: {
      id: resourceId('Microsoft.Network/virtualNetworks', vnetName)
    }
  }
}

resource privateDnsZoneGroup 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2021-05-01' = {
  name: '${containerRegistryName}-private-dns-zone-group'
  properties: {
    privateDnsZoneConfigs: [
      {
        name: '${containerRegistryName}-private-dns-zone-config'
        properties: {
          privateDnsZoneId: privateDnsZone.id
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

