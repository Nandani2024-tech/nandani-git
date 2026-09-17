# Kubernetes Canary Deployment — Troubleshooting

## 1. What We Were Trying to Do

The goal was to test a **Canary Deployment** where:

* `STABLE v1` → stable application
* `CANARY v2` → new version
* Kubernetes Service → sends traffic to the application Pods

We wanted to send multiple requests and observe which version responds.

---

## 2. Initial Command

The instructor's command was written for **Linux/Bash**:

```bash
for i in $(seq 1 10); do
    curl -s http://$(minikube ip):30030 | grep -o "STABLE v1\|CANARY v2"
done
```

But we are using **Windows PowerShell**.

PowerShell does not understand Bash syntax such as:

```bash
for i in ...
do
done
$(seq 1 10)
grep
```

So PowerShell showed:

```text
Missing opening '(' after keyword 'for'.
```

### PowerShell equivalent

```powershell
for ($i = 1; $i -le 10; $i++) {
    curl.exe -s "http://$(minikube ip):30030"
}
```

---

# 3. Second Problem — NodePort Timeout

We tried:

```powershell
curl.exe -v "http://$(minikube ip):30030"
```

Minikube IP:

```text
192.168.49.2
```

But the request timed out:

```text
Failed to connect to 192.168.49.2 port 30030
```

### Why?

We are running:

* Windows
* Minikube
* Docker driver

With the Docker driver on Windows, the Minikube NodePort is **not necessarily directly accessible from Windows using**:

```text
<minikube-ip>:<nodeport>
```

So:

```text
192.168.49.2:30030
```

was not reachable from PowerShell.

---

# 4. How We Fixed It

First, we verified the Service:

```powershell
kubectl get svc
```

Output showed:

```text
myapp-canary-service   NodePort   ...   80:30030/TCP
```

So the Service was correctly using:

```text
NodePort = 30030
```

Instead of accessing the NodePort directly, we used Minikube's service command:

```powershell
minikube service myapp-canary-service --url
```

It returned:

```text
http://127.0.0.1:65277
```

This gives us a local URL that forwards traffic to the Kubernetes Service.

---

# 5. Testing the Service

We tested one request:

```powershell
curl.exe -s "http://127.0.0.1:65277"
```

Response:

```text
STABLE v1
Track: stable | 90% of traffic
```

Then we tested 10 requests:

```powershell
for ($i = 1; $i -le 10; $i++) {
    curl.exe -s "http://127.0.0.1:65277"
}
```

All requests returned:

```text
STABLE v1
```

We also used:

```powershell
for ($i = 1; $i -le 10; $i++) {
    curl.exe -s "http://127.0.0.1:65277" |
        Select-String -Pattern "STABLE v1|CANARY v2"
}
```

Result:

```text
STABLE v1
STABLE v1
STABLE v1
...
```

This confirmed that the Service was reachable and responding.

---

# 6. Important Lesson

### Linux/Bash command

```bash
for i in $(seq 1 10); do
    ...
done
```

### Windows PowerShell equivalent

```powershell
for ($i = 1; $i -le 10; $i++) {
    ...
}
```

Also, with **Minikube + Docker driver + Windows**, prefer:

```powershell
minikube service <service-name> --url
```

when direct access through:

```text
minikube-ip:nodeport
```

does not work.

---

# 7. Final Steps — Quick Checklist

```text
1. Deploy Stable + Canary applications
        ↓
2. Create the Kubernetes Service
        ↓
3. Check the Service
   kubectl get svc
        ↓
4. Get a reachable URL
   minikube service myapp-canary-service --url
        ↓
5. Test one request
   curl.exe -s "<URL>"
        ↓
6. Send multiple requests
   PowerShell for loop
        ↓
7. Observe STABLE v1 / CANARY v2
```

### Useful Commands

```powershell
kubectl get pods
kubectl get svc
kubectl get deployments
```

```powershell
minikube service myapp-canary-service --url
```

```powershell
curl.exe -s "http://127.0.0.1:65277"
```

```powershell
for ($i = 1; $i -le 10; $i++) {
    curl.exe -s "http://127.0.0.1:65277" |
        Select-String -Pattern "STABLE v1|CANARY v2"
}
```

**Key takeaway:** The Kubernetes Service was working. The main issue was **how Windows accessed the Minikube NodePort**, not the Canary application itself.
