resource "google_storage_bucket" "bucket" {
  name          = "${var.bucket_name}-${var.environment}-${random_id.bucket_suffix.hex}"
  location      = var.location
  force_destroy = var.force_destroy

  uniform_bucket_level_access = true

  versioning {
    enabled = var.versioning_enabled
  }

  lifecycle_rule {
    condition {
      age = var.lifecycle_age
    }
    action {
      type = "Delete"
    }
  }

  labels = {
    environment = var.environment
    owner       = var.owner
  }
}

resource "random_id" "bucket_suffix" {
  byte_length = 8
}