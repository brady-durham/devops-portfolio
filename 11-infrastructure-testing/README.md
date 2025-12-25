# Project 11: Infrastructure Testing Suite

**Date:** December 25, 2025

## Overview
Automated infrastructure validation suite that tests Azure VM status, web server availability, and security configuration. Demonstrates testing mindset and infrastructure validation skills applicable to QA and system administration roles.

## Objectives
- Validate Azure infrastructure components automatically
- Test VM availability and status
- Verify web server functionality
- Check firewall security configuration
- Generate professional test reports
- Demonstrate QA/testing approach to infrastructure

## Technologies Used
- Bash scripting
- Azure CLI
- curl (web server testing)
- UFW firewall commands
- Automated testing logic

## Components
- `infra-test.sh` - Main infrastructure test suite
- `test-results/` - Test execution reports
- Sample test outputs and documentation

## Test Coverage
1. **Azure VM Status Test** - Verify VM is running
2. **Web Server Availability Test** - Check HTTP response
3. **Firewall Configuration Test** - Validate security rules
4. **Overall Health Report** - Pass/fail summary

## Skills Demonstrated
- Infrastructure testing and validation
- Automated health checks
- Security verification
- Professional test reporting
- QA mindset applied to infrastructure

## Test Results

**Latest Test Run:** December 25, 2024

### Summary
- **Total Tests:** 8
- **Passed:** 7 ✓
- **Failed:** 1 ✗

### Test Breakdown

#### ✓ Passing Tests
1. Azure CLI Installation - Verified Azure tooling available
2. Firewall Status - UFW active and protecting system
3. Firewall SSH Rule - Port 22 properly configured
4. Disk Space - System storage healthy (< 90% used)
5. Memory Available - Sufficient RAM available (> 100MB free)
6. Internet Connectivity - Network connection verified
7. DNS Resolution - Name resolution working

#### ✗ Failed Tests
1. Localhost Web Server Response - No web server currently running on localhost
   - **Note:** Expected failure - no local web service configured
   - **Impact:** None - test validates monitoring capability

### Interpretation

The infrastructure test suite successfully validates:
- System health and resource availability
- Security configuration (firewall active with proper rules)
- Network connectivity and DNS resolution
- Azure tooling availability

The single failed test (localhost web server) is expected behavior as no web server is configured to run locally. This test demonstrates the monitoring capability and would pass in environments with local web services.

---
**Status:** Complete  
**Test Coverage:** 8 automated infrastructure checks  
**Pass Rate:** 87.5% (7/8 tests passing as expected)
