terraform {
  backend "gcs" {
    bucket = "terraform-demo-day4" # Replace with your actual bucket name
    prefix = "terraform/state"
  }
}

# Provider configuration
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
}