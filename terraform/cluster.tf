# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster

resource "google_container_cluster" "primary" {
  name                     = "cluster"
  location                 = "us-central1"
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = google_compute_network.vpc_network.self_link
  subnetwork               = google_compute_subnetwork.restricted-private.self_link
#   networking_mode          = "VPC_NATIVE"

  # Optional, if you want multi-zonal cluster
  node_locations = [
    "us-central1-b"
  ]

  release_channel {  #  upgrades for the Kubernetes control  plane
    channel = "REGULAR"
  }

  # To Make Sure service account inside cluster  Workload Identity 
  # allows Kubernetes service accounts to act as a user-managed Google IAM Service Account.
  workload_identity_config {
    workload_pool = "moutaz-project.svc.id.goog"
  }

  ip_allocation_policy {
    cluster_secondary_range_name  = "k8s-pod-range"
    services_secondary_range_name = "k8s-service-range"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

}
