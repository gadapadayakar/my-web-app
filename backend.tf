terraform {
  backend "gcs" {
    bucket  = "monitoring-482610-tf-state"
    prefix  = "dev/terraform/state"
  }
}
