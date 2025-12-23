# Linux Lab 7: System Security Hardening

**Date:** December 23, 2025
## Overview
Implemented comprehensive security hardening techniques for Linux systems, focusing on firewall configuration, sudo security, file permissions, and automated security monitoring.

## Objectives
✅ Configure and manage UFW (Uncomplicated Firewall)  
✅ Implement proper file permissions for security  
✅ Configure sudo security and logging  
✅ Set secure default permissions (umask)  
✅ Enable automatic security updates  
✅ Perform security audits before and after hardening  

## Security Improvements Implemented

### 1. Firewall Configuration (UFW)
**Before:** Firewall inactive - no network protection  
**After:** Active firewall with default deny policy

**Configuration:**
- Default incoming: DENY
- Default outgoing: ALLOW
- SSH (port 22): ALLOWED (to prevent lockout)
- Logging: ENABLED

**Commands Used:**
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw enable
sudo ufw status verbose
```

**Why This Matters:**
Firewalls are the first line of defense against network attacks. Default deny means only explicitly allowed services can receive connections.

---

### 2. Sudo Security Enhancement

**Improvements:**
- ✅ Sudo timeout set to 15 minutes (prevents unlimited sudo access)
- ✅ All sudo commands logged to `/var/log/sudo.log`
- ✅ Audit trail for security compliance

**Configuration File:** `/etc/sudoers.d/security`
```
Defaults timestamp_timeout=15
Defaults logfile="/var/log/sudo.log"
```

**Why This Matters:**
Logging sudo commands creates an audit trail. If a system is compromised, logs show what commands were executed with elevated privileges.

---

### 3. File Permission Hardening

**Critical Files Secured:**
```
/etc/passwd  - 644 (world-readable user database)
/etc/shadow  - 600 (password hashes - root only)
/etc/group   - 644 (group database)
/etc/gshadow - 600 (group passwords - root only)
```

**Why This Matters:**
Password hashes in `/etc/shadow` must be protected. If leaked, attackers can crack passwords offline.

---

### 4. Secure Default Permissions (umask)

**Setting:** `umask 027`

**Result:**
- New files: 640 permissions (owner: rw, group: r, others: none)
- New directories: 750 permissions (owner: rwx, group: rx, others: none)

**Why This Matters:**
Prevents accidentally creating world-readable files containing sensitive data.

---

### 5. Automatic Security Updates

**Status:** ENABLED via `unattended-upgrades`

**Benefits:**
- Critical security patches applied automatically
- Reduces window of vulnerability
- Less manual maintenance required

**Check Status:**
```bash
systemctl status unattended-upgrades
```

---

## Scripts Created

### 1. security-audit-before.sh
Baseline security audit showing system state before hardening.

**Checks Performed:**
- Firewall status
- SSH configuration
- Open network ports
- World-writable files
- Users with empty passwords
- Sudo access
- Failed login attempts
- Listening services

### 2. system-hardening.sh
Automated security hardening implementation.

**Actions Performed:**
- Set secure file permissions
- Configure sudo timeout and logging
- Set secure umask
- Check for insecure network services
- Enable automatic security updates
- Provide recommendations

### 3. security-audit-after.sh
Post-hardening audit showing security improvements.

**Comparison Report:**
- Before/after firewall status
- Sudo security configuration
- File permissions verification
- Security update status
- Recent sudo activity

---

## Defense-in-Depth Strategy

This lab implements multiple layers of security:

**Layer 1 - Network (Firewall)**
- UFW blocks unwanted connections
- Only SSH allowed (desktop system)

**Layer 2 - Access Control (Sudo)**
- Logged and time-limited privileged access
- Audit trail for accountability

**Layer 3 - File System (Permissions)**
- Sensitive files protected from unauthorized access
- Secure defaults prevent accidental exposure

**Layer 4 - Maintenance (Updates)**
- Automated security patching
- Reduced attack surface

---

## Key Concepts Learned

### Firewall Fundamentals
- **Stateful firewall:** Tracks connection state
- **Default deny:** Only explicitly allowed traffic passes
- **Egress filtering:** Control outbound traffic (we allow all)
- **Logging:** Track connection attempts

### Access Control
- **Principle of least privilege:** Users get minimum necessary access
- **Audit logging:** Record privileged operations
- **Timeout policies:** Limit privilege escalation window

### File Security
- **Permissions:** Read, write, execute for owner/group/others
- **Sensitive data protection:** Password hashes must be restricted
- **umask:** Default permissions for new files

### Security Automation
- **Unattended upgrades:** Automatic security patching
- **Monitoring:** Regular security audits
- **Configuration management:** Scripted hardening for consistency

---

## Real-World Applications

### Enterprise Linux Servers
These hardening techniques are **mandatory** for production servers:
- Cloud VMs (AWS EC2, Azure VMs, GCP instances)
- Web servers (nginx, Apache)
- Database servers (MySQL, PostgreSQL)
- Application servers

### Compliance Requirements
Security standards require these controls:
- **PCI-DSS:** Payment card industry security
- **HIPAA:** Healthcare data protection
- **SOC 2:** Service organization controls
- **ISO 27001:** Information security management

### DevOps/Cloud Engineering
**Why This Matters for Your Career:**
- Cloud providers expect hardened VMs
- Infrastructure as Code includes security configuration
- Security is a shared responsibility in cloud
- Demonstrates security-aware engineering

---

## Commands Reference

### Firewall Management
```bash
# Check firewall status
sudo ufw status verbose

