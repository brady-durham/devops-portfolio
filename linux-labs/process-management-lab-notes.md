# Linux Process Management Lab - Lab 3

**Date:** December 15, 2025  
**System:** Ubuntu 24 home lab

## Commands Mastered
- `ps aux` - view all processes
- `ps auxf` - view with tree structure
- `top` / `htop` - real-time monitoring
- `kill PID` / `kill -9 PID` - terminate processes
- `pkill process_name` - kill by name
- `jobs`, `bg`, `fg` - job control
- `systemctl` - manage services (start/stop/status/enable)
- `journalctl -u service` - view service logs

---

## Key Concepts

### Process States (STAT column in ps)
- **R** = Running
- **S** = Sleeping (idle, waiting for event)
- **D** = Uninterruptible sleep (usually I/O)
- **Z** = Zombie (finished, waiting for parent cleanup)
- **T** = Stopped/suspended

### Kill Signals
- **SIGTERM (15)** - Default, graceful shutdown (allows cleanup)
- **SIGKILL (9)** - Force kill, immediate termination (no cleanup)
- **SIGHUP (1)** - Reload configuration

**Rule:** Always try `kill PID` first, use `kill -9 PID` only if process won't die.

---

## Real-World Scenarios Practiced

### 1. Finding Resource Hogs
```bash
# Sort by CPU usage
htop (press 'P')

# Sort by memory usage
htop (press 'M')

# Find specific process
ps aux | grep process_name
```

### 2. Background Job Control
**Key sequences:**
- `command &` - Run in background
- `Ctrl+Z` - Suspend foreground process
- `bg` - Resume suspended job in background
- `fg` - Bring background job to foreground
- `Ctrl+C` - Kill foreground process
- `jobs` - List all background jobs
- `kill %1` - Kill job number 1

**Practical use:** When you forget `&` and block your terminal, use Ctrl+Z then `bg`.

### 3. Service Management with systemctl
```bash
# Check service status
systemctl status cron

# Start/stop/restart service
sudo systemctl start cron
sudo systemctl stop cron
sudo systemctl restart cron

# Enable/disable at boot
sudo systemctl enable cron
sudo systemctl disable cron

# Check if enabled
systemctl is-enabled cron

# View service logs
journalctl -u cron --since "10 minutes ago"
journalctl -u cron -f  # follow logs in real-time
```

---

## Troubleshooting Commands Quick Reference

**High CPU usage:**
```bash
htop
# Press 'P' to sort by CPU
# Press F9 to kill, or use: pkill process_name
```

**High memory usage:**
```bash
htop
# Press 'M' to sort by memory
# Identify and kill problematic process
```

**Find all processes by user:**
```bash
ps aux | grep username
```

**Kill all processes matching pattern:**
```bash
pkill -f pattern
pkill process_name
```

**Can't kill a process?**
```bash
# Try force kill
kill -9 PID

# Check if it's owned by another user
ps aux | grep PID
# If owned by root, need: sudo kill -9 PID
```

---

## systemctl Service Management

| Command | Purpose |
|---------|---------|
| `systemctl status SERVICE` | Check if running, view recent logs |
| `sudo systemctl start SERVICE` | Start service now |
| `sudo systemctl stop SERVICE` | Stop service now |
| `sudo systemctl restart SERVICE` | Stop then start |
| `sudo systemctl enable SERVICE` | Start automatically at boot |
| `sudo systemctl disable SERVICE` | Don't start at boot |
| `systemctl is-enabled SERVICE` | Check boot status |
| `systemctl list-units --type=service` | List all services |
| `journalctl -u SERVICE` | View service logs |

---

## Key Learnings

1. **htop > top** - More visual, easier to use, supports mouse
2. **Always try graceful kill first** - Use `kill -9` as last resort
3. **Background jobs save time** - Use `&` and job control
4. **systemctl manages services** - Critical for production systems
5. **journalctl shows logs** - Essential for troubleshooting
6. **Can't kill other users' processes** - Need sudo for root processes

---

## Real-World Applications

1. **Azure VM troubleshooting** - Identify why VM is slow/unresponsive
2. **Docker container management** - Containers are processes with PIDs
3. **Service failures** - Restart hung web servers, databases
4. **Resource optimization** - Kill unnecessary processes eating CPU/memory
5. **Security monitoring** - Identify suspicious processes
6. **Scheduled tasks** - Understanding cron service for automation

---

## Next Steps
- Practice monitoring homelab during normal use
- Set up service monitoring for critical services
- Learn about process nice values for priority management
- Explore systemd timers (modern alternative to cron)
