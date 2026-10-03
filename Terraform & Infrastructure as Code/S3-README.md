# 🪣 AWS S3 — Simple Storage Service

## 1. What is S3?

**S3 (Simple Storage Service)** is AWS's object storage service.

It is used to store files such as:

```text
Images
Videos
PDFs
Backups
Logs
Documents
Application files
```

Think of S3 as:

> **A huge cloud storage system where you store files.**

---

## 2. Bucket and Object

S3 has two important concepts:

### Bucket

A **bucket** is a container for your files.

```text
S3
└── Bucket
    ├── image.jpg
    ├── resume.pdf
    └── backup.zip
```

### Object

An **object** is the actual file stored inside the bucket.

An object contains:

```text
File data
+
Metadata
+
Object key
```

---

## 3. Object Key

S3 doesn't really use traditional folders.

For example:

```text
images/profile.jpg
```

is an object whose **key** is:

```text
images/profile.jpg
```

The `/` makes it look like a folder structure.

---

## 4. How S3 Works

Suppose your application receives a profile picture.

```text
User
 ↓
Backend
 ↓
Upload image
 ↓
S3 Bucket
 ↓
image stored
```

Later:

```text
User
 ↓
Backend
 ↓
S3
 ↓
Download image
```

---

## 5. Storage Classes

S3 provides different storage classes based on how frequently data is accessed.

Common examples:

| Storage Class          | Use                              |
| ---------------------- | -------------------------------- |
| S3 Standard            | Frequently accessed data         |
| S3 Intelligent-Tiering | Unknown/changing access patterns |
| S3 Standard-IA         | Infrequently accessed data       |
| S3 Glacier             | Long-term archive                |

Basic idea:

> Frequently accessed → Standard
> Rarely accessed → cheaper archival classes

---

## 6. Durability vs Availability

These are different concepts.

### Durability

How likely your stored data is to remain intact.

### Availability

How easily the data can be accessed when requested.

Remember:

```text
Durability = Will my data survive?
Availability = Can I access it now?
```

---

## 7. Security

S3 access can be controlled using:

### IAM Policies

Control which AWS identities can access S3.

### Bucket Policies

Control access at the bucket level.

### Block Public Access

Helps prevent accidental public exposure.

A common secure approach:

```text
Application
    ↓
IAM Permission
    ↓
S3 Bucket
```

---

## 8. Versioning

S3 can keep multiple versions of an object.

Example:

```text
report.pdf
   ↓
Version 1

report.pdf
   ↓
Version 2
```

If the file is accidentally overwritten or deleted, previous versions may be recoverable depending on configuration.

---

## 9. Common Use Cases

S3 is commonly used for:

* Static website files
* Image storage
* Video storage
* Backups
* Data lakes
* Application uploads
* Logs
* Archives

---

## 🧠 Remember

> **S3 = Cloud storage for files/objects.**

Remember:

```text
Bucket → Container
Object → File
Key    → Object's name/path
Versioning → Keep previous versions
Storage Classes → Optimize storage cost
IAM/Bucket Policy → Control access
```

### EC2 + S3 Example

```text
        User
          ↓
       EC2 App
          ↓
     Upload image
          ↓
      S3 Bucket
          ↓
      image.jpg
```

**EC2 runs the application.
S3 stores the files.**
