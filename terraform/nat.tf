
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_router_nat

resource "google_compute_router_nat" "nat" {
  name   = "nat"
  router = google_compute_router.router.name
  region = "us-central1"

  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS" # A list of Subnetworks are allowed to Nat (specified in the field subnetwork below)
  subnetwork {
    name                    = google_compute_subnetwork.management-private.id
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  nat_ip_allocate_option = "MANUAL_ONLY" # Since we will  allocate External IP addresses ourselves, we need to provide them in the nat_ips field
  nat_ips                = [google_compute_address.nat.self_link]
}



# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_address

# The following resource is to allocate IP.
resource "google_compute_address" "nat" {
  name         = "nat"
  address_type = "EXTERNAL"
  network_tier = "PREMIUM"

  depends_on = [google_project_service.compute]
}