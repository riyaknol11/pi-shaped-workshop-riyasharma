#!/bin/bash

# Setup script for Terraform remote state
# This script creates a GCS bucket for storing Terraform state

# Configuration
PROJECT_ID="inbound-lexicon-463817-f2"  
BUCKET_NAME="terraform-demo-day4"  
REGION="us-central1"

echo "Setting up Terraform remote state backend..."

# Create the GCS bucket for storing Terraform state
echo "Creating GCS bucket: $BUCKET_NAME"
gsutil mb -p $PROJECT_ID -l $REGION gs://$BUCKET_NAME

# Enable versioning on the bucket
echo "Enabling versioning on bucket: $BUCKET_NAME"
gsutil versioning set on gs://$BUCKET_NAME

# Set up lifecycle policy to clean up old versions
echo "Setting up lifecycle policy..."
cat > lifecycle.json << EOF
{
  "lifecycle": {
    "rule": [
      {
        "action": {"type": "Delete"},
        "condition": {"age": 30, "isLive": false}
      }
    ]
  }
}
EOF

gsutil lifecycle set lifecycle.json gs://$BUCKET_NAME
rm lifecycle.json

echo "Remote state backend setup complete!"
echo "Update backend.tf with bucket name: $BUCKET_NAME"