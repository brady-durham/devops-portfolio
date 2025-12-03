#!/bin/bash

echo "=== Service Status Check - $(date) ==="
echo ""

SERVICES=("docker" "ssh" "cron")

for service in "${SERVICES[@]}"; do
    if systemctl is-active --quiet $service; then
        echo "✓ $service: RUNNING"
    else
        echo "✗ $service: STOPPED"
    fi
done

echo ""
echo "=== System Uptime ==="
uptime -p

