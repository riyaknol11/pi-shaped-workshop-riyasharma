## Day 1: GCP Fundamentals - Compute, Storage & Networking
### Project Overview
This assignment demonstrates the creation and configuration of core GCP services including Compute Engine, Cloud Storage, and VPC networking.

## Resources Created
### 1. Compute Engine VM Instance

Machine Type: e2-micro
Region/Zone: us-central1-a
OS: Ubuntu 20.04 LTS
Purpose: Demonstrates basic compute infrastructure setup

![VM-Instance-Creation
](<VM-instance.png>)



### 2. Cloud Storage Bucket

Name: day1-storage-bucket-[project-id]
Location: us-central1
Storage Class: Standard
Purpose: Object storage for application data and backups



![Google-Storage-Bucket
](<Storage-Bucket.png>)


### 3. Custom VPC Network

Name: day1-vpc
Subnets Created:

Web Tier: day1-subnet-web (10.0.1.0/24)
Database Tier: day1-subnet-db (10.0.2.0/24)


Purpose: Network isolation and security segmentation


![VPC Network](<VPC-Network-subnets.png>)



### VPC Config Diagram

![](<Vpc-config.png>)


## Component Interactions and Purposes

 1. VM Instance: VM Instance deployed in the web subnet, can access the internet and communicate with other resources in the VPC.
 2. Cloud Storage: Provides persistent storage that can be accessed by the VM instance for data storage and backup.
 3. VPC Subnets: Enable network segmentation between different application tiers (web and database).



## Setup Instructions
``` 

1.  Create VM Instance

Navigate to Compute Engine > VM instances
Click "Create Instance"
Configure with settings listed above
Enable HTTP/HTTPS traffic in firewall settings
Click "Create"

2.  Create Cloud Storage Bucket

Navigate to Cloud Storage > Buckets
Click "Create Bucket"
Configure with globally unique name
Upload a test file
Verify file appears in bucket

3. Configure Custom VPC

Navigate to VPC network > VPC networks
Click "Create VPC Network"
Set to "Custom" subnet creation mode
Add two subnets with specified IP ranges
Click "Create"

```

## Core Concept Questions & Answers

### 1. Why would a startup choose GCP over other providers for compute and storage?
> Cost Advantages:
Per-second billing: Pay only for compute time used, not rounded up to full hours
Free Tier: $300 credit for new accounts plus always-free resources

> Technical Benefits:

Google's Infrastructure: Built on the same infrastructure as Google Search, Gmail, YouTube
Fast Global Network: Google's private fiber network for low latency
Strong Data Analytics: BigQuery, Cloud ML, and data processing tools

> Startup-Friendly Features:

Easy Scaling: Simple auto-scaling without complex configuration
Managed Services: Less operational overhead with Cloud SQL, Cloud Functions, etc.
Developer Tools: Integrated with popular development workflows
Global Reach: Easy deployment across multiple regions

### 2. What are the advantages of using VPCs over default networking?

> Security Benefits:

Network Isolation: Custom VPCs provide complete isolation from other projects
Subnet Segmentation: Separate different application tiers (web, app, database)
Custom Firewall Rules: Granular control over traffic between subnets
Private IP Ranges: Control over internal IP addressing schemes

> Operational Advantages:

Multi-Region Deployment: Single VPC can span multiple regions
Subnet-Level Control: Different subnets can have different configurations
Peering Capabilities: Connect to on-premises networks or other VPCs
Network Planning: Predictable IP ranges for integration with existing infrastructure

> Default Network Limitations includes:

Shared Address Space: Uses predefined IP ranges that may conflict
Less Flexibility: Cannot customize network topology
Limited Control: Fewer options for traffic management and security policies
Auto-Created Subnets: Less control over subnet placement and sizing


### 3. How do GCP regions and zones impact performance and availability in global apps?


> Performance Impact:

Latency Reduction: Deploy close to users to minimize round-trip time
Network Speed: Intra-region communication is faster than inter-region
Data Locality: Keep data close to compute resources to reduce data transfer time
CDN Integration: Use Cloud CDN with regional deployments for content delivery

> Availability Strategies:

Zone Redundancy: Deploy across multiple zones in a region for high availability
Regional Backup: Use multiple regions for disaster recovery
Automatic Failover: Load balancers can route traffic away from failed zones
Data Replication: Cloud Storage and databases can replicate across zones/regions

> Global Application Architecture:

Multi-Regional Deployment: Serve users from nearest region
Global Load Balancing: Distribute traffic based on proximity and health
Data Consistency: Consider eventual consistency for globally distributed data
Compliance: Meet data residency requirements by choosing appropriate regions

