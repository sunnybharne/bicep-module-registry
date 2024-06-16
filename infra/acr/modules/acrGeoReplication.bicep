param containerRegistryName string

resource acrContainerRegistry 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' existing = {
  name: containerRegistryName
}

resource geoReplication 'Microsoft.ContainerRegistry/registries/replications@2023-01-01-preview' = {
  name: 'georeplication'
  location: 'westeurope'
  tags: {
    tagName1: 'tagValue1'
    tagName2: 'tagValue2'
  }
  parent: acrContainerRegistry
  properties: {
    regionEndpointEnabled: true
    zoneRedundancy: 'Enabled'
  }
}
