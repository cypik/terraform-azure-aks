
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = "https://github.com/cypik/terraform-azure-aks"
  description = "Terraform current module repo"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "info@cypik.com"
  description = "ManagedBy, eg 'info@cypik.com'"
}

variable "extra_tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. map(`BusinessUnit`,`XYZ`)."
}

variable "enabled" {
  type        = bool
  description = "Set to false to prevent the module from creating any resources."
  default     = true
}

variable "resource_group_name" {
  type        = any
  default     = ""
  description = "A container that holds related resources for an Azure solution"
}

variable "location" {
  type        = string
  default     = ""
  description = "Location where resource should be created."
}

variable "kubernetes_version" {
  type        = string
  default     = "1..24.3"
  description = "Version of Kubernetes to deploy"
}

variable "aks_sku_tier" {
  type        = string
  default     = "Free"
  description = "aks sku tier. Possible values are Free ou Paid"
}

variable "private_cluster_enabled" {
  type        = bool
  default     = true
  description = "Configure AKS as a Private Cluster : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#private_cluster_enabled"
}

variable "node_resource_group" {
  type        = string
  default     = null
  description = "Name of the resource group in which to put AKS nodes. If null default to MC_<AKS RG Name>"
}

variable "private_dns_zone_type" {
  type        = string
  default     = "System"
  description = <<EOD
Set AKS private dns zone if needed and if private cluster is enabled (privatelink.<region>.azmk8s.io)
- "Custom" : You will have to deploy a private Dns Zone on your own and pass the id with <private_dns_zone_id> variable
If this settings is used, aks user assigned identity will be "userassigned" instead of "systemassigned"
and the aks user must have "Private DNS Zone Contributor" role on the private DNS Zone
- "System" : AKS will manage the private zone and create it in the same resource group as the Node Resource Group
- "None" : In case of None you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning.
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#private_dns_zone_id
EOD
}

variable "default_node_pool" {
  description = <<EOD
Default node pool configuration:
```
map(object({
    name                  = string
    count                 = number
    vm_size               = string
    os_type               = string
    availability_zones    = list(number)
    enable_auto_scaling   = bool
    min_count             = number
    max_count             = number
    type                  = string
    node_taints           = list(string)
    vnet_subnet_id        = string
    max_pods              = number
    os_disk_type          = string
    os_disk_size_gb       = number
    enable_node_public_ip = bool
}))
```
EOD

  type    = map(any)
  default = {}
}

variable "private_dns_zone_id" {
  type        = string
  default     = null
  description = "Id of the private DNS Zone when <private_dns_zone_type> is custom"
}


variable "linux_profile" {
  description = "Username and ssh key for accessing AKS Linux nodes with ssh."
  type = object({
    username = string,
    ssh_key  = string
  })
  default = null
}

variable "service_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "CIDR used by kubernetes services (kubectl get svc)."
}

variable "outbound_type" {
  type        = string
  default     = "loadBalancer"
  description = "The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are `loadBalancer` and `userDefinedRouting`."
}

variable "nodes_subnet_id" {
  type        = string
  description = "Id of the subnet used for nodes"
}

variable "nodes_pools" {
  default     = []
  type        = list(any)
  description = "A list of nodes pools to create, each item supports same properties as `local.default_agent_profile`"

}

variable "edge_zone" {
  type        = string
  default     = null
  description = "Specifies the Edge Zone within the Azure Region where this Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
}

variable "image_cleaner_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Specifies whether Image Cleaner is enabled."
}

variable "image_cleaner_interval_hours" {
  type        = number
  default     = 48
  description = "(Optional) Specifies the interval in hours when images should be cleaned up. Defaults to `48`."
}

variable "role_based_access_control_enabled" {
  type        = bool
  default     = true
  description = "Whether role based acces control should be enabled or not"
}

variable "local_account_disabled" {
  type        = bool
  default     = false
  description = "Whether local account should be disable or not"
}

variable "aci_connector_linux_enabled" {
  type        = bool
  default     = false
  description = "Enable Virtual Node pool"
}

variable "aci_connector_linux_subnet_name" {
  type        = string
  default     = null
  description = "aci_connector_linux subnet name"
}

variable "ingress_application_gateway" {
  type = list(object({
    gateway_id   = optional(string)
    gateway_name = optional(string)
    subnet_cidr  = optional(string)
    subnet_id    = optional(list(string))
  }))
  default     = null
  description = "The instruction detection block"
}

variable "enable_http_proxy" {
  type        = bool
  default     = false
  description = "Enable HTTP proxy configuration."
}

variable "confidential_computing" {
  type = object({
    sgx_quote_helper_enabled = bool
  })
  default     = null
  description = "(Optional) Enable Confidential Computing."
}

variable "kubelet_identity" {
  type = object({
    client_id                 = optional(string)
    object_id                 = optional(string)
    user_assigned_identity_id = optional(string)
  })
  default     = null
  description = <<-EOT
 - `client_id` - (Optional) The Client ID of the user-defined Managed Identity to be assigned to the Kubelets. If not specified a Managed Identity is created automatically. Changing this forces a new resource to be created.
 - `object_id` - (Optional) The Object ID of the user-defined Managed Identity assigned to the Kubelets.If not specified a Managed Identity is created automatically. Changing this forces a new resource to be created.
 - `user_assigned_identity_id` - (Optional) The ID of the User Assigned Identity assigned to the Kubelets. If not specified a Managed Identity is created automatically. Changing this forces a new resource to be created.
EOT
}

variable "vnet_id" {
  type        = string
  default     = null
  description = "Vnet id that Aks MSI should be network contributor in a private cluster"
}

variable "enable_http_application_routing" {
  type        = bool
  default     = false
  description = "Enable HTTP Application Routing Addon (forces recreation)."
}

variable "enable_azure_policy" {
  type        = bool
  default     = true
  description = "Enable Azure Policy Addon."
}

variable "microsoft_defender_enabled" {
  type        = bool
  default     = false
  description = "Enable microsoft_defender_enabled Addon."
}


variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "The ID of log analytics"
}

variable "network_plugin" {
  type        = string
  default     = "azure"
  description = "Network plugin to use for networking."
}

variable "network_policy" {
  type        = string
  default     = null
  description = " (Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created."
}

variable "acr_enabled" {
  type        = bool
  default     = false
  description = "The enable and disable the acr access for aks"
}

variable "acr_id" {
  type        = string
  default     = ""
  description = "azure container resource id to provide access for aks"
}

variable "key_vault_id" {
  type        = string
  default     = ""
  description = "Specifies the URL to a Key Vault Key (either from a Key Vault Key, or the Key URL for the Key Vault Secret"
}

variable "capacity_reservation_group_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is `cilium`. Changing this forces a new resource to be created."
}

variable "workload_runtime" {
  type        = string
  default     = null
  description = "Used to specify the workload runtime. Allowed values are OCIContainer, WasmWasi and KataMshvVmIsolation."
}

variable "agents_availability_zones" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
}

variable "role_based_access_control" {
  type = list(object({
    managed                = bool
    tenant_id              = string
    admin_group_object_ids = list(string)
    azure_rbac_enabled     = bool
  }))
  default = null
}

# Diagnosis Settings Enable

variable "cmk_enabled" {
  type        = bool
  default     = false
  description = "Flag to control resource creation related to cmk encryption."
}
