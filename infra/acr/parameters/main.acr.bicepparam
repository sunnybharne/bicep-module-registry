using '../main.bicep'

@description('Name of the location')
param location ='swedencentral'

@description('Subscription ID')
param subscriptionId ='ce5d875c-f189-49cf-8099-678b1a071852'

@description('Name of the resource group')
param resourceGroupName ='tuttu-rg-platformiac-sc-01'

@description('Name of the container registry')
param containerRegistryName ='tuttuacrplatformiacsc01'

@description('Name of the managed identity for the container registry')
param userAssignedManagedIdentityName = 'tuttu-acrplatformiacsc-sc-01'

// param roleDefinitionResourceId = '5075d14b-053a-4670-8c7a-5654ab311ba3'

@description('Tags for the resource group')
param tags = {  
  environment:'nonprod'
}

param acrPushRoleDefinitionId = '8311e382-0749-4cb8-b61a-304f252e45ec'
