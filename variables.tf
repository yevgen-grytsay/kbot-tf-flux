variable "github_token" {
  type      = string
  sensitive = true
}

variable "github_org" {
  type = string
}

variable "github_repository" {
  type = string
}

variable "google_project_id" {
  type = string
}

variable "google_location" {
  type = string
}

variable "app_name" {
  description = "will be used to name various resources"
  type        = string
}

variable "gke_num_nodes" {
  description = "number of nodes in GKE cluster"
  type        = string
}

variable "gke_machine_type" {
  description = "type of machines that will be created for GKE cluster"
  type        = string
}