# Enable/disable firewall
sudo ufw enable
sudo ufw disable

# Allow a port
sudo ufw allow 80/tcp

# Deny a port
sudo ufw deny 23/tcp

# Delete a rule
sudo ufw delete allow 80/tcp

# Reset firewall (careful!)
sudo ufw reset
```

### Security Auditing
```bash
# Check listening ports
sudo ss -tuln | grep LISTEN
sudo netstat -tuln | grep LISTEN

# Check file permissions
ls -l /etc/passwd /etc/shadow

# View sudo log
sudo tail -f /var/log/sudo.log

# Check failed logins
sudo grep "Failed password" /var/log/auth.log

# List firewall rules
sudo ufw status numbered
```

### System Hardening
```bash
# Check for security updates
sudo apt update
sudo apt list --upgradable

# Apply security updates
sudo unattended-upgrade -d

# Check umask
umask

# Verify automatic updates
systemctl status unattended-upgrades
```

---

## Security Best Practices

### ✅ DO:
- Enable firewall on all systems
- Use SSH keys instead of passwords
- Keep systems updated automatically
- Monitor logs regularly
- Use principle of least privilege
- Document security configurations
- Test changes in non-production first

### ❌ DON'T:
- Disable firewall "temporarily" (it stays off)
- Grant sudo to unnecessary users
- Use weak passwords
- Ignore security updates
- Make world-writable files
- Run services as root unnecessarily
- Allow root login via SSH

---

## Lessons Learned

1. **Security is layered** - No single control protects everything
2. **Automation reduces errors** - Scripts ensure consistent hardening
3. **Logging is essential** - Can't investigate what you don't log
4. **Default deny is powerful** - Explicit allow is safer than explicit deny
5. **Updates matter** - Unpatched systems are easily compromised
6. **Documentation helps** - Future you needs to remember why things are configured

---

## Next Steps & Advanced Topics

### Further Hardening (Optional)
- **fail2ban:** Auto-ban IPs after failed login attempts
- **AppArmor/SELinux:** Mandatory access control
- **Audit daemon:** Detailed system call auditing
- **File integrity monitoring:** Detect unauthorized changes (AIDE, Tripwire)
- **Intrusion detection:** Network-based monitoring (Snort, Suricata)

### Cloud Security
- Security Groups (AWS, Azure, GCP)
- Network ACLs
- IAM roles and policies
- Encryption at rest and in transit
- Key management

### Compliance & Standards
- CIS Benchmarks for Linux hardening
- NIST Cybersecurity Framework
- OWASP security guidelines

---

## Quiz Yourself

Test your understanding:

1. Why use default deny instead of default allow?
2. What happens if you enable UFW without allowing SSH first?
3. Why are password hashes in /etc/shadow instead of /etc/passwd?
4. What does umask 027 mean for new file permissions?
5. Why log sudo commands?

**Answers in your own words = real understanding!**

---

## Skills Demonstrated

### Technical Skills
- Firewall configuration and management
- Linux file permissions and security
- Sudo policy configuration
- Security auditing and logging
- Automated system hardening
- Bash scripting for security

### Security Concepts
- Defense-in-depth strategy
- Principle of least privilege
- Audit logging and accountability
- Security automation
- Compliance requirements awareness

### Professional Skills
- Before/after documentation
- Security-conscious system administration
- Risk assessment
- Change management (test before production)

---

**Status:** Complete  
**Time Investment:** 90 minutes  
**Security Posture:** Significantly improved  
**Practical Value:** Essential for any production Linux system  

---

## Comparison: Before vs After

| Security Control | Before | After |
|-----------------|--------|-------|
| Firewall | Inactive | Active (default deny) |
| Sudo Logging | None | /var/log/sudo.log |
| Sudo Timeout | Unlimited | 15 minutes |
| File Permissions | Default | Hardened (600/644) |
| Default umask | 022 (world-readable) | 027 (secure) |
| Security Updates | Manual | Automatic |
| Audit Capability | Limited | Comprehensive |

**Result:** System transitioned from basic desktop security to hardened configuration suitable for production use.
