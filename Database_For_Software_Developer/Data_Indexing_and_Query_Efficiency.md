////TODO:
- write ⇒ exclusive lock no query at this time
- select ⇒ shared lock


# Indexing

A database index is like an index in a book. It helps MySQL find data faster.

For an index, a database creates a separate table with index data and a column to refer to this record with the original 
table. Indexes generally use a B+ tree.

Index on `shipment_type` column:

<img src="../images/Data_Indexing_and_Query_Efficiency/img.webp" alt="Index on shipment_type column" />

Source: [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)

**Why Use Indexes?**

- Significantly speeds up data operations.
- Improves the performance of joining, searching, and analytical operations.
- Essential for enhancing performance on large databases.

---

## Types of Index

### Primary Index
- Represents the primary key.
- **Characteristics:**
    - Always a unique index.
    - Cannot contain `NULL` values.
    - A table always has one primary key, even if not explicitly declared.

### Secondary Index
- Any index that is not the primary key.
- Any number of secondary keys may exist in a table.
- Always refers back to the original record using the primary key of that table. As the original table is sorted by the 
  primary key this is the fastest way to find any data in the main table.
- We have two types of secondary index by the perspective of uniqueness
    - Unique Index
    - Non-Unique Index
- We have two types of secondary index by the perspective of the data structure or how we use/build the index
    - Functional Index
    - Full Text Index



## Primary Key

**Characteristics:**
- A unique and `NOT NULL` index.
- A table will have a primary key even if not explicitly declared and it will be a hidden column. Table will use that 
  column to refer to the record.
- The primary key index sorts the column of the primary key.
- A single table can only have one primary key.

**Data Type Recommendations for Primary Keys:**
- `CHAR`/`VARCHAR` columns.
- `UUID`/`ULID`.
- `INT`/`BIGINT` (with `UNSIGNED` for optimal performance).

**Key Points for Consideration:**
- **Redundancy:** The size of the primary key affects storage and secondary indexes.
- **Update Cost:** Adding more indexes increases update costs since all associated indexes must also be updated.
- **Index Re-balancing:** Re-balancing B-trees during updates can be resource-intensive.

**Best Practices:**
- Use `BIGINT UNSIGNED AUTO_INCREMENT` for primary keys to maintain order and reduce indexing costs.
- Use `UUID` for distributed systems requiring sharding or unique IDs across databases.

### Index Update and Storage Considerations

### Index Update Behavior

When a table has indexes on columns `x`, `y`, `z`, and a primary key `id`, the following occurs during **update** or 
**insert** operations:

- **Updating columns (`x`, `y`, or `z`):**
    - Only the specific index related to the updated column (`x`, `y`, or `z`) is updated.
- **Inserting new rows:**
    - All indexes (`index-x`, `index-y`, `index-z`) must be updated to include the new row.
- **Updating the primary key (`id`):**
    - All secondary indexes (`index-x`, `index-y`, `index-z`) need to be updated because they store a copy of the 
      primary key as a reference to the main table.

In all **secondary indexes**, the primary key is included as a reference to locate the full row in the main table.

### Key Considerations When Using Indexes

1. **Redundancy (Storage Concerns):**
    - Keeping the primary key small reduces storage requirements in the main table and all secondary indexes.
    - Larger primary keys lead to increased size for all associated indexes and negatively impact performance.
2. **Cost of Update:**
    - Each additional index increases the cost of update operations because:
        - Updates need to modify the main table and all relevant indexes.
        - Index updates may require **exclusive locks**, blocking other operations and impacting concurrency.
3. **Re-balancing B-Trees:**
    - Inserting or updating indexed data can require the B-Tree structure to re-balance, which is computationally
      expensive.
4. **Obfuscation of IDs:**
    - If IDs need to be obfuscated (e.g., for security or privacy), consider using `UUID` or a similar approach. However:
        - Avoid using `UUID` as the primary key due to its lack of sequential order, which makes indexing costly.
        - Use `BIGINT UNSIGNED AUTO_INCREMENT` for the primary key for better performance since it maintains sequential
          order.

