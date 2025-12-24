#!/bin/bash

# Log Analysis Tool
# Author: Brady Durham
# Date: December 24, 2025

LOG_FILE=$1

if [ -z "$LOG_FILE" ]; then
    echo "Usage: $0 <log-file>"
    exit 1
fi

if [ ! -f "$LOG_FILE" ]; then
    echo "Error: File $LOG_FILE not found"
    exit 1
fi

echo "=========================================="
echo "  Log Analysis Report"
echo "  File: $LOG_FILE"
echo "  Generated: $(date)"
echo "=========================================="
echo ""

# Determine log type
if grep -q "HTTP" "$LOG_FILE"; then
    echo "=== WEB SERVER LOG ANALYSIS ==="
    echo ""
    
    # Total requests
    total=$(wc -l < "$LOG_FILE")
    echo "Total requests: $total"
    echo ""
    
    # Status code breakdown
    echo "Status Code Summary:"
    awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -rn
    echo ""
    
    # Top 5 IPs
    echo "Top 5 Most Active IPs:"
    awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -rn | head -5
    echo ""
    
    # Error analysis
    echo "Error Analysis (4xx and 5xx):"
    error_count=$(awk '$9 >= 400' "$LOG_FILE" | wc -l)
    echo "Total errors: $error_count"
    if [ $error_count -gt 0 ]; then
        echo ""
        echo "Error details:"
        awk '$9 >= 400 {print "  "$1, "→", $9, $7}' "$LOG_FILE"
    fi
    echo ""
    
    # Bandwidth analysis
    total_bytes=$(awk '{sum += $10} END {print sum}' "$LOG_FILE")
    echo "Total bandwidth: $total_bytes bytes (~$((total_bytes / 1024)) KB)"
    echo ""
    
elif grep -q "sshd\|systemd\|kernel" "$LOG_FILE"; then
    echo "=== SYSTEM LOG ANALYSIS ==="
    echo ""
    
    # Failed login attempts
    failed_logins=$(grep -c "Failed password" "$LOG_FILE")
    echo "Failed SSH login attempts: $failed_logins"
    
    if [ $failed_logins -gt 0 ]; then
        echo ""
        echo "Attack sources:"
        grep "Failed password" "$LOG_FILE" | awk '{print $11}' | sort | uniq -c | sort -rn
    fi
    echo ""
    
    # Critical events
    echo "Critical Events:"
    grep -i "error\|fail\|crash\|kill\|down" "$LOG_FILE" | sed 's/^/  /'
    echo ""
    
    # Service status
    echo "Service Events:"
    grep "systemd" "$LOG_FILE" | sed 's/^/  /'
    echo ""
    
else
    echo "=== GENERIC LOG ANALYSIS ==="
    echo ""
    echo "Total lines: $(wc -l < "$LOG_FILE")"
    echo ""
    echo "Pattern frequency:"
    grep -o -i "error\|warning\|info\|failed\|success" "$LOG_FILE" | sort | uniq -c | sort -rn
    echo ""
fi

echo "=========================================="
echo "  Analysis Complete"
echo "=========================================="
