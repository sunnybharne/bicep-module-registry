targetScoe = 'subscription'

resource testRgModuless 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: 'ds'
  location: 'swedencentral'
}
