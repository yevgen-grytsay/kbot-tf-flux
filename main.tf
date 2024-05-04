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

  CLUSTER_NAME     = var.app_name
  GOOGLE_PROJECT   = var.google_project_id
  GOOGLE_LOCATION  = var.google_location
  GKE_NUM_NODES    = var.gke_num_nodes
  GKE_MACHINE_TYPE = var.gke_machine_type
}

module "kbot-tf-flux-bootstrap" {
  depends_on = [module.gke]

  source = "./modules/tf-flux-bootstrap"

  providers = {
    flux.alias = flux
  }
}
