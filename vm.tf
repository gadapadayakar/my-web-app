resource "google_compute_instance" "app_vm" {
  count = var.vm_count

  name  = "${var.environment}-${var.vm_name}-${count.index + 1}"
  zone  = var.zone

  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnetwork_name
    access_config {}
  }

  labels = {
    env = var.environment
    app = var.vm_name
  }
}
