# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/google_service_account

# service account for instance
resource "google_service_account" "kubernetes" {
  account_id = "kubernetes"
}

# role to access cluster and container
resource "google_project_iam_binding" "Cluster"{
    project = "moutaz-project"
    role = "roles/container.admin"
    members=[
      "serviceAccount:kubernetes@moutaz-project.iam.gserviceaccount.com",
      ]
    depends_on = [google_service_account.kubernetes]
}

# role to access  container registory storage
resource "google_project_iam_binding" "storage"{
    project = "moutaz-project"
    role = "roles/storage.admin"
    members=[
      "serviceAccount:kubernetes@moutaz-project.iam.gserviceaccount.com",
      ]
    depends_on = [google_service_account.kubernetes]
}