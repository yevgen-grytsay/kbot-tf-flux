resource "google_container_cluster" "cluster" {
  name     = var.CLUSTER_NAME
  location = var.GOOGLE_LOCATION

  remove_default_node_pool = true
  initial_node_count       = 1

  deletion_protection = false
}

resource "google_container_node_pool" "main" {
  name       = var.CLUSTER_NAME
  project    = google_container_cluster.cluster.project
  cluster    = google_container_cluster.cluster.name
  location   = google_container_cluster.cluster.location
  node_count = var.GKE_NUM_NODES

  node_config {
    machine_type = var.GKE_MACHINE_TYPE
  }
}

module "gke_auth" {
  depends_on = [google_container_cluster.cluster, google_container_node_pool.main]
  source     = "terraform-google-modules/kubernetes-engine/google//modules/auth"
  version    = "30.2.0"

  project_id   = var.GOOGLE_PROJECT
  cluster_name = var.CLUSTER_NAME
  location     = var.GOOGLE_LOCATION

  # use_private_endpoint = true
}

resource "local_file" "kubeconfig" {
  content  = module.gke_auth.kubeconfig_raw
  filename = pathexpand("${path.module}/kubeconfig")
}
