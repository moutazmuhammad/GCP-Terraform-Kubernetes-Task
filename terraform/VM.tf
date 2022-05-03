# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#nested_network_interface

resource "google_compute_instance" "private" {
  name         = "private"
  machine_type = "e2-small"
  zone         = "us-central1-c"

  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }


  network_interface {
    subnetwork = google_compute_subnetwork.management-private.self_link
  }

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = google_service_account.kubernetes.email
    scopes = ["cloud-platform"]
  }

}