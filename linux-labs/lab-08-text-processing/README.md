# Linux Lab 8: Text Processing & Log Analysis

**Date:** December 24, 2025

## Overview
Mastered essential text processing tools (grep, awk, sed) and applied them to real-world log analysis scenarios for security monitoring and system troubleshooting.

## Objectives
✅ Master grep pattern matching and filtering  
✅ Use awk for field extraction and data manipulation  
✅ Apply sed for text transformation  
✅ Analyze real system logs  
✅ Build practical log analysis scripts  
✅ Create automated log monitoring tools  

## Skills Demonstrated

### grep - Pattern Matching
- Basic text search and filtering
- Case-insensitive searches
- Counting occurrences
- Showing context around matches
- Multiple pattern matching (OR searches)
- Inverse matching (exclude patterns)
- Regular expressions

### awk - Data Extraction
- Field extraction from structured text
- Conditional filtering
- Calculations and aggregations
- Counting and sorting
- Traffic analysis
- Bandwidth calculations

### sed - Stream Editing
- Text replacement
- Pattern-based deletion
- Data transformation
- Log sanitization

## Scripts Created

### 1. log-analyzer.sh
Comprehensive log analysis tool that automatically:
- Detects log type (web server vs system logs)
- Provides traffic statistics
- Identifies errors and their sources
- Calculates bandwidth usage
- Finds security threats
- Lists critical system events

**Features:**
- Status code breakdown
- Top IP addresses
- Error analysis with details
- Failed login detection
- Critical event identification

### 2. monitor-logs.sh
Real-time monitoring tool that:
- Checks for failed SSH attempts
- Identifies HTTP errors
- Detects system crashes
- Provides actionable recommendations
- Generates summary reports

**Alerts on:**
- Security incidents (brute force attacks)
- Web application errors
- System failures and crashes

## Real-World Applications

### System Administration
- Security monitoring (failed logins, unauthorized access)
- Performance troubleshooting (slow responses, high traffic)
- Incident investigation (what happened and when)
- Capacity planning (bandwidth usage, request patterns)

### QA/Test Engineering
- Test result analysis (which tests failed)
- Application log parsing (error messages)
- Performance test analysis (response times)
- Deployment validation (success/failure rates)

### DevOps
- Pipeline log analysis
- Deployment verification
- Infrastructure monitoring
- Automated alerting

## Key Findings from Sample Logs

### Security Issues Identified:
- 3 failed SSH login attempts from IP 192.168.1.50 (brute force attack)
- Unauthorized admin.php access attempt (403 error)

### System Issues Identified:
- Out of memory condition (process killed)
- nginx web server crash
- Network link failure

### Web Application Issues:
- Broken login page (404 error)
- API crash (500 error on /api/users)
- Missing resources (404 errors)

## Commands Reference

### grep Examples
```bash
# Find pattern
grep "ERROR" logfile.log

# Case-insensitive
grep -i "error" logfile.log

# Count matches
grep -c "404" access.log

# Show line numbers
grep -n "Failed" auth.log

# Multiple patterns
grep -E "404|500" access.log

# Exclude pattern
grep -v "200" access.log

# Show context (2 lines before/after)
grep -B 2 -A 2 "ERROR" logfile.log
```

### awk Examples
```bash
# Print specific field
awk '{print $1}' logfile.log

# Conditional filtering
awk '$9 >= 400 {print $1, $9}' access.log

# Count occurrences
awk '{print $1}' access.log | sort | uniq -c

# Calculate sum
awk '{sum += $10} END {print sum}' access.log

# Multiple fields
awk '{print $1, $9, $7}' access.log
```

### sed Examples
```bash
# Replace text
sed 's/old/new/g' file.txt

# Delete matching lines
sed '/pattern/d' file.txt

# Extract specific data
sed 's/ .*//' file.txt
```

### Combined Pipelines
```bash
# Top 10 IPs by request count
awk '{print $1}' access.log | sort | uniq -c | sort -nr | head -10

# Find and count error types
grep "ERROR" app.log | awk '{print $5}' | sort | uniq -c

# Security audit
grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -nr
```

## Use Cases by Role

### System Administrator
- Monitor failed login attempts daily
- Analyze traffic patterns for capacity planning
- Investigate service failures
- Track bandwidth usage
- Identify security threats

### QA Engineer  
- Parse test execution logs
- Find failed test cases
- Extract error messages
- Analyze performance test results
- Validate deployment logs

### DevOps Engineer
- Monitor CI/CD pipeline logs
- Verify deployment success
- Track infrastructure changes
- Alert on failures
- Generate status reports

## Lessons Learned

1. **Pattern matching is powerful** - grep can find specific issues in millions of log lines instantly
2. **Structured data extraction matters** - awk makes analyzing formatted logs trivial
3. **Automation saves time** - Scripts can monitor 24/7 and alert on issues
4. **Context is important** - Showing lines around matches helps understand problems
5. **Combining tools is key** - Pipes let you build powerful analysis workflows

## Industry Relevance

**These skills are essential for:**
- Every system administrator role
- DevOps and SRE positions
- QA and test automation engineers
- Security operations analysts
- Any role involving troubleshooting

**Companies expect you to:**
- Analyze logs efficiently
- Find root causes quickly
- Automate monitoring
- Provide actionable insights

## Next Steps

**To build on this lab:**
- Learn regular expressions in depth
- Practice with real production logs
- Add email alerting to monitoring scripts
- Integrate with log aggregation tools (ELK, Splunk)
- Create dashboards from log data

---
**Status:** Complete  
**Time Investment:** 90 minutes  
**Practical Value:** Extremely high - used daily in production  
**Career Relevance:** Essential skill for sysadmin and QA roles
