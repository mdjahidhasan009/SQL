# DELETE
The `DELETE` statement is used to delete records from a table.

## Delete all rows
Omitting a `WHERE` clause will delete all rows from a table.
```sql
DELETE FROM Employees
```
See `TRUNCATE` documentation for details on how `TRUNCATE` performance can be better because it ignores triggers and
indexes and logs to just delete the data.

## Delete certain rows with `WHERE`
This will delete all rows that match the `WHERE` criteria.
```sql
DELETE FROM Employees
WHERE FName = 'John`;
```

## TRUNCATE clause
Use this to reset the table to the condition at which it was created. This deletes all rows and resets values such as
auto-increment. It also doesn't log each individual row deletion.

```sql
TRANCATE TABLE Employee;
```

# Delete Certain Rows Based on Comparisons with Other Tables

It is possible to delete data from a table if it matches (or mismatches) certain data in other tables. This approach is commonly used to maintain data consistency and clean up source tables after processing.

## Basic Delete Scenario

Let's assume we want to delete data from `Source` once it's loaded into `Target`.

```sql
DELETE FROM Source 
WHERE EXISTS (
    SELECT 1  -- specific value in SELECT doesn't matter
    FROM Target
    WHERE Source.ID = Target.ID
);
```

Most common RDBMS implementations (e.g., MySQL, Oracle, PostgreSQL, Teradata) allow tables to be joined during `DELETE`, allowing more complex comparisons in a compact syntax.

## Adding Complexity

Let's add complexity to the original scenario. Suppose `Aggregate` is built from `Target` once a day and does not contain the same ID but contains the same date. Assume that we want to delete data from `Source` only after the aggregate is populated for the day.

### MySQL, Oracle, and Teradata Example

This operation can be performed using:

```sql
DELETE FROM Source
WHERE Source.ID = Target.ID
      AND Target.Date = Aggregate.Date;
```

### PostgreSQL Example

In PostgreSQL, use:

```sql
DELETE FROM Source
USING Target, Aggregate
WHERE Source.ID = Target.ID
      AND Target.Date = Aggregate.AggDate;
```

## MySQL Example with Table Creation and Data Insertion

### Step 1: Create Tables

```sql
-- Creating the Source table
CREATE TABLE Source (
    ID INT PRIMARY KEY,
    Data VARCHAR(50),
    Date DATE
);

-- Creating the Target table
CREATE TABLE Target (
    ID INT PRIMARY KEY,
    Data VARCHAR(50),
    Date DATE
);

-- Creating the Aggregate table
CREATE TABLE Aggregate (
    AggID INT PRIMARY KEY AUTO_INCREMENT,
    AggData VARCHAR(50),
    AggDate DATE
);
```

### Step 2: Insert Sample Data

```sql
-- Insert data into Source table
INSERT INTO Source (ID, Data, Date) VALUES
(1, 'Source Data 1', '2024-09-20'),
(2, 'Source Data 2', '2024-09-21'),
(3, 'Source Data 3', '2024-09-22');

-- Insert data into Target table
INSERT INTO Target (ID, Data, Date) VALUES
(1, 'Target Data 1', '2024-09-20'),
(4, 'Target Data 4', '2024-09-21');

-- Insert data into Aggregate table
INSERT INTO Aggregate (AggData, AggDate) VALUES
('Aggregate Data 1', '2024-09-20'),
('Aggregate Data 2', '2024-09-21');
```

### Step 3: Deleting Data Based on Comparisons
First get the data to be deleted from the source table.
```sql
-- Select data from Source that would match the DELETE criteria
SELECT Source.*
FROM Source
JOIN Target ON Source.ID = Target.ID
JOIN Aggregate ON Target.Date = Aggregate.AggDate;
+----+---------------+------------+
| ID | Data          | Date       |
+----+---------------+------------+
|  1 | Source Data 1 | 2024-09-20 |
+----+---------------+------------+
1 row in set (0.01 sec)
```

And currently the source table has the following data.
```sql
mysql> SELECT * FROM Source;
+----+---------------+------------+
| ID | Data          | Date       |
+----+---------------+------------+
|  1 | Source Data 1 | 2024-09-20 |
|  2 | Source Data 2 | 2024-09-21 |
|  3 | Source Data 3 | 2024-09-22 |
+----+---------------+------------+
3 rows in set (0.00 sec)
```

```sql
-- Delete rows from Source that have matching IDs in Target and matching Dates in Aggregate
DELETE Source
FROM Source
JOIN Target ON Source.ID = Target.ID
JOIN Aggregate ON Target.Date = Aggregate.AggDate;
```

### Step 4: Verify the Deletion

```sql
-- Verify that the rows have been deleted
SELECT * FROM Source;
+----+---------------+------------+
| ID | Data          | Date       |
+----+---------------+------------+
|  2 | Source Data 2 | 2024-09-21 |
|  3 | Source Data 3 | 2024-09-22 |
+----+---------------+------------+
2 rows in set (0.00 sec)

-- Verify that the rows still exist in Target and Aggregate
SELECT * FROM Target;
+----+---------------+------------+
| ID | Data          | Date       |
+----+---------------+------------+
|  1 | Target Data 1 | 2024-09-20 |
|  4 | Target Data 4 | 2024-09-21 |
+----+---------------+------------+
2 rows in set (0.00 sec)

SELECT * FROM Aggregate;
+--------+---------------+------------+
| AggID  | AggData       | AggDate    |
+--------+---------------+------------+
|      1 | Aggregate Data 1 | 2024-09-20 |
|      2 | Aggregate Data 2 | 2024-09-21 |
+--------+---------------+------------+
2 rows in set (0.00 sec)
```

### Explanation

1. **Table Creation**: Three tables are created: `Source`, `Target`, and `Aggregate`, each holding related data with `ID` or `Date` relationships.
2. **Data Insertion**: Sample data is inserted into each table to demonstrate the deletion logic.
3. **Delete Operation**: The `DELETE` command removes rows from `Source` based on comparisons with the `Target` and `Aggregate` tables.

## Summary

- Deletion based on comparisons with other tables allows for flexible and powerful data management.
- MySQL, Oracle, and Teradata offer a similar syntax for direct comparisons.
- PostgreSQL provides the `USING` clause to simplify multi-table deletions.