# General Variables
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "owner" {
  description = "Owner of the resources"
  type        = string
  default     = "terraform-user"
}

# VM Variables
variable "vm_instance_name" {
  description = "Name of the VM instance"
  type        = string
  default     = "web-server"
}

variable "vm_machine_type" {
  description = "Machine type for the VM"
  type        = string
  default     = "e2-micro"
}

variable "vm_zone" {
  description = "Zone where the VM will be created"
  type        = string
  default     = "us-central1-a"
}

variable "vm_tags" {
  description = "Tags to assign to the VM instance"
  type        = list(string)
  default     = ["web-server", "terraform"]
}

# Storage Variables
variable "storage_bucket_name" {
  description = "Name of the storage bucket"
  type        = string
  default     = "app-data"
}

variable "storage_location" {
  description = "Location of the bucket"
  type        = string
  default     = "US"
}

variable "storage_force_destroy" {
  description = "Allow deletion of non-empty bucket"
  type        = bool
  default     = false
}

variable "storage_versioning_enabled" {
  description = "Enable versioning on the bucket"
  type        = bool
  default     = true
}

variable "storage_lifecycle_age" {
  description = "Age in days after which objects are deleted"
  type        = number
  default     = 30
}