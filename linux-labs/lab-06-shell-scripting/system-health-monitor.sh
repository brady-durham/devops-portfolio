#!/bin/bash

# System Health Monitor Script
# Author: Brady Durham
# Date: December 23, 2024
# Purpose: Monitor system health metrics and generate report

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print section headers
print_header() {
    echo -e "\n${GREEN}========================================${NC}"
    echo -e "${GREEN}$1${NC}"
    echo -e "${GREEN}========================================${NC}\n"
}

# Function to check if value exceeds threshold
check_threshold() {
    local value=$1
    local threshold=$2
    local name=$3
    
    if (( $(echo "$value > $threshold" | bc -l) )); then
        echo -e "${RED}WARNING: $name is at ${value}% (threshold: ${threshold}%)${NC}"
        return 1
    else
        echo -e "${GREEN}OK: $name is at ${value}%${NC}"
        return 0
    fi
}

# Main script starts here
clear
print_header "System Health Check - $(date)"

# 1. System Uptime
print_header "SYSTEM UPTIME"
uptime -p
echo "System booted: $(uptime -s)"

# 2. CPU Usage
print_header "CPU USAGE"
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d'%' -f1)
echo "Current CPU usage: ${cpu_usage}%"
check_threshold "$cpu_usage" "80" "CPU"

# 3. Memory Usage
print_header "MEMORY USAGE"
mem_info=$(free | grep Mem)
total_mem=$(echo $mem_info | awk '{print $2}')
used_mem=$(echo $mem_info | awk '{print $3}')
mem_percent=$(echo "scale=2; ($used_mem / $total_mem) * 100" | bc)

echo "Memory: ${used_mem} / ${total_mem} KB (${mem_percent}%)"
check_threshold "$mem_percent" "85" "Memory"

# 4. Disk Usage
print_header "DISK USAGE"
df -h / | tail -n 1
disk_percent=$(df / | tail -n 1 | awk '{print $5}' | cut -d'%' -f1)
check_threshold "$disk_percent" "80" "Disk"

# 5. Network Status
print_header "NETWORK STATUS"
echo "Active network interfaces:"
ip -brief addr show | grep UP

echo -e "\nInternet connectivity test:"
if ping -c 1 8.8.8.8 &> /dev/null; then
    echo -e "${GREEN}✓ Internet connection: OK${NC}"
else
    echo -e "${RED}✗ Internet connection: FAILED${NC}"
fi

# 6. System Services (top 5 by memory)
print_header "TOP 5 SERVICES BY MEMORY"
ps aux --sort=-%mem | head -n 6 | awk '{printf "%-10s %-8s %-8s %s\n", $1, $2, $4"%", $11}'

# 7. Failed Login Attempts (if available)
print_header "SECURITY CHECK"
if [ -f /var/log/auth.log ]; then
    failed_logins=$(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)
    echo "Failed login attempts (since last rotation): $failed_logins"
    if [ $failed_logins -gt 10 ]; then
        echo -e "${YELLOW}Note: High number of failed login attempts detected${NC}"
    fi
else
    echo "Auth log not accessible (run with sudo for security checks)"
fi

# 8. System Load Average
print_header "LOAD AVERAGE"
load=$(uptime | awk -F'load average:' '{print $2}')
echo "Load average (1/5/15 min):$load"

# Summary
print_header "HEALTH CHECK COMPLETE"
echo "Report generated at: $(date)"
echo "Next recommended check: $(date -d '+1 hour' '+%Y-%m-%d %H:%M:%S')"
