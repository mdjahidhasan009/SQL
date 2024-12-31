# Study Topics (Self-Learning)

## Data Management
- **Data Purging**
- **Data Partitioning**
- **Whole Database Refactoring** (e.g., schema updates)
- **Partitioning, Sharding, Purging, Transactions, and Locking**

## VPS Management
- **Database VPS Management**
- **PTL (Data Extraction and Import)**

## Advanced Database Concepts
- **SQL Sharding**
    - Handling nodes and fault tolerance
- **Flag Table or Report Table**
    - Used for report generation

## Optimizations and Indexing
- **Generated Columns**
- **Handling Auto-Increment with Multiple Database Servers**
    - Use master-slave database architecture:
        - **Master Server:** Handles all write operations.
        - **Slave Server:** Handles read operations.
    - Avoid auto-increment conflicts in distributed setups. Has multiple master servers where data is written.
- **Foreign Key Indexing**
    - Indexes are automatically created for foreign keys.
- **Composite Indexing**
    - If a search is frequently performed on three columns, create an index combining those columns for better performance.

## Search Optimization
- **Blog Post Search Example**
    - For large datasets (e.g., 2 million blog posts):
        - Use a search tool like **Solr** to find relevant blog post IDs.
        - Perform further queries on the main database using these IDs.


# References
- [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)
