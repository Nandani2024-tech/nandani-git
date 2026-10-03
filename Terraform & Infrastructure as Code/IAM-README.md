# 🔐 AWS IAM — Identity and Access Management

## 1. What is IAM?

**IAM (Identity and Access Management)** controls:

> **Who can access AWS resources and what they are allowed to do.**

For example:

```text
Developer → Can access EC2
Developer → Cannot delete S3 bucket
Admin     → Can manage everything
```

IAM is mainly about **authentication + authorization**.

---

# 2. Authentication vs Authorization

### Authentication

> **Who are you?**

Example:

```text
Username + Password
```

### Authorization

> **What are you allowed to do?**

Example:

```text
Can read S3?
Can delete EC2?
Can create databases?
```

Remember:

```text
Authentication → Who are you?
Authorization  → What can you do?
```

---

# 3. IAM Users

An IAM User represents a person or application identity.

Example:

```text
Alice
Bob
Developer
```

A user can have permissions that determine what AWS resources they can access.

---

# 4. IAM Groups

A group is a collection of users.

Example:

```text
Developers
├── Alice
├── Bob
└── Charlie
```

You can attach permissions to the group instead of configuring every user individually.

---

# 5. IAM Policies

A **Policy** is a JSON document describing permissions.

Conceptually:

```text
Allow
    ↓
S3
    ↓
Read objects
```

Example idea:

```json
{
  "Effect": "Allow",
  "Action": "s3:GetObject",
  "Resource": "..."
}
```

Important fields:

```text
Effect   → Allow / Deny
Action   → What operation?
Resource → Which AWS resource?
```

---

# 6. IAM Roles

An **IAM Role** provides permissions that can be assumed by trusted entities.

This is extremely important for AWS services.

Example:

```text
EC2
 ↓
IAM Role
 ↓
S3 permissions
 ↓
S3 Bucket
```

The EC2 application can access S3 without storing AWS access keys inside the application.

---

# 7. User vs Role

| IAM User                          | IAM Role                                |
| --------------------------------- | --------------------------------------- |
| Represents an identity            | Provides temporary permissions          |
| Commonly associated with a person | Often used by AWS services/applications |
| Long-term identity                | Assumed when needed                     |

Modern AWS architectures generally prefer **IAM roles** for workloads rather than embedding long-lived access keys.

---

# 8. Least Privilege

A major IAM principle:

> **Give only the permissions that are actually required.**

Bad:

```text
Application → Full AWS access
```

Better:

```text
Application
    ↓
Only required S3 read permission
```

This reduces the impact of mistakes or compromised credentials.

---

# 9. Root User

The AWS account's **root user** has very high-level access.

It should not be used for normal daily work.

Use IAM identities/roles for regular operations and protect the root user strongly.

---

# 10. Example

Suppose an application running on EC2 needs to read files from S3.

Bad approach:

```text
Put AWS access key inside application
```

Better:

```text
EC2
 ↓
IAM Role
 ↓
Policy
 ↓
s3:GetObject
 ↓
S3
```

The application gets permissions through the role.

---

# 🧠 Remember

> **IAM = Who can do what to which AWS resource.**

Remember:

```text
User       → Identity
Group      → Collection of users
Policy     → Permission rules
Role       → Temporary/assumable permissions
Least Privilege → Minimum required access
```

The core question IAM answers:

> **"Who is allowed to perform this action on this resource?"**
