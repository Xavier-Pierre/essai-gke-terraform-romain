# GCP variables
variable "env" {
  description = "Environnement project"
}

variable "region" {
  description = "Region of resources"
}

variable "project_id" {
  description = "Id of project"
}

variable "project_name" {
  description = "Name of project"
  default = "projet-essai-romain"
  #default = "premieressaieffy-274806"
}

# GKE variables
variable "min_master_version" {
  description = "Number of nodes in each GKE cluster zone"
}

variable "node_version" {
  description = "Number of nodes in each GKE cluster zone"
}

variable "gke_num_nodes" {
  description = "Number of nodes in each GKE cluster zone"
}

variable "gke_node_machine_type" {
  description = "Machine type of GKE nodes"
}

variable "gke_node_machine_disk_size" {
  description = "Disk size of machine of GKE nodes"
}

# GKE variables with default
variable "gke_region" {
  default = "europe-west1"
  type = "string"
  description = "Region of Cloud Sql"
}

variable "gke_master_user" {
  default = "k8s_admin"
  description = "Username to authenticate with the k8s master"
}

# Backend variables
variable "vpc_name" {
  description = "vpc name"
}

variable "subnet_name" {
  description = "subnet name"
}

variable site {
  description = "nom du site"
  default = "dev-quellenergie.quelleenergie.fr"
}

variable "issue_client_certificate" {
  default = false
}

variable "pods_cidr_range_name" {
  type        = "string"
  description = "Secondary range name for pods"
}

variable "services_cidr_range_name" {
  type        = "string"
  description = "Secondary range name for services"
}

variable "master_cidr_range" {
  type        = "string"
  description = "CIDR range for GKE master nodes (must not overlap with all other ranges"
}
