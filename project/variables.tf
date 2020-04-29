# GCP variables
variable "region" {
  default = "europe-west1-b"
  description = "Region of resources"
}

variable "project_name" {
  description = "The NAME of the Google Cloud project"
}

variable "env" {
  description = "The environnement of the Google Cloud project"
  default = "subnet-essai-romain"
}

variable "billing_account" {
  default = "01D7AA-8E6C77-F165C4"
  #default = "017D88-D563CB-1A7382"
  description = "Billing account STRING."
}

variable "activate_apis" {
  description = "The list of apis to activate within the project"
  type = "list"
  default = ["bigquery-json.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "containerregistry.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",
    "oslogin.googleapis.com",
    "replicapool.googleapis.com",
    "replicapoolupdater.googleapis.com",
    "resourceviews.googleapis.com",
    "servicemanagement.googleapis.com",
    "sql-component.googleapis.com",
    "sqladmin.googleapis.com",
    "storage-api.googleapis.com",
    "redis.googleapis.com",
    "bigquery.googleapis.com"]
}

variable "disable_services_on_destroy" {
  description = "Whether project services will be disabled when the resources are destroyed"
  default = "true"
  type = "string"
}

variable "folder_id" {
    default = ""
    #default = {
    #  prod = "958662920540"
    #  dev = "16196371409"
    #  rct = "899315352079"
    #  sandbox = "100432350724"
    #}
}

