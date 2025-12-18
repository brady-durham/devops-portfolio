# Linux Disk Management Lab - Lab 4

**Date:** December 18, 2025  
**System:** Ubuntu 24 home lab

## Commands Mastered
- `df -h` - view disk space by filesystem
- `du -sh` - check directory sizes
- `du -h | sort -h` - find largest directories
- `find` - locate large files
- `lsblk` - view block devices and partitions
- `mount` - show mounted filesystems
- Real-world troubleshooting workflow

---

## Key Concepts

### Disk Space Monitoring
**`df` (disk free)** - Shows filesystem-level usage
- `-h` = human readable (GB, MB)
- `-T` = show filesystem type
- `-i` = show inode usage

**`du` (disk usage)** - Shows directory/file sizes
- `-s` = summary only
- `-h` = human readable
- `--max-depth=1` = only show one level deep

### Finding Space Hogs
```bash
# Find biggest directories
sudo du -h / --max-depth=1 2>/dev/null | sort -h | tail -10

# Find large files
find / -type f -size +1G 2>/dev/null

# Check specific directory
sudo du -h /var --max-depth=1 | sort -h
```

---

## Real-World Scenario Practiced

### "Server Out of Space" Investigation

**Step-by-step troubleshooting workflow:**

1. **Check overall disk usage**
```bash
   df -h
```
   Result: 95GB used / 439GB total (22% - healthy)

2. **Find biggest directories**
```bash
   sudo du -h / --max-depth=1 2>/dev/null | sort -h | tail -10
```
   Found: /home (46GB), /var (37GB), /snap (23GB)

3. **Investigate /var subdirectories**
```bash
   sudo du -h /var --max-depth=1 | sort -h | tail -10
```
   Found: /var/lib (30GB - normal), /var/log (6.8GB - manageable)

4. **Conclusion:** System has healthy disk usage, no action needed

---

## Disk Space Management Commands

### Checking Space
| Command | Purpose |
|---------|---------|
| `df -h` | Show filesystem usage |
| `df -h /` | Show usage of root filesystem |
| `du -sh ~` | Show size of home directory |
| `du -h ~ \| sort -h` | List directories by size |
| `lsblk` | Show all disks and partitions |

### Finding Large Files/Directories
```bash
# Find files larger than 100MB
find ~ -type f -size +100M -exec ls -lh {} \;

# Find files larger than 1GB
sudo find / -type f -size +1G 2>/dev/null

# Show biggest subdirectories
sudo du -h /var --max-depth=1 | sort -h | tail -10
```

### Cleanup Commands (Use with Caution)
```bash
# Clean apt package cache
sudo apt clean

# Remove old systemd journal logs (keep last 30 days)
sudo journalctl --vacuum-time=30d

# Find and list old log files
find /var/log -type f -name "*.log" -mtime +30
```

---

## Lab Exercises Completed

### Created Test Files
- Used `dd` to create files of specific sizes (10MB, 50MB, 100MB)
- Created multiple 20MB files in a loop
- Total: 260MB of test data

### Monitored Space Usage
- Used `watch` to monitor disk space in real-time
- Observed space increase as files were created
- Verified space recovery after cleanup

### Analyzed Real System Usage
- Identified that /home uses 46GB (projects, VMs)
- Found /var using 37GB (mostly /var/lib with system data)
- Confirmed /var/log at 6.8GB (normal for active system)
- Overall system health: 22% used, 322GB available

---

## Key Learnings

1. **df vs du**: `df` shows filesystem-level usage, `du` shows directory/file sizes
2. **Sorting is essential**: `sort -h` makes output readable by size
3. **2>/dev/null**: Hides permission errors when scanning system directories
4. **Common space hogs**: /var/log (logs), /var/cache (packages), /home (user data)
5. **Normal usage patterns**: /var/lib contains Docker, databases, VM data - size is expected
6. **Troubleshooting workflow**: Start broad (df), narrow down (du by directory), find culprit

---

## Real-World Applications

1. **Azure VM management**: Monitor disk usage to prevent "disk full" errors
2. **Docker environments**: /var/lib/docker can grow large with images/containers
3. **Log management**: Rotate/clean logs to prevent /var/log from filling disk
4. **Backup planning**: Know which directories are largest for backup strategies
5. **Cost optimization**: Right-size disk allocations based on actual usage patterns

---

## System Analysis Results

**Current System Status:**
- Total disk: 439GB
- Used: 95GB (22%)
- Available: 322GB (73%)
- **Health: Excellent** - plenty of space remaining

**Largest directories:**
- /home: 46GB (user data, projects)
- /var: 37GB (system data, logs)
- /snap: 23GB (snap packages)

**Recommendation:** No cleanup needed, system is healthy

---

## Next Steps
- Practice these commands on other systems
- Set up automated disk monitoring (future lab)
- Learn about LVM and disk partitioning (advanced)
- Explore Docker volume management
