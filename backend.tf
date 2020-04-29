# Configure the Google Cloud tfstate file location
terraform {
  backend "gcs" {
    bucket = "tfstate-essai-romain"
    #prefix = "Buckets"
    #bucket = "premier-tfstate-gke"
    #prefix = "terraform11"
  }
}
