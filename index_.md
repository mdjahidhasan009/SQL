# Indexes
Indexes are a data structure that contains pointers to the contents of a table arranged in a specific order, to help
the database optimize queries. They are similar to the index of book, where the pages (rows of the table) are indexed by
their page number.

Several types of indexes exist, and can be created on a table. When an index exists on the columns used in a
queries `WHERE` clause, `JOIN` clause, or `ORDER BY` clause, it can substantially improve query performance.

## Sorted Index
If you use an index that is sorted the way you would retrieve it, the SELECT statement would not do additional sorting
when in retrieval.
```sql
-- Creating a sorted index on the 'score' column in descending order
CREATE INDEX ix_scoreboard_score ON scoreboard(score DESC);
```
When you execute the query
```sql
SELECT * FROM scoreboard ORDER BY score DESC;
```
The database system would not do additional sorting, since it can do an index-lookup in that order.

## Partial or Filtered Index
SQL Server and SQLite allow to create indexes that contain not only a subset of columns, but also a subset of rows.

Consider a constant growing amount of orders with order_state_id equal to finished (2), and a stable amount of orders
with `order_state_id` equal to started (1).

If you're business make use of queries like this:
```sql
SELECT id, comment
    FROM orders
WHERE order_state_id = 1
    AND product_id = @some_value;
```
Partial indexing allows you to limit the index, including only the unfinished orders:
```sql
CREATE INDEX Started_Orders
        ON orders(product_id)
    WHERE order_state_id = 1;
```
This index will be smaller than an unfiltered index, which saves space and reduces the cost of updating the index.


### Partial or Filtered Index in MySQL
`MySQL` does not support partial or filtered indexes directly, unlike `SQL Server` or `SQLite`, which allow indexes that 
include only a subset of rows based on a specific condition (`WHERE` clause). Partial indexes save space and reduce 
update costs by indexing only the relevant data.

#### MySQL Workarounds:
1. **Generated Columns**:
    - Use generated columns to create conditions similar to filtered indexes.
    - Example:
      ```sql
      -- Add a generated column is_started based on the order_state_id value
      -- 1 for started orders, 0 for others
      ALTER TABLE orders 
      ADD COLUMN is_started TINYINT(1) GENERATED ALWAYS AS (order_state_id = 1);
 
      -- Create an index on the generated column and product_id
      CREATE INDEX idx_started_orders ON orders(product_id, is_started);
      ```
    - This approach helps `MySQL` optimize queries involving the filtered condition.

2. **Indexed Views**:
    - Create a view with the filtered data and index it (limited support in MySQL).

3. **Separate Tables**:
    - Split frequently queried subsets into separate tables to reduce the indexing overhead.

#### Key Points:
- **MySQL’s Limitation**: No direct partial index support; relies on workarounds.
- **Performance Gains**: Generated columns can guide the optimizer to improve query performance.
- **Trade-offs**: Workarounds may increase maintenance costs compared to true filtered indexes.

These methods help achieve similar benefits as partial indexes in MySQL, improving performance for specific query
patterns.

## Creating an Index
```sql
CREATE INDEX ix_cars_employee_id ON Cars (EmployeeId);
```
This will create an index for the column EmployeeId in the table Cars. This index will improve the speed of queries
asking the server to sort or select by values in EmployeeId, such as the following:
```sql
SELECT * FROM Cars WHERE EmployeeId = 1;
```
The index can contain more than 1 column, as in the following;
```sql
CREATE INDEX ix_cars_e_c_o_ids ON Cars (EmployeeId, CarId, OwnerId);
```
In this case, the index would be useful for queries asking to sort or select by all included columns, if the set of
conditions is ordered in the same way. That means that when retrieving the data, it can ﬁnd the rows to retrieve
using the index, instead of looking through the full table.

For example, the following case would utilize the second index;
```sql
SELECT * FROM Cars WHERE EmployeeId = 1 Order By CardId DESC;
```
If the order differs, however, the index does not have the same advantages, as in the following;
```sql
SELECT * FROM Cars WHERE OwnerId = 17 Order by CarId DESC
```
The index is not as helpful because the database must retrieve the entire index, across all values of EmployeeId and
CarID, in order to find which items have OwnerId = 17.

(The index may still be used; it may be the case that the query optimizer finds that retrieving the index and filtering
on the OwnerId, then retrieving only the needed rows is faster than retrieving the full table, especially if the table is
large.)

## Dropping an Index
```sql
DROP INDEX ix_cars_employee_id ON Cars;
```
We can use command `DROP` to delete our index. In this example we will `DROP` the index called `ix_cars_employee_id` on
the table `Cars`.

This deletes the index entirely, and if the index is clustered, will remove any clustering. It cannot be rebuilt without
recreating the index, which can be slow and computationally expensive. 

## Index Disabling and Rebuilding it
The index can be disabled:

