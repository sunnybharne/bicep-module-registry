param roleDefinitionID string

param containerRegistryName string

param principalID string

var roleAssignemenName = guid(principalID, roleDefinitionID, resourceGroup().id)

resource acrContainerRegistry 'Microsoft.ContainerRegistry/registries@2023-11-01-preview' existing = {
  name: containerRegistryName
}


resource acrRoleAssignment 'Microsoft.Authorization/roleAssignments@2021-04-01-preview' = {
  scope: acrContainerRegistry
  name: roleAssignemenName
  properties: {
    principalId: principalID
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionID)
  }
}

output name string = acrRoleAssignment.name
output resourceId string = acrRoleAssignment.id
