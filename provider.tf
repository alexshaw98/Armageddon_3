terraform {
  required_providers {
    google  = {
    source  = "hashicorp/google"
    version = "5.25.0"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-container-vm:cos-coredns/v1.0.0"
  }

  provider_meta "google-beta" {
    module_name = "blueprints/terraform/terraform-google-container-vm:cos-coredns/v1.0.0"
  }

}

provider "google" {
  # Configuration options
  project     = "armageddon-homework"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "armageddon-homework-ae37d8f26327.json" 
}


# Path: output.tf
data "google_project" "current" {
}
