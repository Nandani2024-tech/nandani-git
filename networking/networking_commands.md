# Networking Commands Execution & Analysis

This Markdown file records the hands-on execution of essential networking commands, the captured terminal outputs from the local environment, and a concise explanation of the concepts understood for each command.

---

## Command Quick-Reference Table

| Command | Layer / Protocol | Primary Purpose | DevOps Use Case |
| :--- | :--- | :--- | :--- |
| **`ipconfig` / `ip`** | Layer 3 (IP) | Inspect IP, subnet mask, default gateway, virtual adapters | Validating container / VM IP assignments |
| **`ping`** | Layer 3 (ICMP) | Verify host reachability, packet loss, round-trip latency | Liveness / health monitoring of nodes |
| **`nslookup` / `dig`** | Layer 7 (DNS / UDP 53) | Query domain name resolution and DNS records | Debugging Kubernetes CoreDNS / Route 53 |
| **`tracert` / `traceroute`** | Layer 3 (ICMP / IP TTL) | Trace path hops to destination host | Pinpointing network bottlenecks and routing drops |
| **`curl`** | Layer 7 (HTTP / HTTPS) | Test HTTP requests, headers, status codes, APIs | Testing web apps, ingress controllers, CI/CD checks |
| **`netstat` / `ss`** | Layer 4 (TCP / UDP) | Show active connections, listening ports, and PIDs | Diagnosing port binding conflicts |
| **`arp`** | Layer 2 (Data Link / MAC) | View IP-to-MAC address resolution cache | Diagnosing local network communication and spoofing |
| **`route` / `ip route`** | Layer 3 (Routing) | Display and manage IP routing table | Multi-homed networking, VPNs, VPC routing |
| **`Test-NetConnection` / `nc`** | Layer 4 (TCP) | Test port reachability and 3-way handshake | Validating security group and firewall rules |
| **`ssh`** | Layer 7 (SSH / Port 22) | Encrypted remote terminal access and port forwarding | Managing cloud servers, Ansible automation |

---

## 1. `ipconfig`

### What I Understood:
- `ipconfig` provides a full snapshot of the TCP/IP network interfaces configured on the host operating system.
- It displays:
  - **IPv4 Address:** The local host IP address within the subnet (e.g., `10.79.11.205`).
  - **Subnet Mask:** Defines network boundaries (`255.255.255.0` represents a `/24` prefix).
  - **Default Gateway:** The IP of the router/switch to which traffic bound outside the local subnet is dispatched (`10.79.11.207`).
  - **Virtual Network Adapters:** Adapters like `vEthernet (WSL)` with subnet `172.29.16.1/20`, which power virtualization technologies like Docker Desktop and WSL2.

### Command:
```powershell
ipconfig
```

### Terminal Output:
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

---

## 2. `ping`

### What I Understood:
- `ping` sends ICMP Echo Request packets to a target IP or domain and waits for ICMP Echo Reply packets.
- It verifies whether the destination host is alive and accessible over IP.
- **TTL (Time To Live):** Indicates how many router hops the packet can survive before being discarded. In our result, `TTL=116`.
- **Packet Loss:** A zero percent loss (`0% loss`) confirms a stable, reliable connection.
- **Latency (RTT):** Shows response speeds; in our run, min was `11ms` and average was `93ms`.

### Command:
```powershell
ping -n 4 google.com
```

### Terminal Output:
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

---

## 3. `nslookup`

### What I Understood:
- `nslookup` queries Domain Name System servers to translate human-readable domain names into numerical IP addresses.
- **Non-authoritative answer:** Signifies that the DNS server answered from its cache or by querying another resolver, rather than being the master authoritative server for `google.com`.
- Displays both IPv4 (`142.250.182.78`) and IPv6 (`2404:6800:4007:810::200e`) addresses mapped to the domain.

### Command:
```powershell
nslookup google.com
```

### Terminal Output:
```text
Non-authoritative answer:
Server:  UnKnown
Address:  10.79.11.207

Name:    google.com
Addresses:  2404:6800:4007:810::200e
	  142.250.182.78
```

---

## 4. `tracert` / `traceroute`

### What I Understood:
- `tracert` traces the route that an IP packet takes toward its destination.
- It utilizes the **TTL field** in IP packet headers. Starting with `TTL=1`, each subsequent hop decrements TTL. When TTL reaches 0, the router discards the packet and sends an `ICMP Time Exceeded` packet back to the source, revealing that hop's IP address.
- In our test:
  - Hop 1 (`10.79.11.207`): Local gateway/router.
  - Hop 2 (`192.168.1.1`): Local network modem.
  - Hop 3 (`14.194.79.193`): ISP routing node.
  - Hop 4: Timed out because the ISP edge router filters out ICMP probe packets for security.

### Command:
```powershell
tracert -d -h 4 8.8.8.8
```

### Terminal Output:
```text
Tracing route to 8.8.8.8 over a maximum of 4 hops

  1     1 ms    <1 ms    <1 ms  10.79.11.207 
  2   118 ms   183 ms     7 ms  192.168.1.1 
  3    15 ms     6 ms     9 ms  14.194.79.193 
  4     *        *        *     Request timed out.

Trace complete.
```

---

## 5. `curl`

### What I Understood:
- `curl` is a command-line tool for transmitting data using supported protocols (HTTP, HTTPS, FTP, etc.).
- The `-I` (HEAD) option fetches only HTTP response headers, which is useful in DevOps for testing endpoints, status codes, and server response headers without transferring the entire response body.
- Returns status code `HTTP/1.1 200 OK`, response timestamps, server information (`Server: gws`), security cookies, and caching policy headers.

