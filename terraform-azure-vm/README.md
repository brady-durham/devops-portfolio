# Terraform Azure Infrastructure

Infrastructure as Code (IaC) implementation using Terraform to deploy Azure resources.

## Project Overview

This project recreates the same Azure infrastructure from the [Azure CLI automation project](../azure-automation/) using Terraform, demonstrating the benefits of declarative Infrastructure as Code.

---

## Infrastructure Deployed

- **Resource Group:** terraform-lab-rg
- **Virtual Network:** terraform-vnet (10.0.0.0/16)
- **Subnet:** default (10.0.0.0/24)
- **Public IP:** terraform-vm-ip
- **Network Interface:** terraform-vm-nic
- **Virtual Machine:** terraform-vm-01 (Ubuntu 22.04, Standard_B1s)

---

## Azure CLI vs Terraform Comparison

### Azure CLI (Imperative Approach)

**How it works:**
- Write step-by-step bash commands
- Tell Azure exactly what to do and in what order
- Execute commands sequentially

**Characteristics:**
```bash
az group create --name my-rg --location eastus
az network vnet create --resource-group my-rg --name my-vnet
az vm create --resource-group my-rg --name my-vm
```

**Pros:**
- Quick for one-off tasks
- Familiar bash scripting
- Good for learning Azure services

**Cons:**
- Not idempotent (run twice = errors)
- No state tracking
- Difficult to manage changes
- Hard to collaborate
- Manual dependency management

---

### Terraform (Declarative Approach)

**How it works:**
- Describe desired end state
- Terraform figures out how to achieve it
- Manages dependencies automatically

**Characteristics:**
```hcl
resource "azurerm_resource_group" "main" {
  name     = "my-rg"
  location = "eastus"
}

resource "azurerm_virtual_network" "main" {
  name                = "my-vnet"
  resource_group_name = azurerm_resource_group.main.name
}
```

**Pros:**
- Idempotent (run multiple times safely)
- State tracking (knows what exists)
- Preview changes before applying
- Version control friendly
- Team collaboration
- Automatic dependency resolution

**Cons:**
- Learning curve for HCL syntax
- State file management
- Initial setup overhead

---

## Key Terraform Benefits Observed

### 1. Idempotency
Running `terraform apply` multiple times produces same result with no errors. Terraform checks current state and only makes necessary changes.

### 2. Change Management
Modifying infrastructure (like VM size) shows exactly what will change:
```
Plan: 0 to add, 1 to change, 0 to destroy
~ size = "Standard_B1s" -> "Standard_B2s"
```

### 3. State Awareness
Terraform maintains state file tracking all resources, enabling:
- Safe updates
- Dependency management
- Resource drift detection

### 4. Preview Capability
`terraform plan` shows changes before applying - no surprises, no accidental deletions.

---

## Screenshots

**Terraform Configuration Files:**
![Terraform Files](screenshots/Screenshot%20from%202025-12-01%2017-31-09.png)

**Terraform State Output (Part 1):**
![State 1](screenshots/Screenshot%20from%202025-12-01%2017-31-47.png)

**Terraform State Output (Part 2):**
![State 2](screenshots/Screenshot%20from%202025-12-01%2017-33-56.png)

**Terraform State Output (Part 3):**
![State 3](screenshots/Screenshot%20from%202025-12-01%2017-34-20.png)

**Terraform State Output (Part 4):**
![State 4](screenshots/Screenshot%20from%202025-12-01%2017-34-38.png)

**Terraform State Output (Part 5):**
![State 5](screenshots/Screenshot%20from%202025-12-01%2017-34-55.png)

**Azure Portal - Resources Created:**
![Portal 1](screenshots/Screenshot%20from%202025-12-01%2017-35-10.png)

**Azure Portal - Resource Details:**
![Portal 2](screenshots/Screenshot%20from%202025-12-01%2017-35-22.png)

---

## Conclusion

After implementing the same infrastructure with both approaches:

**For one-time deployments:** Azure CLI is faster to write
**For production infrastructure:** Terraform is significantly better due to:
- Repeatability across environments
- Safe change management
- Team collaboration
- Infrastructure versioning

**Terraform's declarative approach treats infrastructure like application code** - version controlled, reviewable, and maintainable.

---

## Files

- `provider.tf` - Azure provider configuration
- `main.tf` - Infrastructure resource definitions
- `.terraform.lock.hcl` - Provider version lock file
- `terraform.tfstate` - Current infrastructure state (not committed to git)

---

**Date Completed:** December 1, 2025
