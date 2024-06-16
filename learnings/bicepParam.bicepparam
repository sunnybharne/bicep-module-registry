// Location of the Azure .bicep file for the parameters
// One parameter file should be created for one bicpe file
// Parameter file should be in the same directory as the bicep file

// Import from private registry
// using 'br:<acr-name>.azurecr.io/bicep/<file-path>:<tag>'

// Import from public registry
// using 'br/public:<file-path>:<tag>'

//Import bicep file
//using './ResourceGroup.bicep'

// Prifix
var organisation = 'tuttu'
var resourceType = 'rg'
var resourceLocation = 'swedencentral'
var applicationType = 'acr'
var resourceNumber = '01'

// resourceName
var resourceName = '${organisation}-${resourceType}-${applicationType}-${resourceLocation}-${resourceNumber}'

@description('Location of the Azure resources')
param location = 'swedencentral'

@description('Name of the resource group')
param resourceGroupName = resourceName

@description('Tags for the resource group')
param tags = {  
  owner: 'Azure'
  environment: 'Production'
}

// Deploy the resource using below command
// az deployment group create --resource-group <resource-group-name> --template-file <bicep-file-path> --parameters <parameter-file-path> --mode Incremental

// Deployment stacks
// Deployment stack behaviour be configured to either detached or deleted based on the specified actionOnUnmanage.
// Access to the deployment stack can be restricted using Azure role-based access control (Azure RBAC), similar to other Azure resources.
// Efficient enovironment cleanup using delete flags during deployment stack updates.

// Deployment stacks
// az stack group create \
//   --name 'demoStack' \
//   --resource-group 'demoRg' \
//   --template-file './main.bicep' \
//   --action-on-unmanage 'detachAll' \
//   --deny-settings-mode 'none'
