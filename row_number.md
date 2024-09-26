
## Delete All But Last Record (1 to Many Table)
This SQL command deletes all records except the most recent one for each `ProjectID` in the `ProjectNotes` table using a
Common Table Expression (CTE) and `ROW_NUMBER()`.

**SQL Server**:
```sql
WITH cte AS (
    SELECT ProjectID,
        ROW_NUMBER() OVER (PARTITION BY ProjectID ORDER BY InsertDate DESC) AS rn
    FROM ProjectNotes
)
DELETE FROM cte WHERE rn > 1;    
```

**MySQL Equivalent**:
MySQL does not directly support CTEs with `DELETE`. Instead, you can use a subquery with `ROW_NUMBER()` in a derived table.

```sql
-- MySQL 8.0 and above
DELETE p 
FROM ProjectNotes p
JOIN (
    SELECT ProjectID, 
           ROW_NUMBER() OVER (PARTITION BY ProjectID ORDER BY InsertDate DESC) AS rn 
    FROM ProjectNotes
) AS cte ON p.ProjectID = cte.ProjectID AND p.InsertDate = cte.InsertDate
WHERE cte.rn > 1;
```

### Explanation:
- The `ROW_NUMBER()` function assigns a sequential number to rows within each partition of the result set, based on the
  `ORDER BY` clause.
- MySQL uses a subquery and joins for similar behavior.

---

## Row Numbers Without Partitions
Generate row numbers based on the specified order without any partitioning.

**SQL Server**:
```sql
SELECT
    ROW_NUMBER() OVER(ORDER BY Fname ASC) AS RowNumber,
    Fname,
    LName
FROM Employees;
```

**MySQL Equivalent**:
MySQL 8.0 and above supports `ROW_NUMBER()` with `OVER` for similar functionality.

```sql
-- MySQL 8.0 and above
SELECT
    ROW_NUMBER() OVER(ORDER BY Fname ASC) AS RowNumber,
    Fname,
    LName
FROM Employees;
```

---

## Row Numbers with Partitions
This command uses a partition criterion to group row numbering according to specific column values.

**SQL Server**:
```sql
SELECT
    ROW_NUMBER() OVER(PARTITION BY DepartmentId ORDER BY DepartmentId ASC) AS RowNumber,
    DepartmentId, Fname, LName
FROM Employees;
```

**MySQL Equivalent**:
MySQL 8.0 and above also supports partitioning with `ROW_NUMBER()`.

```sql
-- MySQL 8.0 and above
SELECT
    ROW_NUMBER() OVER(PARTITION BY DepartmentId ORDER BY DepartmentId ASC) AS RowNumber,
    DepartmentId, Fname, LName
FROM Employees;
```

### Explanation:
- **Row Numbers Without Partitions**: Numbers rows sequentially based on the order specified without any grouping.
- **Row Numbers with Partitions**: Groups rows by `DepartmentId` before assigning row numbers based on the specified 
  order.

### Key Points:
- **MySQL Compatibility**: MySQL 8.0+ fully supports `ROW_NUMBER()` and similar window functions, allowing the use of 
  partitions and ordering as in SQL Server.
- **CTEs and Deletes**: MySQL requires alternative approaches such as using derived tables or subqueries when dealing 
  with CTEs in `DELETE` operations.

These SQL features improve data manipulation and reporting efficiency, enabling precise control over row numbering and 
deletions in various contexts.


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)
