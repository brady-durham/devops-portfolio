# Linux Networking Basics Lab - Lab 5

**Date:** December 18, 2025
**System:** Ubuntu 24 home lab

## Commands Mastered
- `ip addr show` / `ip a` - view network configuration
- `ip route show` - view routing table
- `ping` - test connectivity
- `nslookup` / `dig` / `host` - DNS lookups
- `ss -tuln` - view listening ports
- `ss -tun | grep ESTAB` - view active connections
- `nc` (netcat) - test port connectivity
- `resolvectl status` - view DNS configuration
- `traceroute` / `mtr` - trace network path

---

## Key Concepts

### Network Configuration
**IP Address:** Unique identifier for your computer on network  
**Gateway:** Router that connects you to internet (default route)  
**DNS:** Converts hostnames (google.com) to IP addresses  
**DHCP:** Automatically assigns IP addresses

### My Network Configuration
- **IP Address:** 10.0.0.158 (assigned via DHCP)
- **Gateway:** 10.0.0.1 (router)
- **Network:** 10.0.0.0/24 (local network range)
- **Interface:** wlp2s0 (WiFi)
- **DNS:** systemd-resolved (127.0.0.53) with upstream through Proton VPN

### Port Numbers
Common ports:
- **22** - SSH (secure remote access)
- **53** - DNS (name resolution)
- **80** - HTTP (web traffic)
- **443** - HTTPS (secure web traffic)
- **631** - CUPS (printing)
- **5353** - mDNS (local network discovery)

---

## Real-World Troubleshooting Workflow

### "Can't Access Internet" - Step-by-Step

**1. Check network interface is up**
```bash
ip link show
```
Result: wlp2s0 is UP

**2. Verify IP address**
```bash
ip addr show
```
Result: 10.0.0.158 assigned via DHCP

**3. Test gateway connectivity**
```bash
ping -c 4 10.0.0.1
```
Result: 4 packets sent, 4 received, 0% loss, avg 3.7ms - ✅ Local network working

**4. Test internet connectivity (bypass DNS)**
```bash
ping -c 4 8.8.8.8
```
Result: 4 packets sent, 4 received, 0% loss, avg 39ms - ✅ Internet working

**5. Test DNS resolution**
```bash
ping -c 4 google.com
```
Result: Resolved to IPv6 address, 0% loss - ✅ DNS working

**6. Check DNS configuration**
```bash
resolvectl status
```
Result: Using Proton VPN DNS servers (10.2.0.1, 2a07:b944::2:1)

**Conclusion:** All network services functioning normally

---

## Network Analysis Results

### Listening Services (ss -tuln)
- **127.0.0.53:53** - systemd-resolved (local DNS cache)
- **192.168.122.1:53** - libvirt DNS for VMs
- **192.168.122.1:67** - DHCP for VMs
- **127.0.0.1:631** - CUPS printing service
- **5353** - mDNS/Avahi (local network discovery)

**Security Assessment:** ✅ Good
- No SSH server exposed (port 22 closed)
- No web servers running (80/443 closed)
- Most services bound to localhost only
- Only VM network services accessible locally

### Active Connections (ss -tun | grep ESTAB)
- **10.2.0.1:65432** - Proton VPN connection
- **Multiple AWS IPs:443** - HTTPS connections (Claude.ai, web browsing)
- **Google IPs:443** - Google services
- **Google:5228** - Push notifications (Google Cloud Messaging)
- **_gateway:67** - DHCP renewal with router

**All traffic encrypted through HTTPS (port 443) and routed through VPN**

---

## Connectivity Tests

### Latency Results
| Target | Average Latency | Notes |
|--------|----------------|-------|
| Gateway (10.0.0.1) | 3.7ms | Local network - excellent |
| Internet (8.8.8.8) | 39ms | Google DNS - normal |
| google.com | 38ms | DNS + connectivity - working |

### Port Connectivity Tests
```bash
# Test HTTPS to Google
nc -zv google.com 443
Result: Connection succeeded ✅

# Test SSH on local machine
nc -zv localhost 22
Result: Connection refused ✅ (no SSH server - expected)
```

---

## DNS Resolution

### DNS Lookup Results
```bash
nslookup google.com
```
**Result:**
- IPv4: 142.250.188.14
- IPv6: 2607:f8b0:4006:804::200e
- DNS Server: 127.0.0.53 (systemd-resolved)
- Upstream: Proton VPN DNS (10.2.0.1)

**System prefers IPv6** when available (modern networking)

---

## Key Learnings

1. **Layered troubleshooting works**: Start local (gateway), then expand (internet), then test DNS
2. **Ping latency interpretation**:
   - <10ms = Local network
   - 10-50ms = Good internet connection
   - >100ms = Slower connection or distant server
3. **Connection refused vs timeout**:
   - Refused = Port closed but host responding (fast)
   - Timeout = Filtered/blocked by firewall (slow)
4. **VPN impact**: Routes all traffic through encrypted tunnel, changes DNS servers
5. **IPv6 adoption**: Modern systems prefer IPv6 over IPv4 when available
6. **Security posture**: Minimal exposed services = good security hygiene

---

## Networking Commands Quick Reference

### Configuration & Status
```bash
ip addr show              # Show IP addresses
ip route show             # Show routing table
ip link show              # Show interface status
resolvectl status         # Show DNS configuration
hostname -I               # Show IP addresses (simple)
```

### Connectivity Testing
```bash
ping -c 4 <host>          # Test connectivity (4 packets)
traceroute <host>         # Show path to destination
mtr <host>                # Interactive traceroute
nc -zv <host> <port>      # Test if port is open
```

### DNS Lookups
```bash
nslookup <hostname>       # Simple DNS lookup
dig <hostname>            # Detailed DNS info
host <hostname>           # Quick DNS lookup
```

### Monitoring
```bash
ss -tuln                  # Show listening ports
ss -tun | grep ESTAB      # Show active connections
netstat -tuln             # Alternative to ss
watch -n 2 'ss -tuln'     # Monitor in real-time
```

---

## Real-World Applications

1. **Azure VM troubleshooting**: Use these commands to diagnose connectivity issues in cloud VMs
2. **Docker networking**: Understand container networking and port mapping
3. **Security auditing**: Identify what services are exposed to network
4. **Performance diagnosis**: Measure latency to identify network bottlenecks
5. **VPN verification**: Confirm traffic is routing through VPN correctly

---

## Network Security Notes

**Current Setup:**
- ✅ VPN active (Proton VPN) - traffic encrypted and IP masked
- ✅ Minimal exposed services - only localhost and VM network
- ✅ No SSH server running - reduces attack surface
- ✅ Firewall can be configured (UFW available)

**Best Practices Observed:**
- Services bound to 127.0.0.1 (localhost only) when possible
- HTTPS used for all web traffic (port 443)
- DNS queries through VPN (privacy)
- No unnecessary open ports

---

## Next Steps
- Practice troubleshooting on other systems/VMs
- Learn about firewall configuration (UFW)
- Explore advanced routing and VLANs
- Set up SSH server for remote access (when needed)
- Learn about network namespaces and Docker networking
