# terraform-azure-aks
# Terraform Azure Infrastructure

This Terraform configuration defines an Azure infrastructure using the Azure provider.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [License](#license)

## Introduction
This module provides a Terraform configuration for deploying various Azure resources as part of your infrastructure. The configuration includes the deployment of resource groups, virtual networks, subnets, aks.

## Usage
To use this module, you should have Terraform installed and configured for AZURE. This module provides the necessary Terraform configuration
for creating AZURE resources, and you can customize the inputs as needed. Below is an example of how to use this module:

# Examples

# Example: private

```hcl
module "aks" {
  source              = "git::https://github.com/opz0/terraform-azure-aks.git?ref=v1.0.0"
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  kubernetes_version  = "1.25.6"
  default_node_pool = {
    name                  = "agentpool"
    max_pods              = 200
    os_disk_size_gb       = 64
    vm_size               = "Standard_B2s"
    count                 = 1
    enable_node_public_ip = false
  }

  ##### if requred more than one node group.
  nodes_pools = [
    {
      name                  = "nodegroup1"
      max_pods              = 200
      os_disk_size_gb       = 64
      vm_size               = "Standard_B2s"
      count                 = 1
      enable_node_public_ip = false
      mode                  = "User"
    },

  ]
  #networking
  vnet_id         = module.vnet.id
  nodes_subnet_id = module.subnet.default_subnet_id
}
```

# Example: public

```hcl
module "aks" {
  source                  = "git::https://github.com/opz0/terraform-azure-aks.git?ref=v1.0.0"
  name                    = "app"
  environment             = "test"
  resource_group_name     = module.resource_group.resource_group_name
  location                = module.resource_group.resource_group_location
  kubernetes_version      = "1.25.6"
  private_cluster_enabled = false
  default_node_pool = {
    name                  = "agentpool1"
    max_pods              = 200
    os_disk_size_gb       = 64
    vm_size               = "Standard_B4ms"
    count                 = 1
    enable_node_public_ip = false
  }

  ##### if requred more than one node group.
  nodes_pools = [
    {
      name                  = "nodegroup2"
      max_pods              = 200
      os_disk_size_gb       = 64
      vm_size               = "Standard_B4ms"
      count                 = 1
      enable_node_public_ip = false
      mode                  = "User"
    },
  ]
  #networking
  vnet_id         = module.vnet.id
  nodes_subnet_id = module.subnet.default_subnet_id
}
```
This example demonstrates how to create various AZURE resources using the provided modules. Adjust the input values to suit your specific requirements.

## Module Inputs
- 'name': The name of the Managed Kubernetes Cluster to create.
- 'resource_group_name': Specifies the Resource Group where the Managed Kubernetes Cluster should exist.
- 'location': The location where the Managed Kubernetes Cluster should be created.

## Module Outputs
The module also provides outputs that you can use to retrieve information about the created resources, such as VM information and public IP addresses.

## Examples
For detailed examples on how to use this module, please refer to the 'examples' directory within this repository.

## License
This Terraform module is provided under the '[License Name]' License. Please see the [LICENSE](https://github.com/opz0/terraform-azure-aks/blob/readme/LICENSE) file for more details.

## Author
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.
