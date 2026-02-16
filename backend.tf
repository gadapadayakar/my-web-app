terraform {
  backend "gcs" {
    bucket  = "dayakar-terraform-state"
    prefix  = "dev/terraform/state"
  }
}
