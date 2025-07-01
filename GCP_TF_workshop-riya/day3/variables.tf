# Project Configuration
variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "inbound-lexicon-463817-f2"
}

variable "project_name" {
  description = "Name prefix for resources"
  type        = string
  default     = "terraform-demo"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a"
}

# VM Configuration
variable "machine_type" {
  description = "The machine type for the VM instance"
  type        = string
  default     = "e2-micro"
}

variable "vm_image" {
  description = "The image for the VM instance"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

# SSH Configuration
variable "ssh_user" {
  description = "SSH username"
  type        = string
  default     = "terraform-user"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub" 
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}