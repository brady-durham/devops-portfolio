#!/bin/bash

# System Hardening Script
# Author: Brady Durham
# Date: December 23, 2025

echo "=========================================="
echo "  System Security Hardening"
echo "  Date: $(date)"
echo "=========================================="
echo ""

# Check if running as root/sudo
if [ "$EUID" -ne 0 ]; then 
    echo "Please run with sudo: sudo ./system-hardening.sh"
    exit 1
fi

echo "[+] Starting security hardening..."
echo ""

# 1. Set proper permissions on sensitive files
echo "[+] Setting secure permissions on critical files..."
chmod 600 /etc/ssh/ssh_host_*_key 2>/dev/null || echo "  SSH keys not found (normal for desktop)"
chmod 644 /etc/passwd
chmod 644 /etc/group
chmod 600 /etc/shadow
chmod 600 /etc/gshadow
echo "  ✓ File permissions secured"
echo ""

# 2. Disable unused network services (if any)
echo "[+] Checking for unnecessary network services..."
# List services that could be disabled (informational)
systemctl list-units --type=service --state=running | grep -E "telnet|ftp|rsh|rlogin" || echo "  ✓ No insecure services detected"
echo ""

# 3. Configure sudo timeout and logging
echo "[+] Configuring sudo security..."
if ! grep -q "timestamp_timeout" /etc/sudoers; then
    echo "Defaults timestamp_timeout=15" >> /etc/sudoers.d/security
    echo "  ✓ Sudo timeout set to 15 minutes"
else
    echo "  ✓ Sudo timeout already configured"
fi

if ! grep -q "logfile" /etc/sudoers; then
    echo "Defaults logfile=\"/var/log/sudo.log\"" >> /etc/sudoers.d/security
    echo "  ✓ Sudo logging enabled"
else
    echo "  ✓ Sudo logging already configured"
fi
echo ""

# 4. Set secure umask
echo "[+] Setting secure default umask..."
if ! grep -q "umask 027" /etc/profile; then
    echo "umask 027" >> /etc/profile
    echo "  ✓ Secure umask configured (new files will be 750)"
else
    echo "  ✓ Umask already configured"
fi
echo ""

# 5. Disable IPv6 if not needed (optional)
echo "[+] IPv6 status check..."
if sysctl net.ipv6.conf.all.disable_ipv6 | grep -q "= 0"; then
    echo "  IPv6 is enabled (this is fine for most systems)"
    read -p "  Disable IPv6? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
        echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
        sysctl -p
        echo "  ✓ IPv6 disabled"
    fi
else
    echo "  ✓ IPv6 already disabled"
fi
echo ""

# 6. Enable automatic security updates
echo "[+] Checking automatic security updates..."
if dpkg -l | grep -q unattended-upgrades; then
    echo "  ✓ Automatic updates already installed"
else
    echo "  Installing unattended-upgrades..."
    apt-get install -y unattended-upgrades
    dpkg-reconfigure -plow unattended-upgrades
    echo "  ✓ Automatic security updates enabled"
fi
echo ""

# 7. Set password policies
echo "[+] Checking password policies..."
if ! grep -q "PASS_MIN_DAYS" /etc/login.defs | grep -v "^#"; then
    echo "  Password policies could be strengthened"
    echo "  Review /etc/login.defs and /etc/pam.d/common-password"
else
    echo "  ✓ Password policies configured"
fi
echo ""

echo "=========================================="
echo "  Hardening Complete!"
echo "=========================================="
echo ""
echo "Summary of changes:"
echo "  ✓ File permissions secured"
echo "  ✓ Sudo security configured"
echo "  ✓ Secure umask set"
echo "  ✓ Security updates configured"
echo ""
echo "Recommended next steps:"
echo "  1. Review /var/log/sudo.log regularly"
echo "  2. Monitor firewall logs: sudo ufw status verbose"
echo "  3. Check for updates: sudo apt update && sudo apt upgrade"
echo "  4. Review security audit periodically"
echo ""
