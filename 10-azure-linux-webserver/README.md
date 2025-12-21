# Project 10: Azure Linux Web Server Deployment

## Overview
Deployed and configured a production-ready Linux web server on Azure, demonstrating cloud infrastructure management and Linux system administration skills.

## Live Demo
**Public URL:** http://172.203.133.238

## Objectives
✅ Deploy Ubuntu VM in Azure using Azure CLI  
✅ Configure networking and security groups  
✅ Set up Nginx web server  
✅ Implement proper user management and permissions  
✅ Configure firewall rules  
✅ Deploy a custom web application  
✅ Create monitoring scripts  

## Technologies Used
- **Cloud Platform:** Azure (Virtual Machines, VNet, NSG, Public IP)
- **Operating System:** Ubuntu 22.04 LTS
- **Web Server:** Nginx
- **Tools:** Azure CLI, Bash scripting
- **Skills:** Linux system administration, networking, security configuration

## Architecture

### Network Configuration
- **Resource Group:** rg-linux-webserver
- **Virtual Network:** vnet-webserver (10.0.0.0/16)
- **Subnet:** subnet-webserver (10.0.1.0/24)
- **VM Size:** Standard_B1s
- **Public IP:** 172.203.133.238
- **Private IP:** 10.0.1.4

### Security Configuration
- **Network Security Group:** nsg-webserver
  - Inbound Rule: SSH (port 22) - Priority 1000
  - Inbound Rule: HTTP (port 80) - Priority 1001
- **SSH Authentication:** Key-based authentication
- **Web Server Security Headers:** X-Frame-Options, X-Content-Type-Options, X-XSS-Protection

## Implementation Steps

### 1. Infrastructure Setup
Created Azure resources using Azure CLI:
- Resource group in East US region
- Virtual network with dedicated subnet
- Network security group with firewall rules
- Ubuntu 22.04 LTS virtual machine

### 2. Web Server Configuration
- Installed and configured Nginx
- Created dedicated webappuser with proper permissions
- Deployed custom HTML application
- Configured Nginx virtual host
- Implemented security headers

### 3. System Administration
- User management: Created webappuser with restricted permissions
- File permissions: Set 755 on web directory
- Service management: Configured systemd services
- Monitoring: Created health check script

### 4. Monitoring Script
Created `/home/webappuser/server-health.sh` to monitor:
- Nginx service status
- Disk usage
- Memory usage
- CPU load
- Active network connections

## Key Commands Used
```bash
# Azure infrastructure
az group create --name rg-linux-webserver --location eastus
az network vnet create --resource-group rg-linux-webserver --name vnet-webserver
az network nsg create --resource-group rg-linux-webserver --name nsg-webserver
az vm create --resource-group rg-linux-webserver --name vm-webserver --image Ubuntu2204

# Linux system administration
sudo useradd -m -s /bin/bash webappuser
sudo chown -R webappuser:webappuser /var/www/portfolio-site
sudo chmod -R 755 /var/www/portfolio-site
sudo systemctl status nginx
sudo nginx -t
```

## Skills Demonstrated

### Cloud Infrastructure
- Azure CLI automation
- Virtual network configuration
- Network security group management
- VM deployment and configuration

### Linux System Administration
- User and group management
- File permissions and ownership
- Systemd service management
- Log file analysis
- Bash scripting for monitoring

### Web Server Management
- Nginx installation and configuration
- Virtual host setup
- Security header implementation
- SSL-ready configuration

## Lessons Learned
- Importance of proper user permissions for security
- Network security group rules must be configured before VM access
- Systemd service management is essential for production environments
- Monitoring scripts help maintain server health
- Azure CLI provides efficient infrastructure automation

## Future Enhancements
- Implement SSL/TLS with Let's Encrypt certificate
- Add automated backup scripts
- Configure log rotation
- Implement fail2ban for SSH protection
- Add application-level monitoring
- Create Terraform configuration for infrastructure as code

## Cleanup Instructions
To avoid Azure charges, delete resources when done:
```bash
az group delete --name rg-linux-webserver --yes --no-wait
```

---
**Status:** Complete  
**Date Started:** December 21, 2025  
**Date Completed:** December 21, 2025  
**Portfolio:** [github.com/brady-durham/devops-portfolio](https://github.com/brady-durham/devops-portfolio)






