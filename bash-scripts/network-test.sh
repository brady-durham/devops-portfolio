#!/bin/bash

echo "=== Network Connectivity Test ==="
echo ""

HOSTS=("google.com" "github.com" "azure.microsoft.com")

for host in "${HOST[@]}"; do
    if ping -c 1 -W 2 $host &> /dev/null; then
        echo "✓ $host: REACHABLE"
    else
       echo "x $host: UNREACHABLE"
    fi
done

echo ""
echo "== DNS Resolution ==="
nslookup github.com | grep "Address:" | tail -1

