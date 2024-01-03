output "name" {
  value       = join("", azurerm_kubernetes_cluster.aks[*].name)
  description = "Specifies the name of the AKS cluster."
}

output "id" {
  value       = join("", azurerm_kubernetes_cluster.aks[*].id)
  description = "Specifies the resource id of the AKS cluster."
}

output "kube_config_raw" {
  value       = join("", azurerm_kubernetes_cluster.aks[*].kube_config_raw)
  description = "Contains the Kubernetes config to be used by kubectl and other compatible tools."
}

output "aks_system_identity_principal_id" {
  value       = azurerm_kubernetes_cluster.aks[0].identity[0].principal_id
  description = "Content aks system identity's object id"
}

output "node_resource_group" {
  value       = join("", azurerm_kubernetes_cluster.aks[*].node_resource_group)
  description = "Specifies the resource id of the auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster."
}

output "kube_config" {
  value       = azurerm_kubernetes_cluster.aks[*].kube_config
  sensitive   = true
  description = "Kubeconfig settings for connecting to the Azure Kubernetes Service (AKS) cluster."
}

output "host" {
  value       = azurerm_kubernetes_cluster.aks[0].kube_config[0].host
  description = "The Kubernetes cluster server host."

}

output "client_certificate" {
  value       = azurerm_kubernetes_cluster.aks[0].kube_config[0].client_certificate
  description = "Base64 encoded public certificate used by clients to authenticate to the Kubernetes cluster."
}

output "client_key" {
  value       = azurerm_kubernetes_cluster.aks[0].kube_config[0].client_key
  description = "Base64 encoded private key used by clients to authenticate to the Kubernetes cluster."
}

output "cluster_ca_certificate" {
  value       = azurerm_kubernetes_cluster.aks[0].kube_config[0].cluster_ca_certificate
  description = "Base64 encoded public CA certificate used as the root of trust for the Kubernetes cluster."
}


