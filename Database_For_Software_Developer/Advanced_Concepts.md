# Advanced Concepts

# **Storage | Performance | Materialized View | Transactions**

## Storage Engines

⇒ Can define storage engine for a particular table.

### InnoDB

The default storage engine in MySQL 8.0. InnoDB is a transaction-safe(ACID compliant) MySQL storage engine with commit, rollback, and crash-recovery capabilities. It has row-level locking that increases mulit-user concurrency and performance.

⇒ This can recover crashed file by itself at the most of the cases. If it cannot then we have to take this from backup. Also can recovery of level while configuring.

⇒ It lock row instant of table while executing complex or time consuming update task.

⇒ Oracle is a performance RDBMS.

⇒ can use full text search

### MyISAM

They have a small footprint. Table-level locking limits the performance in read/write workloads, so it is often used in read-only or read-mostly workloads in Web and data warehousing configurations.

⇒ can use full text search

### Memory

Stores all data in RAM, for fast access in enviroments that require quick lookups of non-critical data.

⇒ Can use instance of Radis, Memcachse

⇒ In postgress we have this engine.

### CSV

Its tables are text files with comma-separated values. CSV tables let you import or dump data in CSV format, to exchange data with scirpts and applications that read and write that same format.

⇒ Do not have index, not usefull for complex query. Can use if get data in CSV format.

⇒ We can read data easily as it remain text format in other database it remains as binary file. Can not get data direactly from file need another database engine to read/write the data.

### Archive

These compact, unidexed tables are intended for storing and retriving large amounts of seldom-referenced historical, archived, or security audit information.

⇒ Read only data, can store very old log entry, history, order or product history

### Blackhole

The Blackhole storage engine in MySQL is a unique type of storage engine that does not store any data. When you use the Blackhole engine for a table, any data written to the table is accepted and then discarded. This means that no data is actually stored on disk or in memory for that table.

The Blackhole engine has several practical applications:

1. **Replication Filtering**: One of the primary uses of the Blackhole engine is in complex MySQL replication setups. You can set up a replication slave with tables using the Blackhole engine. This slave then processes the replication log, but does not store any actual data. This can be useful for filtering replication data before it is passed to other slaves or for reducing the load on certain database servers in a replication topology.
2. **Security and Auditing**: Since queries against Blackhole tables are written to the binary log (if binary logging is enabled), this can be used for security and auditing purposes. You can see what data was intended to be written without actually storing the data.
3. **Testing and Benchmarking**: The Blackhole engine can be used for performance testing and benchmarking, especially in replication scenarios. It helps in understanding the overhead of the binary logging and replication without the additional overhead of actual data storage and retrieval.
4. **Query Routing in a Proxy**: In a MySQL proxy setup, you might use Blackhole tables to analyze or transform queries before they are sent to the actual storage engine in the backend server.

To use the Blackhole engine in MySQL, you can create a table as follows:

```sql
CREATE TABLE example_table (
    id INT,
    value VARCHAR(100)
) ENGINE=BLACKHOLE;
```

This table creation command will create a table that accepts data but doesn't store it. It's important to understand that while the Blackhole engine is useful in specific scenarios, it's not suitable for general-purpose data storage due to its inherent characteristic of not storing data.

## Transactions

A database transaction is a single execution of the database where multiple data operations are carried out and written as a whole.

- Ensure consistency
- Allows recovery on error
- Useful for testing
- Essential for same industries(bank, e-commerce)

⇒ MongoDB does not give ACID compliance so instructors do not recommend it for e-commerce, it’s strengths are sharding, document data presentation, dashboard, log

1. Initiate the transaction
2. Perform create, read, update, or delete operations
3. if successful, **commit** the transaction.
4. Alternatively, **rollback** the transaction.

```sql
START TRANSACTION;

INSERT INTO users(name, email) VALUES ('John Deo', 'johndeo@example.com');
UPDATE accounts SET balance = 5000 WHERE user_id = 15;

COMMIT; 
```

⇒ MySQL does transactions at temp space and then commits it to the main disk space if the transaction is successful. Should give enough RAM to MySQL.

⇒ Monitoring tool setup for detecting synchronization off, and replication off.

