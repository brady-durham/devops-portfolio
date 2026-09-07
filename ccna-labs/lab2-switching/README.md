# Lab 2 – Switching (CCNA Live Accelerated Bootcamp)

## Objective
Build a Layer 2 switched network with VLANs, trunking (manual and dynamic), an LACP EtherChannel, and inter-VLAN routing via router-on-a-stick. Verify connectivity and explore neighbor discovery differences between CDP and LLDP.

## Topology
![Topology](screenshots/01-topology.png)

- **SW1, SW2, SW3**: Layer 2 switches
- **R1**: Router performing inter-VLAN routing (router-on-a-stick)
- **PC1, PC3**: VLAN 10 (IT) — 10.1.1.0/24
- **PC2, PC4**: VLAN 20 (HR) — 20.1.1.0/24

## Configuration Steps

### VLANs and Access Ports (SW1, SW2)
Created VLAN 10 (IT) and VLAN 20 (HR) on both switches, with matching access ports for each connected PC.

### Trunking
- **SW1 ↔ SW2**: Manual trunk on the shared port range, bundled into an LACP EtherChannel (`channel-group 12 mode active` on SW1, `mode passive` on SW2 — SW1 as the active negotiator).
- **SW1 ↔ SW3**: Dynamic trunk via DTP, with SW1 set to `dynamic desirable` (active negotiator) and SW3 set to `dynamic auto` (passive responder).
- **SW2 ↔ SW3**: Same dynamic trunk pattern, SW2 as the active negotiator.
- **SW3 ↔ R1**: Static trunk (`switchport mode trunk`), since R1 doesn't support DTP.

### Router-on-a-Stick (R1)
Configured two sub-interfaces on R1's single physical link to SW3, each tagged for a different VLAN:
- `e0/0.1` — VLAN 10, IP 10.1.1.100/24
- `e0/0.2` — VLAN 20, IP 20.1.1.100/24

### PC Configuration
Set static IPs and default gateways on all four PCs, matching each PC's VLAN to the corresponding R1 sub-interface IP.

## Verification

### EtherChannel Status
`show etherchannel summary` on SW1 confirmed `Po12(SU)` — Layer 2, up, LACP — with both member ports actively bundled.

### Trunk Status
`show interfaces trunk` on SW1 confirmed both the SW1–SW3 dynamic trunk and the SW1–SW2 EtherChannel trunk carrying VLANs 1, 10, and 20.

### Full Connectivity Test
Pinged between all four PCs from PC1 — confirmed both intra-VLAN (PC1 → PC3) and inter-VLAN (PC1 → PC2, PC1 → PC4) reachability through R1's router-on-a-stick.

### Neighbor Discovery: CDP vs. LLDP
- `show cdp neighbor` on SW1 showed **5 entries** — including **two separate entries for SW2** (one per physical port in the EtherChannel, Et0/2 and Et0/3). CDP operates per physical link and isn't aware of logical EtherChannel bundling.
- `show lldp neighbor` on SW2 showed only **1 entry** (SW3) — LLDP wasn't enabled on the PCs, and notably didn't populate over the LACP-bundled link to SW1, unlike CDP. This appears to be an IOS/EVE-NG image quirk with LLDP over EtherChannel member ports rather than a configuration issue, since the EtherChannel and trunk status were both confirmed healthy through other commands.

### MAC Address Table
`show mac address-table` on SW3 confirmed dynamically learned MAC addresses correctly separated by VLAN (1, 10, and 20), learned on the trunk ports — validating that 802.1q tagging was working correctly end-to-end even on a switch with no access ports of its own.

## Key Takeaway
CDP and LLDP, while serving the same basic purpose, differ meaningfully in behavior: CDP is on by default and reports per physical link (surfacing the EtherChannel's individual members), while LLDP must be explicitly enabled and — in this lab — didn't reliably form a neighbor relationship over a bundled LACP link. Worth checking both protocols in real troubleshooting rather than assuming they'll show identical topologies.
