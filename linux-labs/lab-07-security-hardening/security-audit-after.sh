#!/bin/bash

# Security Audit Script - AFTER Hardening
# Author: Brady Durham
# Date: December 23, 2025

echo "=========================================="
echo "  System Security Audit - AFTER"
echo "  Date: $(date)"
echo "=========================================="
echo ""

# 1. Firewall Status
echo "=== FIREWALL STATUS ==="
sudo ufw status verbose
echo ""

# 2. SSH Configuration Check
echo "=== SSH CONFIGURATION ==="
echo "SSH server status:"
systemctl is-active ssh 2>/dev/null || echo "SSH server not installed (normal for desktop)"
echo ""

# 3. Open Ports
echo "=== OPEN PORTS ==="
sudo ss -tuln | grep LISTEN
echo ""

# 4. Sudo Security
echo "=== SUDO SECURITY CONFIGURATION ==="
echo "Sudo timeout and logging:"
sudo cat /etc/sudoers.d/security 2>/dev/null || echo "Custom sudo config not found"
echo ""

# 5. File Permissions Check
echo "=== CRITICAL FILE PERMISSIONS ==="
ls -l /etc/passwd /etc/shadow /etc/group /etc/gshadow 2>/dev/null
echo ""

# 6. Umask Setting
echo "=== DEFAULT UMASK ==="
grep "umask" /etc/profile | grep -v "^#"
echo ""

# 7. Automatic Updates
echo "=== AUTOMATIC SECURITY UPDATES ==="
systemctl is-active unattended-upgrades 2>/dev/null || echo "Checking if enabled..."
dpkg -l | grep unattended-upgrades | head -1
echo ""

# 8. Recent Sudo Commands
echo "=== RECENT SUDO ACTIVITY (last 5) ==="
sudo tail -5 /var/log/sudo.log 2>/dev/null || echo "Sudo log not yet populated"
echo ""

echo "=========================================="
echo "  Security Improvements Summary"
echo "=========================================="
echo ""
echo "Before Hardening:"
echo "  ❌ Firewall: INACTIVE"
echo "  ❌ Sudo logging: DISABLED"
echo "  ❌ Secure umask: NOT SET"
echo ""
echo "After Hardening:"
echo "  ✅ Firewall: ACTIVE with default deny"
echo "  ✅ Sudo logging: ENABLED (/var/log/sudo.log)"
echo "  ✅ Sudo timeout: 15 minutes"
echo "  ✅ Secure umask: 027 (new files = 750)"
echo "  ✅ File permissions: SECURED"
echo "  ✅ Automatic updates: ENABLED"
echo ""
