variable "GOOGLE_PROJECT" {
  description = "GCP project name"
  type        = string
}

variable "GOOGLE_LOCATION" {
  description = "GCP region name"
  type        = string
  default     = "us-central1-c"
}

variable "GKE_MACHINE_TYPE" {
  description = "machine type"
  type        = string
  default     = "g1-small"
}

variable "GKE_NUM_NODES" {
  description = "node pool"
  type        = number
  default     = 2
}

# variable "KUBECONFIG_PATH" {
#   type     = string
#   nullable = false
# }

