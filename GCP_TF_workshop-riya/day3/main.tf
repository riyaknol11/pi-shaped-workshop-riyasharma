# Configure the Google Cloud Provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

# Random string for unique resource naming
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

# Create a VPC network
resource "google_compute_network" "vpc_network" {
  name                    = "${var.project_name}-vpc"
  auto_create_subnetworks = false
  description             = "VPC network for ${var.project_name}"
}

# Create a subnet
resource "google_compute_subnetwork" "subnet" {
  name          = "${var.project_name}-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  description   = "Subnet for ${var.project_name}"
}

# Create a firewall rule to allow SSH, HTTP, and HTTPS
resource "google_compute_firewall" "firewall" {
  name        = "${var.project_name}-firewall"
  network     = google_compute_network.vpc_network.name
  description = "Allow HTTP, HTTPS, and SSH traffic"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["web-server"]
}

# Get the latest Ubuntu 22.04 LTS image
data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

# Create a Compute Engine instance
resource "google_compute_instance" "vm_instance" {
  name         = "${var.project_name}-vm"
  machine_type = var.machine_type
  zone         = var.zone
  tags         = ["web-server"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu.self_link
      size  = 20
      type  = "pd-standard"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.subnet.name
    
    access_config {
      # Ephemeral public IP
    }
  }

  metadata = {
    startup-script = <<-EOF
      #!/bin/bash
      apt-get update
      apt-get install -y nginx
      systemctl start nginx
      systemctl enable nginx
      echo "<h1>Hello from Terraform!</h1>" > /var/www/html/index.html
      echo "<p>Instance: ${var.project_name}-vm</p>" >> /var/www/html/index.html
      echo "<p>Created on: $(date)</p>" >> /var/www/html/index.html
    EOF
  }

  service_account {
    scopes = ["cloud-platform"]
  }

  # Allow stopping for updates
  allow_stopping_for_update = true

  # Labels for resource management
  labels = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}

# Create a Cloud Storage bucket
resource "google_storage_bucket" "storage_bucket" {
  name          = "${var.project_name}-terraform-bucket-${random_string.bucket_suffix.result}"
  location      = var.region
  force_destroy = true

  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }

  labels = {
    environment = var.environment
    project     = var.project_name
    managed_by  = "terraform"
  }
}

# Upload a sample file to the bucket
resource "google_storage_bucket_object" "sample_file" {
  name   = "sample.txt"
  bucket = google_storage_bucket.storage_bucket.name
  content = <<-EOF
    This is a sample file created by Terraform!
    Project: ${var.project_name}
    Bucket: ${google_storage_bucket.storage_bucket.name}
    Created: ${timestamp()}
  EOF
}