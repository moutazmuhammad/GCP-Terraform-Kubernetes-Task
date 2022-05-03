# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference

# First: From consol : Create project
provider "google" {
  project = "moutaz-project" # project ID
  region  = "us-central1"
}




# https://www.terraform.io/language/settings/backends/gcs

# If you work in project with team you must configure the backend to save the state of code or work in cloud 
# Youmust create bucket with name "backend-gcp-terraform-lab" from consol (change the name if it exists)

terraform {
  backend "gcs" {
    bucket = "backend-gcp-terraform-lab" # this bucket is made manually
    prefix = "terraform/state"
  }
}