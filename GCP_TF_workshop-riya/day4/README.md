# Advanced Terraform Exercise: Modules, Remote State, and Workspaces

This project demonstrates advanced Terraform concepts including modularization, remote state management, and workspace usage for managing multiple environments.

## Core Concepts Explained

### 1. Advantages of Terraform Modules in Microservice-Oriented Teams

**Reusability**: Modules allow teams to create standardized infrastructure components that can be reused across different services and environments. A single VM module can be used by multiple microservices without duplicating code.

**Consistency**: Teams can enforce organizational standards and best practices through modules. All VMs created using the same module will have consistent configurations, security settings, and naming conventions.

**Maintainability**: When infrastructure requirements change, updates only need to be made in the module rather than across multiple configurations. This reduces maintenance overhead and the risk of inconsistent updates.

**Collaboration**: Different teams can contribute to and maintain specific modules based on their expertise. The database team can maintain database modules while the networking team maintains network modules.

**Testing**: Modules can be tested independently, making it easier to validate infrastructure changes before they affect production systems.

**Abstraction**: Modules hide complexity from end users. A microservice team can use a complex networking module without needing to understand all the underlying networking configurations.

### 2. How Workspaces Simplify Multi-Environment Deployments

**Environment Isolation**: Workspaces provide complete isolation between environments (dev, staging, prod) using the same configuration code. Each workspace maintains its own state file.

**Reduced Code Duplication**: Instead of maintaining separate Terraform configurations for each environment, workspaces allow you to use the same code with different variable values.

**Simplified Deployment Pipeline**: CI/CD pipelines can easily switch between workspaces to deploy to different environments using the same automation scripts.

**State Management**: Each workspace has its own state file, preventing conflicts between environments and allowing safe parallel deployments.

**Variable Management**: Different environments can use different variable files (dev.tfvars, staging.tfvars) while sharing the same infrastructure code.

**Risk Reduction**: Changes can be tested in dev workspace before promoting to staging and production workspaces.

### 3. Benefits of Remote State Storage in Team Environments

**Collaboration**: Multiple team members can work on the same infrastructure simultaneously without conflicts. Remote state provides a central source of truth.

**Consistency**: All team members see the same state, preventing drift between local and actual infrastructure state.

**Security**: Remote state can be encrypted and access-controlled. Cloud storage services provide better security than local files.

**Backup and Recovery**: Cloud storage services automatically backup state files and provide versioning, reducing the risk of state loss.

**CI/CD Integration**: Automated pipelines can access remote state without requiring state files to be committed to version control.

**Locking**: Remote backends support state locking, preventing concurrent modifications that could corrupt the state.

**Audit Trail**: Remote state storage provides logs of who accessed and modified the state, improving security and compliance.

## Setup Instructions


1. **Set up remote state backend**:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

### 2. Workspace Management

1. **Initialize Terraform**:
   ```bash
   terraform init
   ```

2. **Create and manage workspaces**:
   ```bash
   # Create dev workspace
   terraform workspace new dev
   
   # Create staging workspace
   terraform workspace new staging
   
   # List workspaces
   terraform workspace list
   
   # Switch to dev workspace
   terraform workspace select dev
   ```

![](<screenshots/workspace.png>)



3. **Deploy to different environments**:
   ```bash
   # Deploy to dev
   terraform workspace select dev
   terraform plan -var-file="terraform.tfvars"
   terraform apply -var-file="terraform.tfvars"
   
   # Deploy to staging
   terraform workspace select staging
   terraform plan -var-file="staging.tfvars"
   terraform apply -var-file="staging.tfvars"
   ```
![Deployed to dev](<screenshots/Dev-deployment.png>)
![Deployed to staging](<screenshots/Staging-deployment.png>)
![alt text](<screenshots/Screenshot from 2025-07-03 13-27-20.png>)
![alt text](<screenshots/Screenshot from 2025-07-03 13-27-28.png>)
### 4. Running the Workspace Demo

```bash
chmod +x workspace-demo.sh
./workspace-demo.sh
```

## Module Usage Examples

### VM Module

```hcl
module "web_server" {
  source = "./modules/vm"

  instance_name = "web-server"
  machine_type  = "e2-micro"
  zone          = "us-central1-a"
  environment   = "dev"
  owner         = "dev-team"
  tags          = ["web-server", "terraform"]
}
```

### Storage Module

```hcl
module "app_storage" {
  source = "./modules/storage"

  bucket_name         = "app-data"
  location            = "US"
  environment         = "dev"
  owner               = "dev-team"
  force_destroy       = true
  versioning_enabled  = false
}
```

## Commands Reference

### Workspace Commands

```bash
# Create new workspace
terraform workspace new <workspace-name>

# List workspaces
terraform workspace list

# Show current workspace
terraform workspace show

# Select workspace
terraform workspace select <workspace-name>

# Delete workspace
terraform workspace delete <workspace-name>
```

![alt text](<screenshots/workspace-commands.png>)


