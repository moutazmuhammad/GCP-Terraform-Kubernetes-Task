# It is recommended that node pools be created and managed as separate 
# resources as in the example. This allows node pools to be added 
# and removed without recreating the cluster.

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_node_pool

resource "google_container_node_pool" "node-pool" {
  name       = "node-pool"
  cluster    = google_container_cluster.primary.id
  node_count = 3

  node_config {
    preemptible  = false
    machine_type = "e2-small"

    labels = {
      role = "nodepool"
    }

    service_account = google_service_account.kubernetes.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
