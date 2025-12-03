#!/bin/bash

TOTAL=$(ps aux | wc -l)
USER_PROC=$(ps aux | grep $USER | wc -l)

echo "=== Process Summary ==="
echo "Total processes: $TOTAL"
echo "Your processes: $USER_PROC"
echo "Top 5 memory users:"
ps aux --sort=-%mem | head -6 | tail -5
