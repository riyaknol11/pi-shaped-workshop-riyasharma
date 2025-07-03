resource "google_compute_instance" "vm_instance" {
  name         = "${var.instance_name}-${var.environment}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.disk_size
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    Environment = var.environment
    Owner       = var.owner
  }

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}