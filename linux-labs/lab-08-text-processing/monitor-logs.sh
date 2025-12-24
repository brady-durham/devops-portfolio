#!/bin/bash

# Real-time Log Monitor
# Author: Brady Durham
# Date: December 24, 2025

echo "=========================================="
echo "  Real-time Log Monitor"
echo "  Checking for critical events..."
echo "=========================================="
echo ""

# Check for failed SSH attempts
echo "[Security] Checking for failed SSH logins..."
failed_ssh=$(grep -c "Failed password" sample-system.log)
if [ $failed_ssh -gt 0 ]; then
    echo "⚠️  WARNING: $failed_ssh failed SSH login attempts detected!"
    grep "Failed password" sample-system.log | awk '{print "   From IP:", $11}' | sort | uniq -c
else
    echo "✓ No failed SSH attempts"
fi
echo ""

# Check for HTTP errors
echo "[Web] Checking for HTTP errors..."
http_errors=$(awk '$9 >= 400' sample-web-access.log | wc -l)
if [ $http_errors -gt 0 ]; then
    echo "⚠️  WARNING: $http_errors HTTP errors found!"
    awk '$9 >= 400 {print "   "$9, $7}' sample-web-access.log | sort | uniq -c
else
    echo "✓ No HTTP errors"
fi
echo ""

# Check for system crashes
echo "[System] Checking for crashes..."
crashes=$(grep -c -i "crash\|kill\|fail.*exit" sample-system.log)
if [ $crashes -gt 0 ]; then
    echo "⚠️  WARNING: $crashes critical system events detected!"
    grep -i "crash\|kill\|fail.*exit" sample-system.log | sed 's/^/   /'
else
    echo "✓ No system crashes"
fi
echo ""

# Summary
echo "=========================================="
echo "  Monitor Summary"
echo "=========================================="
total_issues=$((failed_ssh + http_errors + crashes))
if [ $total_issues -eq 0 ]; then
    echo "✓ All systems healthy - no issues detected"
else
    echo "⚠️  Total issues found: $total_issues"
    echo ""
    echo "Recommended actions:"
    [ $failed_ssh -gt 0 ] && echo "  • Block attacking IPs with firewall"
    [ $http_errors -gt 0 ] && echo "  • Investigate HTTP errors and fix broken links"
    [ $crashes -gt 0 ] && echo "  • Review system resources and restart failed services"
fi
echo ""
