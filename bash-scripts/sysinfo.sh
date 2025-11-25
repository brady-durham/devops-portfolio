#!/bin/bash
echo "=== System Information ==="
echo "Current User: $(whoami)"
echo "Current Directory: $(pwd)"
echo "Date: $(date +%d%b%Y)"
echo "CPU Model:"
lscpu | grep "Model name"
echo "Running Processes: $(ps aux | wc -l)"
echo "Disk Usage:"
df -h / | grep -v Filesystem
echo "Memory Usage:"
free -h | grep Mem
