# Azure Lab 1: Linux VM Deployment

**Date:** December 28, 2025

## Objective
Deploy and configure an Ubuntu VM in Azure with SSH access and basic security.

## Steps Completed
1. Generated SSH key pair locally using `ssh-keygen`
2. Created Ubuntu 22.04 LTS VM (Standard_B1s) via Azure Portal
3. Configured resource group: `rg-lab-vms`
4. Set up SSH key-based authentication
5. Configured Network Security Group for SSH access (port 22)
6. Successfully connected via SSH to public IP: 48.214.108.246
7. Verified VM functionality with system commands
8. Stopped VM to prevent charges

## Key Learnings
- Azure Portal navigation for VM deployment
- SSH key-based authentication configuration
- Network Security Groups (NSGs) for firewall rules
- Resource group organization
- Cost management (stopping/deallocating VMs)

## Resources Created
- **Resource Group:** rg-lab-vms
- **VM Name:** vm-ubuntu-lab01
- **Region:** East US 2
- **Size:** Standard_B1s (1 vCPU, 1 GB RAM)
- **OS:** Ubuntu Server 22.04 LTS
- **Public IP:** 48.214.108.246
- **Virtual Network:** rg-lab-vms-vnet

## Commands Used
```bash
# Generate SSH keys
ssh-keygen -t rsa -b 4096 -C "brady-azure-lab"

# Connect to VM
ssh azureuser@48.214.108.246

# Verify system
uname -a
free -h
cat test-file.txt
```

## Next Steps
- Lab 2: Custom Virtual Network configuration
- Lab 3: VM monitoring and management
