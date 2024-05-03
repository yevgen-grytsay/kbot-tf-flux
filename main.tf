# variable "kubeconfig" {
#   type    = string
#   default = "./kubeconfig"
# }

provider "google" {
  project = var.google_project_id
  zone    = var.google_location
}

provider "flux" {

  kubernetes = {
    config_path = module.gke.kubeconfig_local_file_path
  }

  git = {
    url = "https://github.com/${var.github_org}/${var.github_repository}"
    http = {
      username = var.github_org
      password = var.github_token
    }
  }
}

module "gke" {
  source = "./modules/tf-google-gke"

  providers = {
    google.alias = google
  }

  # KUBECONFIG_PATH = var.kubeconfig
  GOOGLE_PROJECT  = var.google_project_id
  GOOGLE_LOCATION = var.google_location
}

module "kbot-tf-flux-bootstrap" {
  depends_on = [module.gke]

  source = "./modules/tf-flux-bootstrap"

  providers = {
    flux.alias = flux
  }

  # github_org        = var.github_org
  # github_repository = var.github_repository
  # github_token      = var.github_token
  # kubeconfig_path = module.gke.kubeconfig_local_file_path
}
