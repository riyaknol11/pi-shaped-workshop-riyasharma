# Staging Environment Configuration
project_id  = "inbound-lexicon-463817-f2"
region      = "us-central1"
environment = "staging"
owner       = "staging-team"

# VM Configuration for Staging
vm_instance_name = "web-server"
vm_machine_type  = "e2-standard-2"
vm_zone          = "us-central1-b"
vm_tags          = ["web-server", "terraform", "staging"]

# Storage Configuration for Staging
storage_bucket_name         = "app-data"
storage_location            = "US"
storage_force_destroy       = false  
storage_versioning_enabled  = true   # This Enables versioning in staging
storage_lifecycle_age       = 30     