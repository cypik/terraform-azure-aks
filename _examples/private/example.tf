provider "azurerm" {
  features {}
}

module "resource_group" {
  source      = "cypik/resource-group/azure"
  version     = "1.0.2"
  name        = "app"
  environment = "tested"
  location    = "North Europe"
}

module "vnet" {
  source              = "cypik/vnet/azure"
  version             = "1.0.2"
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  address_space       = "10.30.0.0/16"
}



module "subnet" {
  source               = "cypik/subnet/azure"
  version              = "1.0.2"
  name                 = "app"
  environment          = "test"
  resource_group_name  = module.resource_group.resource_group_name
  location             = module.resource_group.resource_group_location
  virtual_network_name = module.vnet.name

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
  source              = "../.."
  name                = "app"
  environment         = "test"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.resource_group_location
  kubernetes_version  = "1.29.0"
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
