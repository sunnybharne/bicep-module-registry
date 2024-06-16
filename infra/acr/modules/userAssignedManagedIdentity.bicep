param tags object

param location string = resourceGroup().location

param userAssignedManagedIdentityName string

resource userAssignedManagedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2023-01-31' = {
  name: userAssignedManagedIdentityName
  location: location
  tags: tags
}

output id string = userAssignedManagedIdentity.properties.principalId
