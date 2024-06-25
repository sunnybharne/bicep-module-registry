targetScope = 'subscription'

resource testRgModuless 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'dsdds'
  location: 'swedencentral'
}
