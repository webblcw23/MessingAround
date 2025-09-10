provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_container_cluster" "primary" {
  name                     = "gke-cluster"
  location                 = var.zone
  remove_default_node_pool = true

  initial_node_count = 2

  node_config {
    machine_type = "e2-small"
    disk_type    = "pd-standard"
    disk_size_gb = 20
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  deletion_protection = false

  network    = "default"
  subnetwork = "default"
}
