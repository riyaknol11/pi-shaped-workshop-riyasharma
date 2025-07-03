variable "instance_name" {
  description = "Name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "Machine type for the VM"
  type        = string
  default     = "e2-micro"
}

variable "zone" {
  description = "Zone where the VM will be created"
  type        = string
  default     = "us-central1-a"
}

variable "image" {
  description = "Boot disk image"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 10
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "owner" {
  description = "Owner of the resource"
  type        = string
  default     = "terraform-user"
}

variable "tags" {
  description = "Tags to assign to the instance"
  type        = list(string)
  default     = []
}