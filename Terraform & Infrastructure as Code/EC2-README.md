# ☁️ AWS EC2 — Elastic Compute Cloud

## 1. What is EC2?

**EC2 (Elastic Compute Cloud)** provides virtual servers in the AWS cloud.

Think of it as:

> **Renting a computer in AWS instead of buying and maintaining a physical server.**

You can choose:

* CPU
* RAM
* Storage
* Operating System
* Network configuration

Example:

```text
Your Laptop
     |
     | SSH
     ↓
AWS EC2 Instance
     |
     └── Runs your application
```

---

## 2. What is an EC2 Instance?

An **EC2 Instance** is a virtual machine running inside AWS.

For example, you can create an instance with:

```text
OS       → Ubuntu
CPU      → 2 vCPUs
RAM      → 4 GB
Storage  → 20 GB
```

You can then install:

```text
Java
Python
Node.js
Docker
Nginx
Kubernetes tools
```

and run your applications.

---

## 3. Important EC2 Concepts

### AMI

**AMI (Amazon Machine Image)** is a template used to create an EC2 instance.

It contains things like:

```text
Operating System
Software
Configuration
```

Example:

```text
Ubuntu AMI → Create EC2 → Ubuntu Server
```

### Instance Type

Defines the computing resources.

Example:

```text
t3.micro
t3.small
t3.medium
```

Different types provide different CPU, memory and network capabilities.

### EBS

**Elastic Block Store (EBS)** provides persistent disk storage for EC2.

Think:

```text
EC2 = Computer
EBS = Hard Drive
```

### Key Pair

Used to securely connect to an EC2 instance through SSH.

```text
Your Machine
     |
   SSH + Key
     ↓
EC2 Instance
```

### Security Group

Acts like a **virtual firewall** for an EC2 instance.

Example:

```text
Allow SSH      → Port 22
Allow HTTP     → Port 80
Allow HTTPS    → Port 443
```

---

## 4. EC2 Lifecycle

An instance can be:

```text
Pending
   ↓
Running
   ↓
Stopped
   ↓
Terminated
```

### Stop

The machine is shut down but its EBS storage can remain.

### Terminate

The EC2 instance is permanently deleted.

---

## 5. Scaling

Instead of manually creating servers, AWS can automatically manage multiple instances using:

### Auto Scaling Group

```text
             Load Balancer
                  |
       ┌──────────┼──────────┐
       ↓          ↓          ↓
     EC2-1      EC2-2      EC2-3
```

If traffic increases, more instances can be launched.

---

## 6. Common Use Cases

EC2 can be used for:

* Web servers
* Backend APIs
* Docker hosts
* Application servers
* Development environments
* Batch processing
* Self-hosted software

---

## 7. EC2 vs Your Local Computer

| Local Computer        | EC2                              |
| --------------------- | -------------------------------- |
| Physical machine      | Virtual machine                  |
| You maintain hardware | AWS maintains hardware           |
| Limited resources     | Easily scalable                  |
| Fixed location        | AWS cloud                        |
| You pay upfront       | Pay based on usage/configuration |

---

## 🧠 Remember

> **EC2 = A virtual computer in AWS.**

The most important concepts to remember:

```text
EC2 Instance → Virtual Server
AMI          → Server Template
Instance Type→ CPU/RAM configuration
EBS          → Disk
Security Group → Firewall
Key Pair     → SSH authentication
Auto Scaling → Automatically manage instances
```
