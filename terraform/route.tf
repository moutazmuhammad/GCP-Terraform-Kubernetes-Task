# we need to create Cloud Router to advertise routes. 
# It will be used with the NAT gateway to allow VMs without public IP addresses to access the internet

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router
resource "google_compute_router" "router" {
  name    = "router"
  region  = "us-central1"
  network = google_compute_network.vpc_network.id
}