### Command:
```powershell
curl.exe -I https://www.google.com
```

### Terminal Output:
```text
HTTP/1.1 200 OK
Content-Type: text/html; charset=ISO-8859-1
Content-Security-Policy-Report-Only: object-src 'none';base-uri 'self';script-src 'nonce-AyqpAWjxikulrU8u_Af4Lg' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
Accept-CH: Sec-CH-Prefers-Color-Scheme
P3P: CP="This is not a P3P policy! See g.co/p3phelp for more info."
Date: Tue, 06 Oct 2026 10:12:20 GMT
Server: gws
X-XSS-Protection: 0
X-Frame-Options: SAMEORIGIN
Expires: Tue, 06 Oct 2026 10:12:20 GMT
Cache-Control: private
Set-Cookie: __Secure-STRP=...; expires=Tue, 06-Oct-2026 10:17:20 GMT; path=/; domain=.google.com; Secure; SameSite=strict
Set-Cookie: AEC=...; expires=Sun, 04-Apr-2027 10:12:20 GMT; path=/; domain=.google.com; Secure; HttpOnly; SameSite=lax
Set-Cookie: NID=...; expires=Wed, 07-Apr-2027 10:12:20 GMT; path=/; domain=.google.com; HttpOnly
Transfer-Encoding: chunked
Alt-Svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
```

---

## 6. `netstat`

### What I Understood:
- `netstat` displays active network connections, listening ports, ethernet statistics, and routing tables.
- Flags:
  - `-a`: Shows all connections and listening ports.
  - `-n`: Shows numerical addresses and port numbers instead of resolving names.
  - `-o`: Includes the process ID (PID) owning each socket.
- In our output:
  - `0.0.0.0:3306` & `0.0.0.0:33060`: The MySQL Database service is running and listening for connections (PID `6300`).
  - `0.0.0.0:445`: Microsoft-DS SMB file sharing service is listening.

### Command:
```powershell
netstat -ano | findstr LISTENING
```

### Terminal Output:
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

---

## 7. `arp`

### What I Understood:
- Address Resolution Protocol (ARP) maintains a dynamic cache table that maps Layer 3 IPv4 addresses to Layer 2 physical MAC addresses on the local area network.
- When an IP packet is destined for another host on the same local subnet, the host checks its ARP cache. If an entry is missing, an ARP broadcast request (`Who has IP X? Tell IP Y`) is transmitted.
- In our output:
  - Default gateway `10.79.11.207` is resolved to physical MAC address `32-2c-fa-3f-12-70` dynamically.
  - Broadcast address `10.79.11.255` is statically mapped to `ff-ff-ff-ff-ff-ff`.

### Command:
```powershell
arp -a
```

### Terminal Output:
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

---

## 8. `route`

### What I Understood:
- `route` displays and manages the IP routing table maintained by the kernel.
- The routing table directs IP packets based on their destination address:
  - Destination `0.0.0.0` with Netmask `0.0.0.0` points to Gateway `10.79.11.207`, directing all non-local internet traffic out through the gateway.
  - Subnet `10.79.11.0/24` is marked as `On-link`, meaning it is directly reachable on the local network interface without routing through an external gateway.
  - Metric values indicate priority when multiple matching routes exist.

### Command:
```powershell
route print -4
```

### Terminal Output:
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

---

## 9. `Test-NetConnection` (Port Connectivity)

### What I Understood:
- Tests the Layer 4 TCP connection (three-way handshake) to a specific remote host on an explicitly specified port.
- This is the Windows/PowerShell native equivalent of Linux `nc -zv` (Netcat) or `telnet <host> <port>`.
- `TcpTestSucceeded : True` verifies that the target host accepted the TCP connection on port `443` (HTTPS) and that no intermediate firewall, AWS Security Group, or Network ACL blocked the traffic.

### Command:
```powershell
Test-NetConnection -ComputerName google.com -Port 443
```

### Terminal Output:
```text
ComputerName     : google.com
RemoteAddress    : 142.250.205.78
RemotePort       : 443
InterfaceAlias   : Ethernet
SourceAddress    : 10.79.11.205
TcpTestSucceeded : True
```

---

## 10. `ssh`

### What I Understood:
- OpenSSH provides encrypted terminal sessions and secure communications across insecure networks.
- Used in DevOps for remote node administration, automated configuration with Ansible, and setting up secure encrypted tunnels (bastion hosts / jump boxes).
- Running `ssh -V` verifies that the OpenSSH client suite is installed, configured, and ready for remote access.

### Command:
```powershell
ssh -V
```

### Terminal Output:
```text
OpenSSH_for_Windows_9.5p1, LibreSSL 3.8.2
```

---

## 🎯 Conclusion & Key Takeaways

1. **Layered Troubleshooting:** Start diagnosis at Layer 3 (`ping`, `ipconfig`) to establish basic network reachability. Then test Layer 4 (`netstat`, `Test-NetConnection`) to ensure ports are listening and reachable, and finish at Layer 7 (`curl`) to validate application response codes.
2. **DNS & Resolution:** Always check both IP reachability and domain resolution (`nslookup`) to separate network connectivity bugs from name resolution failures.
3. **Security & Visibility:** Understanding ARP, routing tables, and port listeners gives clear visibility into how packets traverse local, containerized, and cloud-hosted environments.