---

### Handling UUIDs

- **Best Practice:**
    - Use `BIGINT UNSIGNED AUTO_INCREMENT` as the primary key for large ranges and efficient indexing.
    - If sharding or distributed databases are required, use `UUID` as the primary key to minimize the risk of 
      duplicates.
- **Alternative Approach:**
    - Maintain a mapping table to associate `UUID` with the original primary key for scenarios where `UUID` is required
      but performance must be optimized.


      
## Planning Indexes

MySQL evaluates whether using an index or scanning the full table is more efficient for a query. So it may or may not
use the index if it thinks that scanning the full table is more efficient.

### Key Considerations:
1. **Avoid Functions in WHERE Clause:**
   ```sql
   SELECT * FROM products WHERE YEAR(created_at) > '2022' LIMIT 10;
   ```
   If the `created_at` column has an index, this query will not utilize it due to the `YEAR()` function.
2. **Data Access Patterns:**
    - Analyze query patterns, including sorting, grouping, and joining.
    - Consider using composite indexes for multi-column queries.
3. **Wildcards and Indexing:**
    - `LIKE 'prefix%'` will use the index.
    - `LIKE '%suffix'` will not use the index.
    - `LIKE 'prefix%suffix'` may partially use the index for `prefix` it will use the index but for `suffix` it will not
      use the index.
4. **Multiple Conditions in WHERE Clause:**
    - Example:
      ```sql
      WHERE shipment_type = 'physical' AND stock_quantity > 10
      ```
    - If only `shipment_type` has an index, MySQL will filter rows for `shipment_type = 'physical'` first, then apply 
      the condition on `stock_quantity`.
    - If both columns have indexes, MySQL will choose the index with higher cardinality (number of unique values) to 
      filter data efficiently. It may not use both indexes.
5. **Indexes in Joins:**
    - When joining tables, both columns involved in the join condition should have an index for optimal performance.
    - Example:
      ```sql
      SELECT *
      FROM orders
      JOIN customers ON orders.customer_id = customers.id;
      ```
        - Indexes on `orders.customer_id` and `customers.id` will make the query faster.
    - If one of the columns is a primary key, the query will perform even faster since primary keys are indexed by 
      default.
6. **Handling Large Offsets:**
    - For queries with a large `OFFSET`, indexes may not be used efficiently.
    - Example:
      ```sql
      SELECT * FROM products ORDER BY created_at LIMIT 10 OFFSET 10000;
      ```
    - Here, the query skips the first 10,000 rows and then orders the rest, making the use of the index suboptimal. This
      approach is computationally expensive and may lead to performance issues.
7. Understanding NULL in the Extra Column
   - When you have an index on the `name` column, the following query may not fully utilize the index:
      ```sql
      EXPLAIN
      SELECT * FROM products WHERE name = 'vero ut dicta';
      ```
   - **Reason:**
       - In the `possible_keys` column, `name` is listed as an index.
       - However, in the `Extra` column, it shows `NULL`. This occurs because the `name` index table contains only the `name` column and the primary key (`id`).
       - To retrieve all other column data, MySQL needs to access the main table, which prevents the query from fully utilizing the index.
   ![EXPLAIN Query Example - NULL Extra](../images/Data_Indexing_and_Query_Efficiency/img2.webp)
   Source: [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)


