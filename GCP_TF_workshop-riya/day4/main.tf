# VM Module Usage
module "web_server" {
  source = "./modules/vm"

  instance_name = var.vm_instance_name
  machine_type  = var.vm_machine_type
  zone          = var.vm_zone
  environment   = var.environment
  owner         = var.owner
  tags          = var.vm_tags
}

# Storage Module Usage
module "app_storage" {
  source = "./modules/storage"

  bucket_name         = var.storage_bucket_name
  location            = var.storage_location
  environment         = var.environment
  owner               = var.owner
  force_destroy       = var.storage_force_destroy
  versioning_enabled  = var.storage_versioning_enabled
  lifecycle_age       = var.storage_lifecycle_age
}