⇒ 1 master node and 3 slave nodes and the master node gets down if we do this by clustering then MySQL will make one as the master node this why for this setup we need at least 3 nodes and if did manually set then have to make one node as master manually and will have downtime.

⇒ MySQL router for load-balancing SQL node.

⇒ master-master used for

- For e-commerce,
- Used for write load balancing

⇒ master-slave used for

- Backup: If the physical disk or the container containing the MySQL database crashed then if we had a raid then we can get data back but will take time. So if any reason master gets lost then we can use the slave. Have to do write on master must and can read from slave first then master for the faster read operation.

⇒ connection

- Multiple connections can make applications faster.
- persistence connection

⇒ batch insertion in MongoDB is not atomic in MySQL this is also not atomic should use transaction for atomicity.

⇒ No-SQL gives eventual consistency but in SQL it is consistency. This means that the update operation No-SQL will confirm success after retrieving the data not after successfully running the operation but in the SQL it will retrieve and update data and then will tell the operation completed successfully. Although in milliseconds operation will done(if have a low load and with enough hardware) in No-SQL and 98% time it will not be a problem. In a No-SQL database for e-commerce get an order and decrease the stock quantity from 100 to 80 but if another connection tries to get the stock quantity at that moment it could get the stock quantity as 100 eventually in milliseconds it will be updated to 80. That is why banks always use SQL.










# Denormalization

Denormalization is the process of adding redundancy to a database to improve the read performance.

- Avoid complex relation chain
    - With the cost of redundancy
- Improve read performance
    - And risking data integrity

Imagine an LMS Requirement

<img src="../images/Advanced_Concepts/img.png" alt="img" style="zoom:50%;" />

Source: [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)

## Some common scenarios

### Improving Query Performance

Keep some redundant data / reference for faster retrieval (based on data access pattern)

### Reporting and Data Warehousing

Create denormalized tables(or materialized views) that combines and pre-aggregate relevant data.

### Caching Frequently Accessed Data

Duplicate frequently accessed data in a separate, flat table to avoid complex joins and real-time aggregations.

### Improve Analytical Ability

Keep reference of connected entities in multiple levels to empower critical, on-demand analysis with efficiency.

## Power and Responsibilty

- The key is to strike a balance between the benefits of normalization and the performance improvements that denormalization can provide.
- Carefully analyze the specific data access patterns and performance requirements of your application before deciding to denormalize.

## Reference vs Snapshot

We have to make the designation a snapshot as it is a letter if a person’s designation change we do not need to change it on the letter.Another this price of a product in the invoice should take the price as a snapshot as if product price increase or decreases we can not change the price on the invoice which is already paided by customer. it is curtial for ecommerce.

<img src="../images/Advanced_Concepts/img2.webp" alt="img2" style="zoom:50%;" />

Source: [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)

## JSON

```sql
CREATE TABLE webhooks (
	id INT(11) NOT NULL AUTO_INCREMENT,
	source VARCHAR(50) NOT NULL,
	body JSON NULL,
	PRIMARY KEY (id)
);
```

<img src="../images/Advanced_Concepts/img3.webp" alt="img3" style="zoom:50%;" />

Source: [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)

```sql
SELECT body -> '$.Subjet'
FROM webhooks;
```

<img src="../images/Advanced_Concepts/img4.webp" alt="img4" style="zoom:50%;" />

<img src="../images/Advanced_Concepts/img5.webp" alt="img3" style="zoom:50%;" />

<img src="../images/Advanced_Concepts/img6.webp" alt="img3" style="zoom:50%;" />

Source: [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)

### UseCase

- To check what I give to third-party API and what they send with date and time.
- To keep a log. ⇒ Purge policy. No-SQL best fit for it.

<img src="../images/Advanced_Concepts/img7.png" alt="img3" style="zoom:50%;" />

Source: [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)

recovery when database table replaced by mistake ⇒ InnoDB

import topic for interview

⇒ syntax

⇒ schema design after showing dashboard

⇒ extract data from schema design

⇒ join

⇒ subquery

⇒ aggregate

⇒ grouping, ordering

# References
- [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)
