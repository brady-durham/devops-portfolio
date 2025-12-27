#!/bin/bash

# Daily System Report
# Author: Brady Durham

echo "========================================="
echo "  System Report - $(date)"
echo "========================================="
echo ""

echo "=== Disk Usage ==="
df -h / | tail -1 | awk '{print "Root filesystem: " $5 " used"}'
echo ""

echo "=== Memory Usage ==="
free -h | grep Mem | awk '{print "Memory: " $3 " used / " $2 " total"}'
echo ""

echo "=== Top 3 Processes by Memory ==="
ps aux --sort=-%mem | head -4 | tail -3 | awk '{print $11 " - " $4 "%"}'
echo ""

echo "=== System Uptime ==="
uptime
echo ""

echo "========================================="
echo "  Report Complete"
echo "========================================="
