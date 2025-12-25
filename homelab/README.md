# Homelab Environment

## Overview
Personal lab environment for practicing system administration, virtualization, and infrastructure management. Used for hands-on learning, testing configurations, and developing skills applicable to production IT environments.

## Hardware

### Dell Precision T5400 Workstation
- **Role:** ESXi Virtualization Host
- **CPU:** Dual Intel Xeon (specs TBD)
- **RAM:** TBD GB DDR2 ECC
- **Storage:** TBD
- **Network:** Gigabit Ethernet (hardwired)
- **Hypervisor:** VMware ESXi (installed by mentor from Vanderbilt Medical Center)

## Purpose

This homelab serves as a learning environment for:
- **Linux System Administration** - Hands-on practice with server management
- **Virtualization** - Understanding VM creation, configuration, and management
- **Networking** - Virtual network configuration and troubleshooting
- **Azure Concept Practice** - Testing cloud concepts locally before deploying to Azure
- **Infrastructure as Code** - Testing Terraform and automation scripts
- **QA/Testing** - Creating test environments for validation work

## Current Configuration

**Status:** Being reconfigured (January 2026)  
**Hypervisor:** VMware ESXi  
**Management:** Web-based vSphere interface  
**Location:** Home office (den) - hardwired ethernet connection  

### Planned Virtual Machines
- Ubuntu Server 24.04 LTS (Linux administration practice)
- Rocky Linux (RHEL-compatible learning)
- Test VMs for project validation
- Development/testing environments

## Use Cases

### System Administration Practice
- User and group management
- Service configuration and monitoring
- Security hardening implementation
- Log analysis and troubleshooting
- Backup and recovery procedures

### Azure Certification Preparation (AZ-900)
- Understanding virtualization concepts
- Virtual networking fundamentals
- Resource management
- Cost optimization (practice locally before cloud deployment)

### Infrastructure Testing
- Test automation scripts before production use
- Validate Infrastructure as Code configurations
- Create reproducible test environments
- Practice disaster recovery scenarios

### QA Skill Development
- Building test environments
- Infrastructure validation
- Automated testing workflows
- Environment consistency verification

## Learning Approach

**Iterative Development:**
1. Learn concept (documentation, courses, labs)
2. Test in homelab (safe environment)
3. Document findings
4. Apply to cloud/production when ready

**Cost Savings:**
- Practice Azure concepts locally (free)
- Test before deploying to cloud (save credits)
- Break things without consequences
- Unlimited experimentation

## Future Enhancements

**Planned additions:**
- [ ] Document full hardware specifications after setup
- [ ] Configure initial Ubuntu Server VM
- [ ] Set up virtual networking
- [ ] Implement Infrastructure as Code for VM deployment
- [ ] Create automated backup solution
- [ ] Build monitoring and alerting system
- [ ] Practice disaster recovery scenarios

## Mentorship

Homelab setup and configuration assistance provided by enterprise system administrator at Vanderbilt University Medical Center, bringing professional best practices to personal learning environment.

## Skills Demonstrated

- **Initiative:** Self-directed learning with personal lab investment
- **Practical Experience:** Hands-on infrastructure management
- **Professional Approach:** Enterprise-grade tools and practices
- **Cost Consciousness:** Testing locally before cloud deployment
- **Continuous Learning:** Dedicated environment for skill development

---

**Status:** In Setup - Hardware acquired, ESXi installed, reconfiguration scheduled January 2026  
**Documentation:** Will be updated as VMs are deployed and configurations tested  
**Integration:** Used alongside Azure cloud projects for comprehensive infrastructure learning
