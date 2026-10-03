# 🌐 AWS VPC — Virtual Private Cloud

## 1. What is VPC?

**VPC (Virtual Private Cloud)** is your own logically isolated network inside AWS.

Think of it as:

> **Creating your own private network in AWS where you control how resources communicate.**

Example:

```text
                 AWS
                  |
                VPC
       ┌──────────┴──────────┐
       │                     │
   Public Subnet        Private Subnet
       │                     │
      EC2                  Database
```

---

## 2. Why do we need VPC?

Suppose you have:

```text
Frontend
Backend
Database
```

You don't want the database directly exposed to the internet.

Instead:

```text
Internet
   ↓
Frontend
   ↓
Backend
   ↓
Database
```

The database can remain in a **private subnet**.

---

# 3. Important VPC Components

## VPC

The overall network.

Example:

```text
10.0.0.0/16
```

This is the IP address range available to the VPC.

---

## Subnet

A subnet is a smaller network inside the VPC.

Example:

```text
VPC: 10.0.0.0/16

├── Public Subnet
│   10.0.1.0/24
│
└── Private Subnet
    10.0.2.0/24
```

---

## Availability Zone

An AWS region contains multiple **Availability Zones (AZs)**.

Example:

```text
Region
├── AZ-1
├── AZ-2
└── AZ-3
```

You can distribute resources across AZs for better availability.

---

## Internet Gateway

Allows resources in a public subnet to communicate with the internet.

```text
Internet
   ↕
Internet Gateway
   ↕
VPC
```

---

## Route Table

A route table tells AWS:

> "Where should network traffic go?"

Example:

```text
Destination       Target

10.0.0.0/16       local
0.0.0.0/0         Internet Gateway
```

`0.0.0.0/0` means:

> Any destination not matching another route.

---

## NAT Gateway

Allows resources in a private subnet to **make outbound internet connections** without allowing direct inbound internet connections.

```text
Private EC2
    ↓
NAT Gateway
    ↓
Internet
```

Common use:

A private server needs to download software updates.

---

## Security Group

Controls traffic for resources such as EC2.

It is **stateful**.

Example:

```text
Inbound:
Port 22 → SSH
Port 80 → HTTP
Port 443 → HTTPS
```

---

## Network ACL

Controls traffic at the **subnet level**.

Unlike Security Groups, NACLs are **stateless**.

---

# 4. Public vs Private Subnet

### Public Subnet

Has a route to an Internet Gateway.

Usually contains:

```text
Load Balancer
Public EC2
Bastion Host
```

### Private Subnet

Does not have a direct route to the Internet Gateway.

Usually contains:

```text
Databases
Internal APIs
Private EC2
```

---

# 5. Typical Application Architecture

```text
                  Internet
                     ↓
              Internet Gateway
                     ↓
              Public Subnet
                     ↓
              Load Balancer
                     ↓
              Private Subnet
                     ↓
                Backend EC2
                     ↓
              Private Subnet
                     ↓
                 Database
```

This architecture keeps sensitive resources away from direct internet access.

---

# 🧠 Remember

> **VPC = Your private network in AWS.**

Remember:

```text
VPC             → Overall network
Subnet          → Smaller network inside VPC
Availability Zone → Physical isolation boundary
Route Table     → Decides where traffic goes
Internet Gateway→ Internet access
NAT Gateway     → Private → Internet
Security Group  → Resource-level firewall
NACL            → Subnet-level firewall
```
