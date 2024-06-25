// VNet module with two subnets

@description('The name of the Virtual Network')
param vnetName string

@description('The address prefix for the Virtual Network')
param vnetAddressPrefix string

@description('The name of the first subnet')
param subnet1Name string

@description('The address prefix for the first subnet')
param subnet1AddressPrefix string

@description('The name of the second subnet')
param subnet2Name string

@description('The address prefix for the second subnet')
param subnet2AddressPrefix string

resource vnet 'Microsoft.Network/virtualNetworks@2022-01-01' = {
  name: vnetName
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnet1Name
        properties: {
          addressPrefix: subnet1AddressPrefix
        }
      }
      {
        name: subnet2Name
        properties: {
          addressPrefix: subnet2AddressPrefix
        }
      }
    ]
  }
}

// Output the IDs of the VNet and Subnets
output vnetId string = vnet.id
output subnet1Id string = vnet.properties.subnets[0].id
output subnet2Id string = vnet.properties.subnets[1].id

