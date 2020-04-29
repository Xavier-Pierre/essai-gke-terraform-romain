# GCP variables
#variable "bucket_name" {
#  description = "Name of the google storage bucket"
#  default = "premier-tfstate-gke"
#}

variable "region" {
  default = "europe-west1-b"
  description = "Region of resources"
}

# Project variables
variable "project_name" {
  default = "projet-essai-romain"
  #default = "premieressaieffy-274806"
  description = "The name of the Google Cloud project"
}

variable "env" {
  description = "The environnement of the Google Cloud project"
  default = "env-essai-romain"
  #default = {
  #  prod = "prod"
  #  rct = "rct"
  #  dev = "dev"
  #  sandbox = "sandbox"
  #}
}

variable "folder_id" {
  description = "ID of project's folder "
  default = "50"

  #default = {
  #  prod = "50"
  #  rct = "50"
  #  dev = "50"
  #  sandbox = "50"
  #}
}


# Network variables

variable "subnet_name" {
  description = "Subnet name (defaults to ENV-subnet)"
  default     = "subnet-essai-romain"
}


variable "subnet_cidr" {
    default = "10.110.0.0/24"
    #default = {
    #prod = "10.100.0.0/24"
    #rct = "10.60.0.0/24"
    #dev = "10.110.0.0/24"
    #sandbox = "10.160.0.0/24"
  #}
  description = "Subnet range"
}

variable "subnet_cidr_private" {
  default = "10.110.0.0/24"
  #default = "10.0.0.0/24"
  #default = {
  #  prod = "10.0.0.0/24"
  #  rct = "10.0.0.0/24"
  #  dev = "10.0.0.0/24"
  #  sandbox = "10.0.0.0/24"
  #}
  description = "Subnet range"
}

variable "secondary_ip_cidr_gke_pods" {
  description = "description"
  default = "10.10.0.0/16"
  #default = "10.110.0.0/16"
}

variable "secondary_ip_cidr_gke_svc" {
  description = "description"
  default = "10.20.0.0/16"
  #default = "10.110.0.0/16"
}

variable "gke_master_cidr_range" {
  description = "description"
  default = "10.0.128.0/28"
}

# GKE variables
variable "min_master_version" {
  default = "1.14.10"
  description = "Number of nodes in each GKE cluster zone"
}

variable "node_version" {
  default = "1.14.10-gke.24"
  description = "Number of nodes in each GKE cluster zone"
}

variable "gke_num_nodes" {
  default = 4
  
  #default = {
  #  prod = 4
  #  rct = 4
  #  dev = 4
  #  sandbox = 3
  #}
  description = "Number of nodes in each GKE cluster zone"
}

variable "gke_node_machine_type" {
  default = "n1-standard-1"
  
  #default = {
  #  prod = "n1-standard-4"
  #  rct = "n1-standard-2"
  #  dev = "n1-standard-1"
  #  sandbox = "n1-standard-1"
  #}
  description = "Machine type of GKE nodes"
}

variable "gke_node_machine_disk_size" {
  default = "50"
  
  #default = {
  #  prod = "50"
  #  rct = "50"
  #  dev = "50"
  #  sandbox = "50"
  #}
  description = "Disk size of machine of GKE nodes"
}

variable "activate_apis" {
  description = "The list of apis to activate within the project"
  type = "list"
  default = [
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "logging.googleapis.com",
    #"monitoring.googleapis.com",
    #"oslogin.googleapis.com",
    #"replicapool.googleapis.com",
    #"replicapoolupdater.googleapis.com",
    "resourceviews.googleapis.com",
    "servicemanagement.googleapis.com",
    #"sql-component.googleapis.com",
    #"sqladmin.googleapis.com",
    #"storage-api.googleapis.com",
    #"redis.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    #"cloudasset.googleapis.com",
    #"stackdriver.googleapis.com"
  ]
}
