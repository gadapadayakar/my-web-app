terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }

  backend "gcs" {
    bucket  = "dayakar-terraform-state"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project = "my-data-488509"
  region  = "asia-south1"
}
