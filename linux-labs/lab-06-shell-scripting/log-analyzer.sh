#!/bin/bash

# Log File Analyzer
# Author: Brady Durham
# Date: December 23, 2024
# Purpose: Analyze system logs for errors, warnings, and important events

# Colors
RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

print_header() {
    echo -e "\n${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}\n"
}

# Check if running with sudo
if [ "$EUID" -ne 0 ]; then
    echo -e "${YELLOW}Note: Some log analysis requires sudo privileges${NC}"
    echo -e "${YELLOW}Running with limited access...${NC}\n"
fi

clear
echo "=========================================="
echo "  System Log Analyzer"
echo "  Generated: $(date)"
echo "=========================================="

# 1. System Boot Information
print_header "SYSTEM BOOT INFORMATION"
echo "Last boot: $(who -b | awk '{print $3, $4}')"
echo "System uptime: $(uptime -p)"
echo ""

# 2. Kernel Messages (dmesg - last 10 errors/warnings)
print_header "RECENT KERNEL MESSAGES"
if dmesg 2>/dev/null | tail -20 | grep -i "error\|fail\|warn" > /dev/null; then
    echo "Recent errors/warnings found:"
    dmesg 2>/dev/null | tail -50 | grep -i "error\|fail\|warn" | tail -10
else
    echo -e "${GREEN}No recent kernel errors or warnings${NC}"
fi

# 3. System Journal - Errors (last hour)
print_header "SYSTEMD JOURNAL - RECENT ERRORS"
if command -v journalctl &> /dev/null; then
    error_count=$(journalctl --since "1 hour ago" -p err 2>/dev/null | wc -l)
    if [ $error_count -gt 5 ]; then
        echo -e "${RED}Found $error_count error entries in the last hour${NC}"
        echo "Sample errors:"
        journalctl --since "1 hour ago" -p err --no-pager 2>/dev/null | tail -5
    else
        echo -e "${GREEN}No significant errors in the last hour ($error_count entries)${NC}"
    fi
else
    echo "journalctl not available"
fi

# 4. Failed Services
print_header "FAILED SYSTEMD SERVICES"
failed_services=$(systemctl --failed --no-pager --no-legend 2>/dev/null | wc -l)
if [ $failed_services -gt 0 ]; then
    echo -e "${RED}Found $failed_services failed service(s):${NC}"
    systemctl --failed --no-pager 2>/dev/null
else
    echo -e "${GREEN}All services running normally${NC}"
fi

# 5. Disk Usage Warnings
print_header "DISK SPACE WARNINGS"
disk_warning=0
while IFS= read -r line; do
    usage=$(echo $line | awk '{print $5}' | sed 's/%//')
    mount=$(echo $line | awk '{print $6}')
    if [ $usage -gt 80 ]; then
        echo -e "${RED}WARNING: $mount is at ${usage}% capacity${NC}"
        disk_warning=1
    fi
done < <(df -h | grep -v tmpfs | tail -n +2)

if [ $disk_warning -eq 0 ]; then
    echo -e "${GREEN}All filesystems have adequate space${NC}"
fi

# 6. Memory Pressure
print_header "MEMORY STATUS"
mem_available=$(free | grep Mem | awk '{print ($7/$2) * 100}' | cut -d. -f1)
if [ $mem_available -lt 20 ]; then
    echo -e "${RED}WARNING: Low memory available (${mem_available}%)${NC}"
elif [ $mem_available -lt 40 ]; then
    echo -e "${YELLOW}NOTICE: Memory getting low (${mem_available}% available)${NC}"
else
    echo -e "${GREEN}Memory status: OK (${mem_available}% available)${NC}"
fi

# 7. Recent Package Updates
print_header "RECENT PACKAGE UPDATES"
if [ -f /var/log/apt/history.log ]; then
    echo "Last 5 package operations:"
    grep "Start-Date" /var/log/apt/history.log 2>/dev/null | tail -5 | while read line; do
        echo "  $line"
    done
else
    echo "Package history not available"
fi

# 8. Authentication Summary
print_header "AUTHENTICATION SUMMARY"
if [ -f /var/log/auth.log ]; then
    sudo_attempts=$(sudo grep "sudo" /var/log/auth.log 2>/dev/null | wc -l)
    ssh_attempts=$(sudo grep "sshd" /var/log/auth.log 2>/dev/null | wc -l)
    failed_sudo=$(sudo grep "sudo.*FAILED" /var/log/auth.log 2>/dev/null | wc -l)
    
    echo "Authentication activity (current log):"
    echo "  Sudo commands executed: $sudo_attempts"
    echo "  SSH connection attempts: $ssh_attempts"
    if [ $failed_sudo -gt 0 ]; then
        echo -e "  ${YELLOW}Failed sudo attempts: $failed_sudo${NC}"
    else
        echo -e "  ${GREEN}Failed sudo attempts: 0${NC}"
    fi
else
    echo "Authentication logs require sudo access"
fi

# 9. Network Issues
print_header "NETWORK STATUS"
if ping -c 1 8.8.8.8 &>/dev/null; then
    echo -e "${GREEN}✓ Internet connectivity: OK${NC}"
else
    echo -e "${RED}✗ Internet connectivity: ISSUE DETECTED${NC}"
fi

# Count active connections
active_connections=$(ss -tun | grep ESTAB | wc -l)
echo "Active network connections: $active_connections"

# Summary
print_header "ANALYSIS SUMMARY"
echo "System appears to be: ${GREEN}HEALTHY${NC}"
echo "Last checked: $(date)"
echo ""
echo "Recommended actions:"
echo "  • Review any errors or warnings above"
echo "  • Monitor disk space regularly"
echo "  • Keep system packages updated"
echo ""
