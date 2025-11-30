# Azure Automation Projects

Infrastructure automation using Azure CLI and bash scripting.

---

## Project 1: Automated VM Deployment

**Objective:** Automate Azure virtual machine deployment using CLI scripting

**Script:** `create-vm.sh`

### What It Does:
- Creates Azure resource group
- Configures virtual network (10.0.0.0/16)
- Creates subnet (10.0.0.0/24)
- Deploys Ubuntu 22.04 VM
- Generates SSH keys automatically
- Assigns public IP address

### Infrastructure Created:
- **Resource Group:** devops-lab-rg
- **Virtual Network:** devops-vnet
- **VM:** ubuntu-vm-01 (Standard_B1s)
- **OS:** Ubuntu Server 22.04 LTS

### Skills Demonstrated:
- Azure CLI automation
- Infrastructure as Code concepts
- Bash scripting for cloud deployments
- Network configuration
- Resource management

### Screenshots:

**Script Execution - Part 1:**
![Resource Group Creation](screenshots/Screenshot%20from%202025-11-30%2007-12-08.png)

**Script Execution - Part 2:**
![Virtual Network Creation](screenshots/Screenshot%20from%202025-11-30%2007-12-26.png)

**VM Deployment Success:**
![VM Running](screenshots/Screenshot%20from%202025-11-30%2007-12-35.png)

### Date Completed:
November 30, 2025
