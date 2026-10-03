# 🗄️ AWS Databases — DynamoDB & RDS

AWS provides different database services for different application requirements.

Two important ones are:

```text
RDS       → Relational SQL database
DynamoDB  → NoSQL database
```

---

# 🐘 Part 1 — Amazon RDS

## 1. What is RDS?

**Amazon RDS (Relational Database Service)** is a managed service for relational databases.

Instead of installing and maintaining a database server yourself, AWS manages much of the infrastructure.

RDS supports database engines such as:

```text
PostgreSQL
MySQL
MariaDB
Oracle
SQL Server
```

---

## 2. Relational Database

Data is organized into **tables**.

Example:

### Customers

| id | name  | email                                         |
| -- | ----- | --------------------------------------------- |
| 1  | Rahul | [rahul@example.com](mailto:rahul@example.com) |
| 2  | Priya | [priya@example.com](mailto:priya@example.com) |

### Orders

| id  | customer_id | amount |
| --- | ----------- | ------ |
| 101 | 1           | 500    |
| 102 | 2           | 800    |

Tables can have relationships.

```text
Customers
    |
    | customer_id
    ↓
Orders
```

---

## 3. SQL

You interact with relational databases using SQL.

Example:

```sql
SELECT * FROM customers;

SELECT *
FROM orders
WHERE amount > 500;
```

You can also use:

```text
JOIN
WHERE
GROUP BY
ORDER BY
INSERT
UPDATE
DELETE
```

---

## 4. Why use RDS?

RDS is useful when your application needs:

* SQL
* Relationships between tables
* Transactions
* Complex queries
* Structured data
* Strong relational consistency

Example applications:

```text
Banking
E-commerce
ERP
Payment systems
Business applications
```

---

# ⚡ Part 2 — DynamoDB

## 1. What is DynamoDB?

**Amazon DynamoDB** is a fully managed **NoSQL key-value/document database**.

Instead of traditional tables with fixed relational structures, DynamoDB stores items identified by keys.

Example:

```text
User
{
    userId: "101",
    name: "Rahul",
    age: 22
}
```

---

## 2. DynamoDB Table

A DynamoDB table contains **items**.

Think:

```text
DynamoDB Table
│
├── Item
├── Item
└── Item
```

An item is similar to a row, but its attributes can be more flexible.

---

## 3. Primary Key

Every DynamoDB table needs a primary key.

Two common designs:

### Partition Key

```text
userId
```

Example:

```text
userId = 101
```

DynamoDB uses the key to determine where the item is stored.

### Composite Key

Can contain:

```text
Partition Key
+
Sort Key
```

Example:

```text
Partition Key → userId
Sort Key      → orderId
```

This allows multiple related items under the same partition key.

---

# 4. RDS vs DynamoDB

| Feature       | RDS                       | DynamoDB                                      |
| ------------- | ------------------------- | --------------------------------------------- |
| Database type | Relational                | NoSQL                                         |
| Query         | SQL                       | API/expressions                               |
| Structure     | Tables/rows               | Items/attributes                              |
| Relationships | Strong relational support | Designed differently                          |
| Schema        | Structured                | More flexible                                 |
| Scaling       | Managed scaling options   | Designed for large-scale horizontal workloads |
| Best for      | Relational applications   | Key-value/document workloads                  |

---

# 5. When Should You Use Which?

### Choose RDS when:

```text
You need SQL
        +
Relationships
        +
Complex queries
        +
Transactions
```

Example:

```text
E-commerce

Customers
   ↓
Orders
   ↓
Products
   ↓
Payments
```

---

### Choose DynamoDB when:

```text
You need very fast key-based access
        +
Flexible item structure
        +
Large-scale managed NoSQL
```

Example:

```text
userId → User profile
productId → Product information
sessionId → Session data
```

---

# 6. Simple Architecture

### RDS

```text
Application
     ↓
    RDS
     ↓
PostgreSQL/MySQL
     ↓
Tables + Relationships
```

### DynamoDB

```text
Application
     ↓
DynamoDB
     ↓
Table
     ↓
Items
```

---

# 🧠 Remember

### RDS

> **RDS = Managed relational SQL database.**

Think:

```text
Tables
Rows
Columns
Relationships
SQL
Transactions
```

### DynamoDB

> **DynamoDB = Managed NoSQL key-value/document database.**

Think:

```text
Tables
Items
Attributes
Partition Key
Sort Key
Fast key-based access
```

### One-line difference

> **RDS is like a traditional SQL database managed by AWS, while DynamoDB is a managed NoSQL database designed around key-value/document access patterns.**
