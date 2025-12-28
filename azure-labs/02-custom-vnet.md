# Azure Lab 2: Custom Virtual Network

**Date:** December 28, 2025

## Objective
Create a custom virtual network with multiple subnets and deploy a VM into a specific subnet.

## Network Design
- **VNet:** vnet-lab-custom (10.1.0.0/16)
- **Subnet:** 10.1.0.0/24 (deployed subnet)
- **Additional subnet:** 10.1.2.0/24 (reserved for future use)

## Steps Completed
1. Created custom VNet with 10.1.0.0/16 address space
2. Configured subnets for network segmentation
3. Deployed Ubuntu VM (vm-web-lab02) into custom network
4. Verified network configuration via SSH
5. Confirmed private IP assignment (10.1.0.4)
6. Stopped VM to prevent charges

## Key Learnings
- VNet address space planning (CIDR notation)
- Subnet segmentation for security and organization
- Network isolation concepts
- Private vs public IP addressing
- VM network interface configuration
- Azure networking fundamentals

## Resources Created
- **Virtual Network:** vnet-lab-custom
- **Address Space:** 10.1.0.0/16
- **Subnets:** 10.1.0.0/24, 10.1.2.0/24
- **VM:** vm-web-lab02
- **Private IP:** 10.1.0.4 (assigned from subnet)
- **Public IP:** 40.79.39.242

## Commands Used
```bash
# Connect to VM
ssh azureuser@40.79.39.242

# Verify network configuration
ip addr show eth0
# Output: inet 10.1.0.4/24

# Check routing table
ip route
# Shows gateway at 10.1.0.1

# Test file creation
echo "Custom VNet Lab - $(date)" > vnet-test.txt
cat vnet-test.txt
```

## Network Configuration Details
- **Subnet CIDR:** 10.1.0.0/24 (256 IP addresses)
- **VM Private IP:** 10.1.0.4
- **Default Gateway:** 10.1.0.1
- **Network Security Group:** Basic (SSH port 22 allowed)

## Next Steps
- Lab 3: VM monitoring and management
- Deploy additional VMs into different subnets
- Configure network peering between VNets
