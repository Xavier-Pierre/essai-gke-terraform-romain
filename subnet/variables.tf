# GCP variables
variable "region" {
  description = "Region of resources"
}

variable "project_id" {
  description = "Id of project"
}

# Subnet variables
variable "subnet_region" {
  default = "europe-west1"
  description = "Region of resources"
}

variable "vpc_name" {
  description = "Netwrok name"
}

variable "name" {
  description = "Subnet name (defaults to ENV-subnet)"
  default     = "subnet-essai-romain"
}

variable "subnet_cidr" {
  description = "Subnet range"
  default = "10.110.0.0/24"
  #default = "10.160.0.0/24"
}

variable "env" {
  description = "environnement"
}

variable "google_private_access" {
  type        = "string"
  description = "Enable Google private access"
  default     = false
}

variable "secondary_ip_ranges" {
  type        = "list"
  description = "Secondary IP ranges to add to the subnet"
  default     = []
}