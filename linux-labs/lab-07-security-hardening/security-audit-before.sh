#!/bin/bash

# Security Audit Script - BEFORE Hardening
# Author: Brady Durham
# Date: December 24, 2024

echo "=========================================="
echo "  System Security Audit - BEFORE"
echo "  Date: $(date)"
echo "=========================================="
echo ""

# 1. Firewall Status
echo "=== FIREWALL STATUS ==="
sudo ufw status verbose
echo ""

# 2. SSH Configuration Check
echo "=== SSH CONFIGURATION ==="
echo "SSH is listening on:"
sudo ss -tlnp | grep sshd
echo ""
echo "Key SSH settings:"
sudo grep -E "^PermitRootLogin|^PasswordAuthentication|^PubkeyAuthentication|^Port" /etc/ssh/sshd_config 2>/dev/null || echo "Unable to read SSH config"
echo ""

# 3. Open Ports
echo "=== OPEN PORTS ==="
sudo ss -tuln | grep LISTEN
echo ""

# 4. World-Writable Files (security risk)
echo "=== CHECKING FOR WORLD-WRITABLE FILES IN /etc ==="
sudo find /etc -type f -perm -002 2>/dev/null | head -10
echo ""

# 5. Users with Empty Passwords
echo "=== USERS WITH EMPTY PASSWORDS ==="
sudo awk -F: '($2 == "") {print $1}' /etc/shadow 2>/dev/null || echo "Unable to check (requires sudo)"
echo ""

# 6. Sudo Configuration
echo "=== SUDO ACCESS ==="
sudo grep -Po '^sudo.+:\K.*$' /etc/group
echo ""

# 7. Failed Login Attempts
echo "=== RECENT FAILED LOGIN ATTEMPTS ==="
sudo grep "Failed password" /var/log/auth.log 2>/dev/null | tail -5 || echo "No recent failed attempts or unable to access log"
echo ""

# 8. Listening Services
echo "=== SERVICES LISTENING ON NETWORK ==="
sudo netstat -tulpn 2>/dev/null | grep LISTEN || ss -tulpn | grep LISTEN
echo ""

echo "=========================================="
echo "  Audit Complete - Review Above"
echo "=========================================="
