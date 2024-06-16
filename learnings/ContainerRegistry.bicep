/*
  This is public registry
  ACR by default accepts connections over the internet.
  Allow access from only specific public IP addresses/ranges.
  IP network rules do not apply to private endpoints configured with Private Link
  Configuring IP access rules is available in the Premium container registry service tier.
  When public network access to a registry is disabled Registry access by certain trusted services including.
    1. Azure Security Center requires enabling a network setting to bypass the network rules.
    2. Instances of certain Azure services including Azure DevOps Services are currently unable to access the container registry.
*/

// Step 1: Create Azure Container Registry 
// Public Container Registry
@minLength(5)
@maxLength(50)
@description('ACR name should be globally unique name, Please follow organisation naming convention')
param acrName string

@allowed([
  'Swedencentral'
  'WestEurope'
])
@description('Registry location, Choose Swedencentral or WestEurope')
param location string = resourceGroup().location

//@description('Array of public IP addresses allowed to access the registry')
//param allowedIpAddresses array = [
//  '87.92.40.175'
//  '97.92.10.175'
//]

@allowed([
  'Basic'
  'Standard'
  'Premium'
])
@description('ACR SKU Choose Basic,Standard or Premium')
param acrSku string = 'Premium'

@description('Create an Azure Container Registry')
resource acrResource 'Microsoft.ContainerRegistry/registries@2023-01-01-preview' = {
  name: acrName
  location: location
  sku: {
    name: acrSku
  }
  properties: {
    adminUserEnabled: false
    // This setting will make the registry not accessible from the public internet to anyone including the owner of the registry.
    networkRuleSet: {
      defaultAction: 'Deny'
      ipRules: [
      {
          action: 'Allow'
          value: '87.92.40.175'
        }
      ]   
    }
  }
}

@description('Output login server property')
output loginServer string = acrResource.properties.loginServer

/* Login to acr
az acr login --name repositoryName 
owner of the repository should be able tp login to the repository
*/

//--------------------------------------------------------------

/* 
Step 2: Access from selected public network - CLI 
First change the default action to deny access.
az acr update --name opacr --default-action Deny -> This can only be done in Premium tier
*/