8. Using Index with SELECT Name or ID
   - If the query only requests the `name` or `id` (or both), MySQL can retrieve the data directly from the index without accessing the main table:
      ```sql
      EXPLAIN
      SELECT name, id FROM products WHERE name = 'vero ut dicta';
      ```
   - **Why This Works:**
       - The index contains all necessary data (`name` and `id`), so the main table lookup is unnecessary.
       - In this case, the `Extra` column will show `Using index`.

   - **Optimization Tip:**
       - If you frequently query a small set of columns (e.g., 4-5 columns), consider creating a composite index that includes these columns. This can eliminate the need to access the main table for such queries.

   ![EXPLAIN Query Example - Using Index](../images/Data_Indexing_and_Query_Efficiency/img3.webp)
   ![EXPLAIN Query Example - Composite Index 1](../images/Data_Indexing_and_Query_Efficiency/img4.webp)
   ![EXPLAIN Query Example - Composite Index 2](../images/Data_Indexing_and_Query_Efficiency/img5.webp)
   Source: [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)


## Where to Add Index

#### Key Considerations
1. **Observe Data-Access Patterns (Retrieve Queries):**
    - Analyze how the application retrieves data from the database means which query runs frequently add index those 
      table if needed.
    - Identify frequently used queries and the columns involved in filtering (`WHERE` clauses), sorting (`ORDER BY`),
      grouping (`GROUP BY`), and joining.
2. **Consider All Queries and Access Patterns:**
    - Ensure the indexing strategy supports all critical queries efficiently.
    - For example, if multiple queries filter on `name` or `date`, adding indexes on these columns could speed up 
      performance.
3. **Consider the Entire Query:**
    - Don't focus only on the `WHERE` clause. Indexing can also optimize:
        - **Sorting:** (`ORDER BY` clauses).
        - **Grouping:** (`GROUP BY` clauses).
        - **Joining:** Queries involving foreign key relationships.

#### SQL Commands Example

The following commands demonstrate how to work with indexes in SQL:

```sql
CREATE TABLE categories LIKE dokan.categories;
INSERT INTO categories SELECT * FROM dokan.categories;

ALTER TABLE products ADD INDEX (name);
```

##### Command Breakdown
- `CREATE TABLE categories LIKE dokan.categories`:
    - Creates a new table with the same structure as `dokan.categories`.
- `INSERT INTO categories SELECT * FROM dokan.categories`:
    - Copies all rows from `dokan.categories` into the new `categories` table.
- `ALTER TABLE products ADD INDEX (name)`:
    - Adds an index on the `name` column of the `products` table, improving query performance for operations involving
      this column.

#### Why These Steps Matter

- Indexes improve query performance but come with overhead (e.g., storage and update costs). These steps ensure indexes
  are only added where they will have the most impact.
- For example:
    - Adding an index on `name` improves searches like:
      ```sql
      SELECT * FROM products WHERE name = 'Sample Product';
      ```
    - However, unnecessary indexes (on rarely queried columns) waste resources and slow down write operations (e.g., `INSERT` and `UPDATE`).






### Index Optimization in Queries
- For queries like:
   ```sql
   SELECT * FROM products WHERE name = 'some_name';
   ```
  MySQL may not use the index optimally if the query retrieves all columns.

  However, this query:
   ```sql
   SELECT name, id FROM products WHERE name = 'some_name';
   ```
  retrieves data only from the index table and avoids accessing the main table.

- Use composite indexes for frequently accessed columns to avoid main table lookups.

---

## Practical Considerations

### Effects of Updates:
- **Updating a Primary Key:**
    - Requires updating all associated secondary indexes.
- **Updating Secondary Index Columns:**
    - Updates only the specific secondary index.

### Balancing Indexes:
- Avoid creating too many indexes to minimize update costs.
- Use indexes judiciously based on query performance analysis.

---

## Index Management

### SQL Commands:
```sql
CREATE TABLE categories LIKE source_table.categories;
INSERT INTO categories SELECT * FROM source_table.categories;

ALTER TABLE products ADD INDEX (name);
```

### Using `EXPLAIN`:
```sql
EXPLAIN SELECT * FROM products WHERE name = 'specific_name';
```

- If the `Extra` column shows `NULL`, it means the query requires accessing the main table.
- If it shows `Using index`, it indicates the query retrieves data solely from the index.

---

# References
- [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)