```sql
ALTER INDEX ix_cars_employee_id ON Cars DISABLE;
```
This allows the table to retain the structure, along with the metadata about the index.

Critically, this retains the index statistics, so that it is possible to easily evaluate the change. If warranted, the index
can then later be rebuilt, instead of being recreated completely;
```sql
ALTER INDEX ix_cars_employee_id ON Cars REBUILD;
```

### Index Disabling and Rebuilding in MySQL
MySQL does not support disabling indexes directly. To achieve similar results, you can drop and recreate the index:

```sql
-- Drop the index
DROP INDEX ix_cars_employee_id ON Cars;

-- Recreate the index
CREATE INDEX ix_cars_employee_id ON Cars (EmployeeId);
```

This approach is similar to disabling and rebuilding an index in other databases. Dropping and recreating the index
ensures that the index is rebuilt from scratch, which can help resolve fragmentation issues.

Also, we can use `OPTIMIZE TABLE` to rebuild the index:
```sql
OPTIMIZE TABLE Cars;
```
This command reorganizes the table and rebuilds all indexes, which can help improve performance by reducing fragmentation.


## Clustered
Indexes can have several characteristics that can be set either at creation, or by altering existing indexes.
```sql
CREATE CLUSTERED INDEX ix_clust_employee_id ON Employees(EmployeeId, Email);
```

The above SQL statement creates a new clustered index on `Employees`. Clustered indexes are indexes that dictate
the actual structure of the table; the table itself is sorted to match the structure of the index. That means there can
be at most one clustered index on a table. If a clustered index already exists on the table, the above statement will
fail. (Tables with no clustered indexes are also called heaps.)

##  Unique Index

```sql
CREATE UNIQUE INDEX uq_customers_email ON Customers(Email);
```
This will create a unique index for the column `Email` in the table `Customers`. This index, along with speeding up
queries like a normal index, will also force every email address in that column to be unique. If a row is inserted or
updated with a non-unique `Email` value, the insertion or update will, by default, fail.

```sql
CREATE UNIQUE INDEX ix_eid_desc ON Customers(EmployeeID);
```
This creates an index on `Customers` which also creates a table constraint that the `EmployeeID` must be unique.
(This will fail if the column is not currently unique - in this case, if there are employees who share an ID.)


## Sorted Indexes
```sql
CREATE INDEX ix_eid_desc ON Customers(EmployeeID Desc);
``` 
This creates an index that is sorted in descending order. By default, indexes (in MSSQL server, at least) are
ascending, but that can be changed.

## Rebuild index
Over the course of time B-Tree indexes may become fragmented because of updating/deleting/inserting data. In
SQLServer terminology we can have internal (index page which is half empty ) and external (logical page order
doesn't correspond physical order). Rebuilding index is very similar to dropping and re-creating it.

We can re-build an index with

**SQL Server**
```sql
ALTER INDEX index_name REBUILD;
```

**MySQL**

In MySQL, we can use `OPTIMIZE TABLE` to rebuild the all indexes of a table. Can not rebuild a single index in MySQL.
```sql
-- Rebuild indexes and optimize the table
OPTIMIZE TABLE table_name;
```

By default, rebuilding index is offline operation which locks the table and prevents `DML` against it , but many RDBMS
allow online rebuilding. Also, some DB vendors offer alternatives to index rebuilding such as `REORGANIZE`
(SQLServer) or COALESCE/SHRINK SPACE(Oracle).

## Inserting with a Unique Index
```sql
UPDATE Customers SET Email = "richard0123@example.com" WHERE id = 1;
```
This will fail if a unique index is set on the Email column of Customers. However, alternate behavior can be defined
for this case:
```sql
INSERT INTO Customers (id, Email) 
VALUES (1, 'richard0123@example.com')
ON DUPLICATE KEY UPDATE Email = 'richard0123@example.com';
```

#### Scenario 1: Unique Constraint on id Column
* If a row with id = `1` already exists, the `ON DUPLICATE KEY UPDATE` clause will trigger because the id column’s unique
  constraint is violated.
* The query will update the `Email` column of the row with id = `1` to `'richard0123@example.com'`.
#### Scenario 2: Unique Constraint on Email Column
  * If a row with a different id but the same Email (`'richard0123@example.com'`) already exists, and there's a unique \
    constraint on the `Email` column, the `ON DUPLICATE KEY UPDATE` clause will still trigger because of the conflict on
    the Email.
  * `MySQL` will attempt to update the row with the conflicting `Email` rather than inserting a new one, which might 
    lead to unintended behavior or an error depending on how the constraints are set and the exact conditions of the query.

In both case, it is updating the row with the conflicting value, rather than inserting a new row. This can lead to
unexpected behavior if the constraints are not set up correctly. Also, it will not update primary key column. Will only
update the columns that are not part of the unique constraint. For this reason, for scenario 1 and 2, the query will
update the `Email` column of the row with id = `1` to.


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)