# Azure Lab 3: VM Management & Cost Control

**Date:** December 28, 2025

## Objective
Practice VM lifecycle management and understand cost control through proper resource management.

## Steps Completed
1. Reviewed VM management interface in Azure Portal
2. Verified all VMs are properly stopped to prevent charges
3. Learned VM state management (Running vs Stopped vs Deallocated)

## Key Learnings
- **VM States:**
  - Running: Actively charged for compute resources
  - Stopped (deallocated): Minimal charges (storage only)
  - Proper shutdown prevents unnecessary costs
  
- **Resource Management:**
  - Always stop VMs when not in use
  - Deallocated state releases compute resources
  - Storage costs continue (~$0.05/month per disk)

- **Azure Portal Navigation:**
  - Virtual Machines dashboard shows all VMs at a glance
  - Status indicators show current VM state
  - Easy start/stop controls for cost management

## Current VM Inventory
- **vm-ubuntu-lab01:** Stopped (Lab 1 - Basic VM deployment)
- **vm-web-lab02:** Stopped (Lab 2 - Custom VNet deployment)
- **vm-webserver:** Stopped (Previous lab/project)

All VMs properly deallocated to minimize costs.

## Best Practices Learned
1. Stop VMs immediately after completing labs
2. Verify "deallocated" status (not just "stopped")
3. Use VM list view to check status of all resources
4. Keep VMs organized with clear naming conventions

## Total Labs Completed Today
- Lab 1: Linux VM with SSH authentication
- Lab 2: Custom Virtual Network deployment
- Lab 3: VM management and cost control

## Next Steps
- Continue Azure fundamentals practice
- Preview Zero to Linux course for RHCSA prep
- Plan January 2026 AZ-900 certification timeline
