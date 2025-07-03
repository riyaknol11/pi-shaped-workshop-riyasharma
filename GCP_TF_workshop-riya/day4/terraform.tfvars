# Development Environment Configuration
project_id  = "inbound-lexicon-463817-f2"
region      = "us-central1"
environment = "dev"
owner       = "dev-team"

# VM Configuration for Dev
vm_instance_name = "web-server"
vm_machine_type  = "e2-micro"
vm_zone          = "us-central1-a"
vm_tags          = ["web-server", "terraform", "dev"]

# Storage Configuration for Dev
storage_bucket_name         = "app-data"
storage_location            = "US"
storage_force_destroy       = true   # Allow destruction in dev
storage_versioning_enabled  = false  # Disable versioning in dev
storage_lifecycle_age       = 7      # Shorter lifecycle in dev