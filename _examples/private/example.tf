provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "git::git@github.com:opz0/terraform-azure-resource-group.git?ref=master"
  name        = "app11"
  environment = "tested"
  location    = "North Europe"
}

module "vnet" {
  source              = "git::git@github.com:opz0/terraform-azure-vnet.git?ref=master"
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "10.30.0.0/16"
}



module "subnet" {
  source = "git::git@github.com:opz0/terraform-azure-subnet.git?ref=master"

  name                 = "app"
  environment          = "test"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.vnet_name[0]

  #subnet
  subnet_names    = ["subnet1"]
  subnet_prefixes = ["10.30.0.0/20"]

  # route_table
  enable_route_table = true
  route_table_name   = "default_subnet"
  routes = [
    {
      name           = "rt-test"
      address_prefix = "0.0.0.0/0"
      next_hop_type  = "Internet"
    }
  ]
}


module "aks" {
  source      = "../.."
  name        = "app"
  environment = "test"

  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location

  kubernetes_version = "1.25.6"
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
  vnet_id         = join("", module.vnet.vnet_id)
  nodes_subnet_id = module.subnet.default_subnet_id
  # acr_id       = "****" #pass this value if you  want aks to pull image from acr else remove it
  #  key_vault_id = module.vault.id #pass this value of variable 'cmk_enabled = true' if you want to enable Encryption with a Customer-managed key else remove it.

  #### enable diagnostic setting.
  microsoft_defender_enabled = false
  diagnostic_setting_enable  = false
  #log_analytics_workspace_id = module.log-analytics.workspace_id # when diagnostic_setting_enable = true && oms_agent_enabled = true
}
