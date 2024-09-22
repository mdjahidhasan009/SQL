
# SQL Pagination Techniques with Examples

## Overview
Pagination in SQL is used to limit the number of rows returned by a query and to skip rows, allowing results to be split 
across multiple pages. This is essential for handling large datasets efficiently, especially in web applications.

## Limiting the Number of Results

### ISO/ANSI SQL:
```sql
SELECT * FROM Employees FETCH FIRST 20 ROWS ONLY;
```

### MySQL, PostgreSQL, SQLite:
```sql
SELECT * FROM Employees LIMIT 20;
```

### Oracle:
```sql
SELECT Id, Name
FROM (
    SELECT Id, Name, row_number() over (order by Id) RowNumber
    FROM Employees
)
WHERE RowNumber <= 20;
```

### SQL Server:
```sql
SELECT TOP 20 * FROM Employees;
```

## Example Scenario

### Table Creation and Data Insertion

**Creating a Sample Table:**
```sql
CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    Name VARCHAR(50)
);
```

**Inserting Sample Data:**
```sql
INSERT INTO Employees (Id, Name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David'),
(5, 'Eva'),
(6, 'Frank'),
(7, 'Grace'),
(8, 'Hannah'),
(9, 'Ivy'),
(10, 'Jack'),
(11, 'Kate'),
(12, 'Leo'),
(13, 'Mia'),
(14, 'Nick'),
(15, 'Olivia'),
(16, 'Paul'),
(17, 'Quinn'),
(18, 'Rose'),
(19, 'Steve'),
(20, 'Tina'),
(21, 'Uma'),
(22, 'Victor'),
(23, 'Wendy'),
(24, 'Xander'),
(25, 'Yara');
```

## Skipping and Taking Some Results (Pagination)

### ISO/ANSI SQL:
```sql
SELECT Id, Name
FROM Employees
ORDER BY Id
OFFSET 20 ROWS FETCH NEXT 20 ROWS ONLY;
```

### MySQL:
```sql
SELECT * FROM Employees LIMIT 20, 20; -- offset, limit
```

### Oracle; SQL Server:
```sql
SELECT Id, Name
FROM (
    SELECT Id, Name, row_number() over (order by Id) RowNumber
    FROM Employees
)
WHERE RowNumber BETWEEN 21 AND 40;
```

### PostgreSQL; SQLite:
```sql
SELECT * FROM Employees LIMIT 20 OFFSET 20;
```

## Skipping Some Rows from Results

### ISO/ANSI SQL:
```sql
SELECT Id, Name
FROM Employees
ORDER BY Id
OFFSET 20 ROWS;
```

### MySQL:
```sql
SELECT * FROM Employees LIMIT 20, 42424242424242; -- skips 20, large limit to cover all rows
```

### Oracle:
```sql
SELECT Id, Name
FROM (
    SELECT Id, Name, row_number() over (order by Id) RowNumber
    FROM Employees
)
WHERE RowNumber > 20;
```

### PostgreSQL:
```sql
SELECT * FROM Employees OFFSET 20;
```

### SQLite:
```sql
SELECT * FROM Employees LIMIT -1 OFFSET 20;
```

## Conclusion
These techniques are used to efficiently manage and navigate through large datasets by limiting and skipping rows. Each 
SQL dialect offers different methods for pagination, and understanding these can help optimize query performance and 
application responsiveness.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)