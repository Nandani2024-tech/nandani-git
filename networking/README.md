# Networking Homework Tasks

This directory contains the completed homework and practical command execution for the **DevOps Networking** module.

---

## 📋 Task Overview

| Task | Description | Status |
| :--- | :--- | :--- |
| **Task 1** | Practice commands and study networking concepts shared in the DevOps Hero repository (`iam-veeramalla/a-to-z-of-networking`). | ✅ Completed |
| **Task 2** | Create a Markdown (`.md`) file, execute essential networking commands, record real terminal output, and explain the understanding of each command. | ✅ Completed |

---

## 🚀 Task 1: DevOps Hero Networking Practice & Core Concepts

In this task, we reviewed and practiced the networking foundations documented in the **DevOps Hero** repository ([`iam-veeramalla/a-to-z-of-networking`](https://github.com/iam-veeramalla/a-to-z-of-networking) and DevOps Zero-to-Hero curriculum). 

### 1. The OSI vs. TCP/IP Models
Networking relies on layered abstraction models to transfer data across physical and virtual infrastructures:
- **Application Layer (Layer 7):** Protocols like HTTP, HTTPS, SSH, DNS, and FTP. Applications and microservices communicate here.
- **Transport Layer (Layer 4):** TCP (connection-oriented, reliable, 3-way handshake) and UDP (connectionless, low-latency streaming/DNS). Handles ports (e.g., port `80`, `443`, `3306`).
- **Network / Internet Layer (Layer 3):** IP addressing, packet routing, ICMP (`ping`), and routing protocols (OSPF, BGP). Packets move between different networks.
- **Data Link Layer (Layer 2):** MAC addresses, ethernet frames, switches, and ARP (`Address Resolution Protocol`).
- **Physical Layer (Layer 1):** Physical cables, network cards (NICs), and bitstream transmission.

### 2. IP Addressing, Subnetting & CIDR
- **IPv4 Format:** 32-bit address represented as 4 decimal octets (e.g., `192.168.1.1`).
- **CIDR Notation (Classless Inter-Domain Routing):** Expresses the network prefix length, for example:
  - `/24` = `255.255.255.0` (256 IP addresses, 254 usable for hosts).
  - `/16` = `255.255.0.0` (65,536 IP addresses).
  - `/32` = A single specific host IP.
- **Public vs. Private IP Addresses (RFC 1918):**
  - `10.0.0.0/8` (e.g., used extensively in AWS VPCs and Kubernetes pod networks)
  - `172.16.0.0/12` (e.g., used by Docker default bridge network `172.17.0.0/16` and WSL)
  - `192.168.0.0/16` (commonly used in local home/office networks)

### 3. DNS (Domain Name System)
- Translates human-friendly domain names (e.g., `google.com`) into machine-routable IP addresses (e.g., `142.250.182.78`).
- Uses hierarchical query resolution: Local DNS Cache → Recursive Resolver → Root DNS Servers → TLD Servers (`.com`) → Authoritative Nameserver.
- Record types: `A` (IPv4), `AAAA` (IPv6), `CNAME` (canonical alias), `MX` (mail exchange), `TXT` (verification/SPF).

### 4. Relevance to DevOps & Cloud Infrastructure
- **Docker Networking:** Bridge, host, overlay, and macvlan networks allow isolated container communication or multi-host Swarm clusters.
- **Kubernetes Networking:** Pod-to-Pod communication (flat IP per pod), CoreDNS internal service discovery, and Service types (`ClusterIP`, `NodePort`, `LoadBalancer`, `ExternalName`).
- **Cloud VPCs (AWS / Azure):** Subnets, Internet Gateways, NAT Gateways for private outbound internet traffic, Route Tables, and Security Groups (stateful virtual firewalls).

---

## 🛠️ Task 2: Networking Commands Execution, Outputs & Conceptual Explanations

The commands were executed in the environment, and the actual terminal outputs along with conceptual explanations are documented below.

Detailed execution notes are also maintained in [`networking_commands.md`](./networking_commands.md).

---

### 1. `ipconfig` / `ip addr` (Network Interface & IP Configuration)

#### What I Understood:
- **Purpose:** Displays all current TCP/IP network configuration values for every network adapter (NIC) on the system, including physical ethernet cards, Wi-Fi adapters, and virtual adapters (such as WSL and Docker).
- **Key Concepts Learned:** 
  - **IPv4 Address:** The local IP assigned to the machine interface on the current network.
  - **Subnet Mask:** Defines which part of the IP address belongs to the network and which part identifies the host.
  - **Default Gateway:** The IP address of the local router/switch that forwards packets whose destinations are outside the local subnet.
  - **Virtual Adapters:** Modern DevOps environments (Docker, WSL, Hyper-V) create their own virtual interfaces (e.g., `vEthernet (WSL)`) with separate private subnets to isolate container and VM traffic.

#### Executed Command:
```powershell
ipconfig
```

#### Actual Terminal Output:
```text
Windows IP Configuration

Ethernet adapter Ethernet 2:

   Media State . . . . . . . . . . . : Media disconnected
   Connection-specific DNS Suffix  . : 

Ethernet adapter Ethernet:

   Connection-specific DNS Suffix  . : 
   IPv4 Address. . . . . . . . . . . : 10.79.11.205
   Subnet Mask . . . . . . . . . . . : 255.255.255.0
   Default Gateway . . . . . . . . . : 10.79.11.207

Ethernet adapter vEthernet (WSL (Hyper-V firewall)):

   Connection-specific DNS Suffix  . : 
   Link-local IPv6 Address . . . . . : fe80::ef2c:1194:75db:1fdf%61
   IPv4 Address. . . . . . . . . . . : 172.29.16.1
   Subnet Mask . . . . . . . . . . . : 255.255.240.0
   Default Gateway . . . . . . . . . : 
```

#### DevOps Use Case:
Essential when diagnosing IP conflict issues, verifying which subnet a node belongs to, or determining the default gateway when establishing VPC peering or container bridging.

---

### 2. `ping` (Network Reachability & Latency Testing)

#### What I Understood:
- **Purpose:** Tests whether a remote destination host or IP is reachable across an IP network and measures the round-trip time (RTT).
- **Key Concepts Learned:**
  - Uses the **ICMP (Internet Control Message Protocol)** Echo Request and Echo Reply messages.
  - **TTL (Time to Live):** An 8-bit field decremented by each router hop along the route to prevent endless routing loops.
  - **Packet Loss:** Indicates network congestion, dropping firewalls, or intermittent physical links.
  - **Latency:** Displays minimum, maximum, and average response times in milliseconds.

#### Executed Command:
```powershell
ping -n 4 google.com
```

#### Actual Terminal Output:
```text
Pinging google.com [142.250.182.78] with 32 bytes of data:
Reply from 142.250.182.78: bytes=32 time=28ms TTL=116
Reply from 142.250.182.78: bytes=32 time=12ms TTL=116
Reply from 142.250.182.78: bytes=32 time=11ms TTL=116
Reply from 142.250.182.78: bytes=32 time=322ms TTL=116

Ping statistics for 142.250.182.78:
    Packets: Sent = 4, Received = 4, Lost = 0 (0% loss),
Approximate round trip times in milli-seconds:
    Minimum = 11ms, Maximum = 322ms, Average = 93ms
```

#### DevOps Use Case:
First-line tool to check if a remote server, Kubernetes cluster node, or EC2 instance is powered on and connected to the network.

---

### 3. `nslookup` (DNS Query & Name Resolution)

#### What I Understood:
- **Purpose:** Queries Domain Name System (DNS) servers to obtain domain name to IP address mappings or other specific DNS records (A, AAAA, MX, CNAME, TXT).
- **Key Concepts Learned:**
  - **Server & Address:** Shows which DNS resolver answered the query (here `10.79.11.207`, the gateway DNS).
  - **Non-authoritative answer:** Means the response was fetched from a recursive resolver's cache rather than directly from the primary authoritative DNS server that owns the domain zone.
  - Returns both IPv4 (`A` record: `142.250.182.78`) and IPv6 (`AAAA` record: `2404:6800:4007:810::200e`).

#### Executed Command:
```powershell
nslookup google.com
```

#### Actual Terminal Output:
```text
Non-authoritative answer:
Server:  UnKnown
Address:  10.79.11.207

Name:    google.com
Addresses:  2404:6800:4007:810::200e
	  142.250.182.78
```

#### DevOps Use Case:
Crucial for troubleshooting internal Kubernetes service discovery (e.g., verifying if CoreDNS resolves `backend-service.default.svc.cluster.local`) or verifying cloud DNS records in AWS Route 53.

---

### 4. `tracert` / `traceroute` (Route Path & Hop Discovery)

#### What I Understood:
- **Purpose:** Traces the packet path taken across intermediate routers and gateways from the local machine to a destination host.
- **Key Concepts Learned:**
  - Works by sending packets with incrementally increasing **TTL values** starting from 1. When a router receives a packet with `TTL=1`, it discards it and sends back an `ICMP Time Exceeded` error message, revealing that router's IP address.
  - Displays each hop count and the round-trip times for multiple probes.
  - In our execution:
    - Hop 1: `10.79.11.207` (Local gateway)
    - Hop 2: `192.168.1.1` (Upstream router / modem)
    - Hop 3: `14.194.79.193` (ISP gateway)
    - Hop 4: Timed out because the ISP edge router suppresses ICMP response packets for security.

#### Executed Command:
```powershell
tracert -d -h 4 8.8.8.8
```

#### Actual Terminal Output:
```text
Tracing route to 8.8.8.8 over a maximum of 4 hops

  1     1 ms    <1 ms    <1 ms  10.79.11.207 
  2   118 ms   183 ms     7 ms  192.168.1.1 
  3    15 ms     6 ms     9 ms  14.194.79.193 
  4     *        *        *     Request timed out.

Trace complete.
```

#### DevOps Use Case:
Identifying where network latency spikes occur, verifying multi-region WAN routes, or determining which transit router or firewall is dropping packets between microservices.

---

### 5. `curl` (HTTP Client & API Protocol Inspector)

#### What I Understood:
- **Purpose:** Command-line tool and library for transferring data using various network protocols, most commonly HTTP and HTTPS.
- **Key Concepts Learned:**
  - The `-I` (or `--head`) flag sends an `HTTP HEAD` request to fetch only the HTTP response headers without downloading the full HTML response body.
  - Confirms the HTTP status code (`HTTP/1.1 200 OK`).
  - Displays critical server headers such as `Server: gws`, `Content-Type`, `Date`, security policies, and cookie directives (`Set-Cookie`).

#### Executed Command:
```powershell
curl.exe -I https://www.google.com
```

#### Actual Terminal Output:
```text
HTTP/1.1 200 OK
Content-Type: text/html; charset=ISO-8859-1
Content-Security-Policy-Report-Only: object-src 'none';base-uri 'self';script-src 'nonce-...' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
Accept-CH: Sec-CH-Prefers-Color-Scheme
P3P: CP="This is not a P3P policy! See g.co/p3phelp for more info."
Date: Tue, 06 Oct 2026 10:12:20 GMT
Server: gws
X-XSS-Protection: 0
X-Frame-Options: SAMEORIGIN
Expires: Tue, 06 Oct 2026 10:12:20 GMT
Cache-Control: private
Set-Cookie: __Secure-STRP=...; expires=Tue, 06-Oct-2026 10:17:20 GMT; path=/; domain=.google.com; Secure; SameSite=strict
Transfer-Encoding: chunked
Alt-Svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
```

#### DevOps Use Case:
Testing REST API health endpoints (`/healthz`, `/ready`), verifying ingress controllers, checking reverse proxy SSL certificates, and testing CI/CD deployment webhooks.

---

### 6. `netstat` / `ss` (Network Statistics & Active Ports)

#### What I Understood:
- **Purpose:** Monitors incoming and outgoing network connections, routing tables, and interface statistics, and lists listening server sockets.
- **Key Concepts Learned:**
  - `netstat -ano`:
    - `-a`: Displays all active connections and listening ports.
    - `-n`: Displays addresses and port numbers in numerical form instead of attempting DNS/service name resolution.
    - `-o`: Displays the owning Process ID (PID) associated with each connection.
  - In our output, we can observe services listening on:
    - Port `3306` & `33060`: MySQL Database daemon (PID `6300`).
    - Port `445`: Microsoft SMB file sharing.
    - Port `135`: Microsoft RPC Endpoint Mapper.
    - `0.0.0.0`: The socket is bound to all available IPv4 network interfaces on the machine.

#### Executed Command:
```powershell
netstat -ano | findstr LISTENING
```

#### Actual Terminal Output:
```text
  TCP    0.0.0.0:135            0.0.0.0:0              LISTENING       1816
  TCP    0.0.0.0:445            0.0.0.0:0              LISTENING       4
  TCP    0.0.0.0:3306           0.0.0.0:0              LISTENING       6300
  TCP    0.0.0.0:5040           0.0.0.0:0              LISTENING       7652
  TCP    0.0.0.0:12177          0.0.0.0:0              LISTENING       15572
  TCP    0.0.0.0:33060          0.0.0.0:0              LISTENING       6300
  TCP    0.0.0.0:49664          0.0.0.0:0              LISTENING       1544
  TCP    0.0.0.0:49665          0.0.0.0:0              LISTENING       1372
  TCP    0.0.0.0:49666          0.0.0.0:0              LISTENING       2076
  TCP    0.0.0.0:49667          0.0.0.0:0              LISTENING       3104
```

#### DevOps Use Case:
Detecting port conflicts when running containers (e.g., `bind: address already in use`), confirming if web servers (Nginx/Apache) are actively listening on port 80/443, and identifying rogue background processes.

---

### 7. `arp` (Address Resolution Protocol Cache)

#### What I Understood:
- **Purpose:** Displays and modifies the ARP cache table, which maps Layer 3 IP addresses to Layer 2 physical MAC (Ethernet) hardware addresses.
- **Key Concepts Learned:**
  - Before an Ethernet frame can be transmitted over a local LAN segment, the operating system must find the physical hardware MAC address corresponding to the destination IP.
  - **Dynamic:** Learned automatically via ARP broadcast requests/replies on the local segment (e.g., gateway `10.79.11.207` maps to MAC `32-2c-fa-3f-12-70`).
  - **Static:** Hardcoded or broadcast addresses (e.g., `255.255.255.255` maps to `ff-ff-ff-ff-ff-ff`).

#### Executed Command:
```powershell
arp -a
```

#### Actual Terminal Output:
```text
Interface: 10.79.11.205 --- 0x14
  Internet Address      Physical Address      Type
  10.79.11.207          32-2c-fa-3f-12-70     dynamic   
  10.79.11.255          ff-ff-ff-ff-ff-ff     static    
  224.0.0.22            01-00-5e-00-00-16     static    
  224.0.0.251           01-00-5e-00-00-fb     static    
  224.0.0.252           01-00-5e-00-00-fc     static    
  239.255.255.250       01-00-5e-7f-ff-fa     static    
  255.255.255.255       ff-ff-ff-ff-ff-ff     static    

Interface: 172.29.16.1 --- 0x3d
  Internet Address      Physical Address      Type
  172.29.17.4           00-15-5d-02-ec-9d     dynamic   
  172.29.31.255         ff-ff-ff-ff-ff-ff     static    
  224.0.0.22            01-00-5e-00-00-16     static    
  224.0.0.251           01-00-5e-00-00-fb     static    
  239.255.255.250       01-00-5e-7f-ff-fa     static    
```

#### DevOps Use Case:
Diagnosing ARP spoofing / poisoning, detecting duplicate IP address conflicts in private bare-metal clusters, or inspecting virtual switch bindings in Hyper-V and Docker networks.

---

### 8. `route` / `ip route` (IP Routing Table)

#### What I Understood:
- **Purpose:** Inspects and manipulates the kernel's network routing table. The routing table tells the operating system which network interface and gateway to use when dispatching IP packets.
- **Key Concepts Learned:**
  - **Destination `0.0.0.0` / Netmask `0.0.0.0`:** The default route for any traffic not matching a local subnet. The gateway `10.79.11.207` is used.
  - **On-link:** The destination IP range is directly accessible on the local physical network without crossing an intermediate router.
  - **Metric:** The routing cost or priority; if multiple routes exist to the same subnet, the route with the lowest metric is preferred.

#### Executed Command:
```powershell
route print -4
```

#### Actual Terminal Output:
```text
IPv4 Route Table
===========================================================================
Active Routes:
Network Destination        Netmask          Gateway       Interface  Metric
          0.0.0.0          0.0.0.0     10.79.11.207     10.79.11.205     75
       10.79.11.0    255.255.255.0         On-link      10.79.11.205    331
     10.79.11.205  255.255.255.255         On-link      10.79.11.205    331
     10.79.11.255  255.255.255.255         On-link      10.79.11.205    331
        127.0.0.0        255.0.0.0         On-link         127.0.0.1    331
        127.0.0.1  255.255.255.255         On-link         127.0.0.1    331
  127.255.255.255  255.255.255.255         On-link         127.0.0.1    331
      172.29.16.0    255.255.240.0         On-link       172.29.16.1   5256
      172.29.16.1  255.255.255.255         On-link       172.29.16.1   5256
    172.29.31.255  255.255.255.255         On-link       172.29.16.1   5256
        224.0.0.0        240.0.0.0         On-link         127.0.0.1    331
        224.0.0.0        240.0.0.0         On-link       172.29.16.1   5256
        224.0.0.0        240.0.0.0         On-link      10.79.11.205    331
  255.255.255.255  255.255.255.255         On-link         127.0.0.1    331
  255.255.255.255  255.255.255.255         On-link       172.29.16.1   5256
  255.255.255.255  255.255.255.255         On-link      10.79.11.205    331
===========================================================================
```

#### DevOps Use Case:
Critical in multi-homed Kubernetes worker nodes, VPN tunnel routing (OpenVPN/WireGuard), and configuring AWS VPC route tables pointing to NAT or Transit Gateways.

---

### 9. `Test-NetConnection` / `nc` (TCP Port Reachability Testing)

#### What I Understood:
- **Purpose:** Tests TCP three-way handshake connectivity to a specific port on a target host. Acts as the native Windows/PowerShell equivalent to `nc -zv` (Netcat) or `telnet <host> <port>`.
- **Key Concepts Learned:**
  - Verifies if firewall rules, security groups, and remote listeners permit traffic on a specific port.
  - Returns `TcpTestSucceeded : True` when the three-way handshake (`SYN`, `SYN-ACK`, `ACK`) completes successfully.

#### Executed Command:
```powershell
Test-NetConnection -ComputerName google.com -Port 443
```

#### Actual Terminal Output:
```text
ComputerName     : google.com
RemoteAddress    : 142.250.205.78
RemotePort       : 443
InterfaceAlias   : Ethernet
SourceAddress    : 10.79.11.205
TcpTestSucceeded : True
```

#### DevOps Use Case:
Testing whether an RDS database port `5432`/`3306` is open through an AWS Security Group, testing Redis connectivity on `6379`, or validating microservice ingress before sending real traffic.

---

### 10. `ssh` (Secure Shell)

#### What I Understood:
- **Purpose:** Secure cryptographic protocol for operating network services securely over an unsecured network. Most commonly used for remote command execution and terminal login.
- **Key Concepts Learned:**
  - Employs public-key cryptography to authenticate the remote computer and allow the user to authenticate if desired.
  - Supports SSH tunnels and port forwarding (`-L` local, `-R` remote, `-D` dynamic SOCKS proxy), allowing secure access to private database instances via bastion hosts.

#### Executed Command:
```powershell
ssh -V
```

#### Actual Terminal Output:
```text
OpenSSH_for_Windows_9.5p1, LibreSSL 3.8.2
```

#### DevOps Use Case:
Connecting to remote EC2 instances, deploying via Ansible automation over SSH, and establishing bastion jump host tunnels to access isolated private subnets.

---

## 📌 Summary & Conclusion

This homework reinforces the complete lifecycle of network operations in a DevOps context:
1. **Host Configuration:** Knowing host IP and interface parameters (`ipconfig`, `route`, `arp`).
2. **Connectivity & Latency:** Confirming layer-3 ICMP reachability and network hops (`ping`, `tracert`).
3. **Name Resolution:** Troubleshooting DNS lookup chains (`nslookup`).
4. **Transport & Application Layer Diagnostics:** Checking listening ports and TCP handshakes (`netstat`, `Test-NetConnection`), as well as executing protocol requests and validating HTTP response codes (`curl`).
