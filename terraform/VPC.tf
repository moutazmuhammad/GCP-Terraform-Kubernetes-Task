
# Before create VPC : You must create compute API 
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"

  disable_dependent_services = true # To make  services that are enabled and which depend on this service should also be disabled when this service is destroyed.
  disable_on_destroy         = true #  Disable the service when the Terraform resource is destroyed
}

# Before create GKE cluster : You must create container API 
resource "google_project_service" "container" {
  service = "container.googleapis.com"

  disable_dependent_services = true
  disable_on_destroy         = true
}


resource "google_compute_network" "vpc_network" {
  project                         = "moutaz-project"
  name                            = "vpc-network"
  auto_create_subnetworks         = false # TO create custom subnets -> this option must be false
  mtu                             = 1460
  delete_default_routes_on_create = false

  depends_on = [ # That is mean : before create VPC : create this req.. 
    google_project_service.compute,
    google_project_service.container
  ]

}