
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork

# This subnet will contain private VM and Nat       
resource "google_compute_subnetwork" "management-private" {
  name                     = "management"
  ip_cidr_range            = "10.0.3.0/24"
  region                   = "us-central1"
  network                  = google_compute_network.vpc_network.id
}

# This subnet will contain private GKE
resource "google_compute_subnetwork" "restricted-private" {
  name                     = "restricted"
  ip_cidr_range            = "10.0.0.0/24"
  region                   = "us-central1"
  network                  = google_compute_network.vpc_network.id

  secondary_ip_range {   # For Pods of cluster
    range_name    = "k8s-pod-range"
    ip_cidr_range = "10.48.0.0/16"
  }
  secondary_ip_range {
    range_name    = "k8s-service-range"
    ip_cidr_range = "10.52.0.0/26"
  }

}