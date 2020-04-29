#list of providers
provider "google" {
  version = "~> 2.11"
  region  = "${var.region}"
}

provider "random" {}

# List of resources
resource "random_id" "id" {
  byte_length = 4
  prefix      = "${var.env}-"
}

resource "google_project" "project" {
  name                = "projet-essai-romain"
  project_id          = "${random_id.id.hex}"
  billing_account     = "${var.billing_account}"
#  folder_id           = "${var.folder_id[terraform.workspace]}"
  folder_id           = "${var.folder_id}"
  auto_create_network = "false"

  labels {
    env = "${var.env}"
  }
}

resource "google_project_service" "project_services" {
  count              = "${length(var.activate_apis)}"
  project            = "${google_project.project.project_id}"
  service            = "${element(var.activate_apis, count.index)}"
  disable_on_destroy = "${var.disable_services_on_destroy}"
  depends_on         = ["google_project.project"]
}

#module "gsuite_group_logs" {
#  source     = "../gsuite_group"
#  group_name = "${format("gcp-%s-%s-logs", var.env, var.project_name)}"
#}

#module "gsuite_group_write" {
#  source     = "../gsuite_group"
#  group_name = "${format("gcp-%s-%s-write", var.env, var.project_name)}"
#}

#module "gsuite_group_read" {
#  source     = "../gsuite_group"
#  group_name = "${format("gcp-%s-%s-read", var.env, var.project_name)}"
#}

#resource "google_project_iam_member" "write-acces" {
#  role       = "roles/viewer"
#  project    = "${google_project.project.project_id}"
#  member     = "group:${module.gsuite_group_write.group_email}"
#  depends_on = ["module.gsuite_group_write"]
#}

#resource "google_project_iam_member" "write-acces-cloudsql" {
#  role       = "roles/cloudsql.editor"
#  project    = "${google_project.project.project_id}"
#  member     = "group:${module.gsuite_group_write.group_email}"
#  depends_on = ["module.gsuite_group_write"]
#}

#resource "google_project_iam_member" "write-acces-k8s" {
#  role       = "roles/container.developer"
#  project    = "${google_project.project.project_id}"
#  member     = "group:${module.gsuite_group_write.group_email}"
#  depends_on = ["module.gsuite_group_write"]
#}

#resource "google_project_iam_member" "write-acces-storage" {
#  role       = "roles/storage.admin"
#  project    = "${google_project.project.project_id}"
#  member     = "group:${module.gsuite_group_write.group_email}"
#  depends_on = ["module.gsuite_group_write"]
#}

#resource "google_project_iam_member" "read-access" {
#  role       = "roles/viewer"
#  project    = "${google_project.project.project_id}"
#  member     = "group:${module.gsuite_group_read.group_email}"
#  depends_on = ["module.gsuite_group_read"]
#}

#resource "google_project_iam_member" "logs-access" {
#  role       = "roles/logging.viewer"
#  project    = "${google_project.project.project_id}"
#  member     = "group:${module.gsuite_group_logs.group_email}"
#  depends_on = ["module.gsuite_group_logs"]
#}

#resource "google_project_iam_member" "debugger-access" {
#  role       = "roles/clouddebugger.user"
#  project    = "${google_project.project.project_id}"
#  member     = "group:${module.gsuite_group_logs.group_email}"
#  depends_on = ["module.gsuite_group_logs"]
#}

#resource "google_project_iam_member" "trace-access" {
#  role       = "roles/cloudtrace.user"
#  project    = "${google_project.project.project_id}"
#  member     = "group:${module.gsuite_group_logs.group_email}"
#  depends_on = ["module.gsuite_group_logs"]
#}

#resource "google_project_iam_member" "error-access" {
#  role       = "roles/errorreporting.viewer"
#  project    = "${google_project.project.project_id}"
#  member     = "group:${module.gsuite_group_logs.group_email}"
#  depends_on = ["module.gsuite_group_logs"]
#}

#resource "google_project_iam_member" "monitoring-access" {
#  role       = "roles/monitoring.editor"
#  project    = "${google_project.project.project_id}"
#  member     = "group:${module.gsuite_group_logs.group_email}"
#  depends_on = ["module.gsuite_group_logs"]
#}

#resource "google_project_iam_member" "bouncer-k8s-access" {
#  count   = "${var.env == "prod" ? 0 : 1}"
#  role    = "roles/container.clusterAdmin"
#  project = "${google_project.project.project_id}"
#  member  = "serviceAccount:${var.bouncer_account}"
#}

#resource "google_project_iam_member" "bouncer-cloudsql-access" {
#  count   = "${var.env == "prod" ? 0 : 1}"
#  role    = "roles/cloudsql.editor"
#  project = "${google_project.project.project_id}"
#  member  = "serviceAccount:${var.bouncer_account}"
#}
