# Bicep module registry

This repository contains the Bicep module registry. This registry is a collection of Bicep modules that can be used in your Bicep files.

#### Repository structure:

```bash
bicep-module-registry  # root folder
├── infra
│   ├── acr
│   │   ├──modules # acr modules are stored here locally
│   │   │   ├── resource-group.bicep
│   │   │   ├── container-registry.bicep
│   │   │   ├── user-assigned-identity.bicep
│   │   │   ├── acr-role-assigment.bicep
│   │   │   ├── acr-geo-replication.bicep
│   │   ├──parameters  # acr module parameters are stored here
│   │   │   ├── main.acr.parameters.bicepparam
│   │   ├──main.bicep # starting point for acr module
```
