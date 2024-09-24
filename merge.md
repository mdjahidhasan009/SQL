# MERGE (UPSERT) in SQL

`MERGE` (often also called UPSERT for "UPDATE or INSERT") allows you to INSERT new rows or, if a row already exists, UPDATE the existing row. The purpose is to perform the entire set of operations atomically (to guarantee data consistency) and to prevent communication overhead for multiple SQL statements in a client/server system.

## MERGE to Make Target Match Source

**Example for SQL Server**

```sql
MERGE INTO targetTable t
    USING sourceTable s
        ON t.PKID = s.PKID
    WHEN MATCHED AND NOT EXISTS (
            SELECT s.ColumnA, s.ColumnB, s.ColumnC
            INTERSECT
            SELECT t.ColumnA, t.ColumnB, s.ColumnC
            )
        THEN UPDATE SET
            t.ColumnA = s.ColumnA,
            t.ColumnB = s.ColumnB,
            t.ColumnC = s.ColumnC
    WHEN NOT MATCHED BY TARGET
        THEN INSERT (PKID, ColumnA, ColumnB, ColumnC)
        VALUES (s.PKID, s.ColumnA, s.ColumnB, s.ColumnC)
    WHEN NOT MATCHED BY SOURCE
        THEN DELETE;
```

### Explanation:
- **USING**: Specifies the source table `s` that is compared against the target table `t`.
- **ON**: Defines the matching condition between the source and target tables (`t.PKID = s.PKID`).
- **WHEN MATCHED AND NOT EXISTS**: Updates the target table only when the source and target rows differ. The `INTERSECT` clause compares the rows, allowing nullable columns to be handled properly.
- **WHEN NOT MATCHED BY TARGET**: Inserts new rows into the target table when no match is found in the target.
- **WHEN NOT MATCHED BY SOURCE**: Deletes rows from the target that do not exist in the source.

## MySQL Equivalent: INSERT ... ON DUPLICATE KEY UPDATE

In MySQL, the `MERGE` command is not supported, but similar functionality can be achieved using `INSERT ... ON DUPLICATE KEY UPDATE`. Below is an example demonstrating this concept.

### MySQL Example

### Step 1: Create the Tables

```sql
CREATE TABLE targetTable (
    PKID INT PRIMARY KEY,
    ColumnA VARCHAR(50),
    ColumnB VARCHAR(50),
    ColumnC VARCHAR(50)
);

CREATE TABLE sourceTable (
    PKID INT PRIMARY KEY,
    ColumnA VARCHAR(50),
    ColumnB VARCHAR(50),
    ColumnC VARCHAR(50)
);
```

### Step 2: Insert Sample Data

```sql
-- Insert initial data into targetTable
INSERT INTO targetTable (PKID, ColumnA, ColumnB, ColumnC) VALUES
(1, 'Value1', 'Value2', 'Value3'),
(2, 'OldValueA', 'OldValueB', 'OldValueC');

-- Insert initial data into sourceTable
INSERT INTO sourceTable (PKID, ColumnA, ColumnB, ColumnC) VALUES
(1, 'Value1', 'Value2', 'Value3'), -- Matching row
(2, 'NewValueA', 'NewValueB', 'NewValueC'), -- Updated values
(3, 'NewRow1', 'NewRow2', 'NewRow3'); -- New row to be inserted
```

### Step 3: Using INSERT ... ON DUPLICATE KEY UPDATE in MySQL

```sql
-- Add ON DUPLICATE KEY UPDATE functionality in MySQL
INSERT INTO targetTable (PKID, ColumnA, ColumnB, ColumnC)
SELECT PKID, ColumnA, ColumnB, ColumnC FROM sourceTable
ON DUPLICATE KEY UPDATE
    ColumnA = VALUES(ColumnA),
    ColumnB = VALUES(ColumnB),
    ColumnC = VALUES(ColumnC);

-- Handling deletions: Deleting rows not found in the source
DELETE FROM targetTable
WHERE PKID NOT IN (SELECT PKID FROM sourceTable);
```

### Explanation:

1. **Table Creation**: Two tables are created (`targetTable` and `sourceTable`) with identical structures.
2. **Data Insertion**: Sample data is inserted into both tables to simulate matching, updating, and insertion scenarios.
3. **Insert/Update**: The `INSERT ... ON DUPLICATE KEY UPDATE` command handles updating existing rows and inserting new ones.
4. **Delete**: The `DELETE` command removes rows in the target that are not present in the source, mimicking the `WHEN NOT MATCHED BY SOURCE THEN DELETE` functionality.

## MySQL: Counting Users by Name

Suppose we want to know how many users have the same name. Let us create a table `users` as follows:

```sql
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(8),
    count INT,
    UNIQUE KEY name(name)
);
```

Now, we just discovered a new user named Joe and would like to take him into account. To achieve that, we need to determine whether there is an existing row with his name, and if so, update it to increment `count`; otherwise, create it.

MySQL uses the following syntax: `INSERT ... ON DUPLICATE KEY UPDATE ...`. In this case:

```sql
INSERT INTO users (name, count)
    VALUES ('Joe', 1)
    ON DUPLICATE KEY UPDATE count = count + 1;
```

### Explanation of MySQL Command:
- If a row with the same `name` already exists (e.g., `'Joe'`), the new value will not be inserted. Instead, the existing row's `count` will be updated by incrementing it by `1`.
- This approach avoids inserting duplicate rows and instead updates the count of existing rows that match the unique key constraint.

## PostgreSQL: Counting Users by Name

Suppose we want to know how many users have the same name. Let us create a table `users` as follows:

```sql
CREATE TABLE users (
    id SERIAL,
    name VARCHAR(8) UNIQUE,
    count INT
);
```

Now, we just discovered a new user named Joe and would like to take him into account. To achieve that, we need to determine whether there is an existing row with his name, and if so, update it to increment `count`; otherwise, create it.

PostgreSQL uses the following syntax: `INSERT ... ON CONFLICT ... DO UPDATE ...`. In this case:

```sql
INSERT INTO users (name, count)
    VALUES ('Joe', 1)
    ON CONFLICT (name) DO UPDATE SET count = users.count + 1;
```

## Summary

- **SQL Server**: Uses the `MERGE` command to UPDATE, INSERT, or DELETE records based on matching criteria.
- **MySQL**: Uses `INSERT ... ON DUPLICATE KEY UPDATE` to handle insert or update operations when a unique key constraint is violated, updating the existing row if necessary.
- **PostgreSQL**: Uses `INSERT ... ON CONFLICT ... DO UPDATE` to perform UPSERT operations.
- **Consistency**: These approaches ensure data consistency by updating, inserting, or deleting rows to synchronize the source and target data.

## Sources
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)