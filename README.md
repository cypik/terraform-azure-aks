# Terraform-azure-aks

# Terraform Azure Cloud Aks Module

## Table of Contents
- [Introduction](#introduction)
- [Usage](#usage)
- [Examples](#examples)
- [Author](#author)
- [License](#license)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Introduction
This module provides a Terraform configuration for deploying various Azure resources as part of your infrastructure. The configuration includes the deployment of resource groups, virtual networks, subnets, aks.

## Usage
To use this module, you should have Terraform installed and configured for AZURE. This module provides the necessary Terraform configuration
for creating AZURE resources, and you can customize the inputs as needed. Below is an example of how to use this module:

# Examples

# Example: private

```hcl
module "aks" {
  source              = "cypik/aks/azure"
  version             = "1.0.2"
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
  source                  = "cypik/aks/azure"
  version                 = "1.0.2"
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

## Examples
For detailed examples on how to use this module, please refer to the [Examples](https://github.com/cypik/terraform-azure-aks/tree/master/_examples) directory within this repository.

## License
This Terraform module is provided under the **MIT** License. Please see the [LICENSE](https://github.com/cypik/terraform-azure-aks/blob/readme/LICENSE) file for more details.

## Author
Your Name
Replace **MIT** and **Cypik** with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.6.6 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=3.87.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.88.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | cypik/labels/azure | 1.0.1 |

## Resources

| Name | Type |
|------|------|
| [azurerm_disk_encryption_set.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/disk_encryption_set) | resource |
| [azurerm_key_vault_access_policy.key_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.kubelet_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.example](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_kubernetes_cluster.aks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster) | resource |
| [azurerm_kubernetes_cluster_node_pool.node_pools](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster_node_pool) | resource |
| [azurerm_role_assignment.aks_acr_access_object_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_acr_access_principal_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_system_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_uai_private_dns_zone_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_uai_vnet_network_contributor](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.aks_user_assigned](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.azurerm_disk_encryption_set_key_vault_access](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.aks_user_assigned_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acr_enabled"></a> [acr\_enabled](#input\_acr\_enabled) | The enable and disable the acr access for aks | `bool` | `false` | no |
| <a name="input_acr_id"></a> [acr\_id](#input\_acr\_id) | azure container resource id to provide access for aks | `string` | `""` | no |
| <a name="input_aks_sku_tier"></a> [aks\_sku\_tier](#input\_aks\_sku\_tier) | aks sku tier. Possible values are Free ou Paid | `string` | `"Free"` | no |
| <a name="input_cmk_enabled"></a> [cmk\_enabled](#input\_cmk\_enabled) | Flag to control resource creation related to cmk encryption. | `bool` | `false` | no |
| <a name="input_default_node_pool"></a> [default\_node\_pool](#input\_default\_node\_pool) | Default node pool configuration:<pre>map(object({<br>    name                  = string<br>    count                 = number<br>    vm_size               = string<br>    os_type               = string<br>    availability_zones    = list(number)<br>    enable_auto_scaling   = bool<br>    min_count             = number<br>    max_count             = number<br>    type                  = string<br>    node_taints           = list(string)<br>    vnet_subnet_id        = string<br>    max_pods              = number<br>    os_disk_type          = string<br>    os_disk_size_gb       = number<br>    enable_node_public_ip = bool<br>}))</pre> | `map(any)` | `{}` | no |
| <a name="input_enable_azure_policy"></a> [enable\_azure\_policy](#input\_enable\_azure\_policy) | Enable Azure Policy Addon. | `bool` | `true` | no |
| <a name="input_enable_http_application_routing"></a> [enable\_http\_application\_routing](#input\_enable\_http\_application\_routing) | Enable HTTP Application Routing Addon (forces recreation). | `bool` | `false` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_key_vault_id"></a> [key\_vault\_id](#input\_key\_vault\_id) | Specifies the URL to a Key Vault Key (either from a Key Vault Key, or the Key URL for the Key Vault Secret | `string` | `""` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | Version of Kubernetes to deploy | `string` | `"1..24.3"` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_linux_profile"></a> [linux\_profile](#input\_linux\_profile) | Username and ssh key for accessing AKS Linux nodes with ssh. | <pre>object({<br>    username = string,<br>    ssh_key  = string<br>  })</pre> | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Location where resource should be created. | `string` | `""` | no |
| <a name="input_log_analytics_workspace_id"></a> [log\_analytics\_workspace\_id](#input\_log\_analytics\_workspace\_id) | The ID of log analytics | `string` | `null` | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg 'ops0'. | `string` | `"Cypik"` | no |
| <a name="input_microsoft_defender_enabled"></a> [microsoft\_defender\_enabled](#input\_microsoft\_defender\_enabled) | Enable microsoft\_defender\_enabled Addon. | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_network_plugin"></a> [network\_plugin](#input\_network\_plugin) | Network plugin to use for networking. | `string` | `"azure"` | no |
| <a name="input_network_policy"></a> [network\_policy](#input\_network\_policy) | (Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_node_resource_group"></a> [node\_resource\_group](#input\_node\_resource\_group) | Name of the resource group in which to put AKS nodes. If null default to MC\_<AKS RG Name> | `string` | `null` | no |
| <a name="input_nodes_pools"></a> [nodes\_pools](#input\_nodes\_pools) | A list of nodes pools to create, each item supports same properties as `local.default_agent_profile` | `list(any)` | `[]` | no |
| <a name="input_nodes_subnet_id"></a> [nodes\_subnet\_id](#input\_nodes\_subnet\_id) | Id of the subnet used for nodes | `string` | n/a | yes |
| <a name="input_outbound_type"></a> [outbound\_type](#input\_outbound\_type) | The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are `loadBalancer` and `userDefinedRouting`. | `string` | `"loadBalancer"` | no |
| <a name="input_private_cluster_enabled"></a> [private\_cluster\_enabled](#input\_private\_cluster\_enabled) | Configure AKS as a Private Cluster : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#private_cluster_enabled | `bool` | `true` | no |
| <a name="input_private_dns_zone_id"></a> [private\_dns\_zone\_id](#input\_private\_dns\_zone\_id) | Id of the private DNS Zone when <private\_dns\_zone\_type> is custom | `string` | `null` | no |
| <a name="input_private_dns_zone_type"></a> [private\_dns\_zone\_type](#input\_private\_dns\_zone\_type) | Set AKS private dns zone if needed and if private cluster is enabled (privatelink.<region>.azmk8s.io)<br>- "Custom" : You will have to deploy a private Dns Zone on your own and pass the id with <private\_dns\_zone\_id> variable<br>If this settings is used, aks user assigned identity will be "userassigned" instead of "systemassigned"<br>and the aks user must have "Private DNS Zone Contributor" role on the private DNS Zone<br>- "System" : AKS will manage the private zone and create it in the same resource group as the Node Resource Group<br>- "None" : In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning.<br>https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#private_dns_zone_id | `string` | `"System"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | Terraform current module repo | `string` | `"https://github.com/cypik/terraform-azure-aks"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | A container that holds related resources for an Azure solution | `any` | `""` | no |
| <a name="input_role_based_access_control"></a> [role\_based\_access\_control](#input\_role\_based\_access\_control) | n/a | <pre>list(object({<br>    managed                = bool<br>    tenant_id              = string<br>    admin_group_object_ids = list(string)<br>    azure_rbac_enabled     = bool<br>  }))</pre> | `null` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | CIDR used by kubernetes services (kubectl get svc). | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | Vnet id that Aks MSI should be network contributor in a private cluster | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aks_system_identity_principal_id"></a> [aks\_system\_identity\_principal\_id](#output\_aks\_system\_identity\_principal\_id) | Content aks system identity's object id |
| <a name="output_client_certificate"></a> [client\_certificate](#output\_client\_certificate) | Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster. |
| <a name="output_client_key"></a> [client\_key](#output\_client\_key) | Base64 encoded private key used by clients to authenticate to the Kubernetes cluster. |
| <a name="output_cluster_ca_certificate"></a> [cluster\_ca\_certificate](#output\_cluster\_ca\_certificate) | Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster. |
| <a name="output_host"></a> [host](#output\_host) | The Kubernetes cluster server host. |
| <a name="output_id"></a> [id](#output\_id) | Specifies the resource id of the AKS cluster. |
| <a name="output_kube_config"></a> [kube\_config](#output\_kube\_config) | Kubeconfig settings for connecting to the Azure Kubernetes Service (AKS) cluster. |
| <a name="output_kube_config_raw"></a> [kube\_config\_raw](#output\_kube\_config\_raw) | Contains the Kubernetes config to be used by kubectl and other compatible tools. |
| <a name="output_name"></a> [name](#output\_name) | Specifies the name of the AKS cluster. |
| <a name="output_node_resource_group"></a> [node\_resource\_group](#output\_node\_resource\_group) | Specifies the resource id of the auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster. |
<!-- END_TF_DOCS -->