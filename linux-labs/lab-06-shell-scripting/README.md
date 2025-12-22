# Linux Lab 6: Shell Scripting & Automation

**Date:** December 22, 2025

## Overview
Created practical shell scripts for system administration tasks, building on Labs 1-5 (user management, permissions, processes, disk management, and networking).

## Objectives
✅ Write bash scripts for common sysadmin tasks  
✅ Implement error handling and logging  
✅ Create automated monitoring and reporting tools  
✅ Practice script permissions and execution  

## Scripts Created

### 1. system-health-monitor.sh
Comprehensive system health monitoring with color-coded output:
- CPU usage tracking with thresholds
- Memory usage analysis
- Disk space monitoring
- Network connectivity testing
- Service health checks
- Security audit (failed login attempts)
- Load average reporting

**Key Features:**
- Color-coded warnings (red/yellow/green)
- Threshold-based alerts
- Real-time system metrics
- Internet connectivity verification

### 2. backup-tool.sh
Automated backup solution for important directories:
- Compressed tar.gz backups with timestamps
- Automatic old backup cleanup (keeps last 5)
- Source directory verification
- Backup size reporting
- Optional backup verification

**Key Features:**
- Smart file compression
- Timestamp naming convention
- Automatic rotation policy
- User-friendly progress reporting

### 3. user-activity-report.sh
Detailed user account analysis and reporting:
- Currently logged-in users
- All system accounts listing
- Group membership analysis
- Home directory disk usage
- Last login tracking
- Sudo privilege reporting
- Password status checking

**Key Features:**
- Comprehensive user information
- Security-focused reporting
- Disk usage per user
- Group membership tracking

### 4. log-analyzer.sh
System log analysis for troubleshooting:
- Boot information
- Kernel message scanning
- Systemd journal error detection
- Failed service identification
- Disk space warnings
- Memory pressure alerts
- Package update history
- Authentication summary
- Network status verification

**Key Features:**
- Multi-source log analysis
- Automated issue detection
- Color-coded severity levels
- Security audit capabilities

## Skills Demonstrated

### Bash Scripting Fundamentals
- Shebang and script structure
- Variables and string manipulation
- Command substitution
- Input/output redirection

### Control Flow
- Conditional statements (if/else)
- For loops for iteration
- Case statements
- Function definitions

### System Integration
- System command integration (df, du, ps, systemctl)
- File system operations
- Process management
- Log file parsing

### Error Handling
- Exit codes and status checking
- Error message formatting
- Graceful failure handling
- User feedback

### Best Practices
- Color-coded output for clarity
- Modular function design
- Clear variable naming
- Comprehensive commenting
- Proper file permissions (chmod +x)

## Real-World Applications

These scripts demonstrate practical sysadmin skills used daily in DevOps/Cloud Engineering:

1. **Monitoring:** Automated health checks prevent outages
2. **Backup:** Regular backups protect against data loss
3. **Auditing:** User activity tracking for security compliance
4. **Troubleshooting:** Log analysis speeds up incident response

## Technical Concepts Covered

- **Shell scripting syntax:** Variables, loops, conditionals
- **Color codes:** ANSI escape sequences for terminal output
- **Text processing:** grep, awk, sed for data extraction
- **System monitoring:** CPU, memory, disk, network metrics
- **Log management:** Reading and analyzing system logs
- **File operations:** Creation, compression, cleanup
- **User management:** Account info, permissions, groups
- **Error handling:** Threshold checking, status codes

## Commands and Tools Used
```bash
# System monitoring
top, free, df, du, uptime, ps, systemctl

# Networking
ping, ss, ip

# Text processing
grep, awk, sed, cut, tr

# File operations
tar, find, ls, du

# User management
who, lastlog, passwd, groups

# Log analysis
dmesg, journalctl, tail

# Arithmetic
bc (for floating-point calculations)
```

## Execution Examples
```bash
# Health monitoring
./system-health-monitor.sh

# Create backup
./backup-tool.sh

# User activity report
./user-activity-report.sh

# Analyze system logs
./log-analyzer.sh
```

## Future Enhancements

- Add email notifications for critical alerts
- Implement cron job scheduling for automated execution
- Create CSV export for reporting
- Add more sophisticated log parsing
- Integrate with monitoring systems (Prometheus, Grafana)
- Add remote server monitoring capability

## Lessons Learned

1. **Color coding improves usability** - Makes output more readable and actionable
2. **Functions promote code reuse** - Modular design simplifies maintenance
3. **Error checking is essential** - Prevents script failures and provides better UX
4. **Documentation matters** - Clear output messages help users understand results
5. **Automation saves time** - Manual tasks become one-command operations

---
**Status:** Complete  
**Skills:** Bash scripting, system monitoring, automation, log analysis  
**Time Investment:** 90 minutes  
**Practical Value:** High - Scripts usable in real production environments
