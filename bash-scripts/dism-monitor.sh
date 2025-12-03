#!/bin/bash

echo "=== Disk Space Check ==="
df -h / | grep -v Filesystem

USAGE=$(df -h / | grep -v Filesystem | awk '{print $5}' | sed 's/%//')

if [ $USAGE -gt 80 ]; then
    echo "WARNING: Disk usage above 80%"
else
    echo "OK: Disk usage is ${USAGE}%"
fi
