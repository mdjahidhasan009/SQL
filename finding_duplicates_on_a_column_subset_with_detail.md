## Students with Same Name and Date of Birth

This SQL command identifies students with the same first name, last name, and date of birth using a Common Table
Expression (CTE) and a Window Function to display duplicate rows side by side.

**SQL Server**:
```sql
WITH CTE (StudentId, Fname, LName, DOB, RowCnt) AS (
    SELECT StudentId, FirstName, LastName, DateOfBirth AS DOB, 
           SUM(1) OVER (PARTITION BY FirstName, LastName, DateOfBirth) AS RowCnt
    FROM tblStudent
)
SELECT * FROM CTE WHERE RowCnt > 1
ORDER BY DOB, LName;
```

### Explanation:
- The query uses a CTE called `CTE` to calculate the count of rows (`RowCnt`) for each group of students with the same
  `FirstName`, `LastName`, and `DateOfBirth`.
- The `SUM(1) OVER (PARTITION BY ...)` counts the number of occurrences for each combination of `FirstName`, `LastName`, 
  and `DateOfBirth`.
- The final `SELECT` statement retrieves rows where the count is greater than 1, indicating duplicates.

**MySQL Equivalent**:

MySQL 8.0 and above supports CTEs and window functions like `SUM()` with `OVER`, making it possible to run a similar 
query.

```sql
-- MySQL 8.0 and above
WITH CTE AS (
    SELECT StudentId, FirstName, LastName, DateOfBirth AS DOB, 
           SUM(1) OVER (PARTITION BY FirstName, LastName, DateOfBirth) AS RowCnt
    FROM tblStudent
)
SELECT * FROM CTE WHERE RowCnt > 1
ORDER BY DOB, LName;
```

### Explanation for MySQL:
- The MySQL query works the same way as the SQL Server version, using `WITH CTE` to create a temporary result set and 
  window functions to count duplicates.
- MySQL’s support for window functions in version 8.0 and above makes this possible.

### Key Points:
- **CTE and Window Functions**: Both SQL Server and MySQL 8.0+ support Common Table Expressions and window functions,
  making these operations efficient and readable.
- **Duplicate Detection**: This method is useful for finding duplicates based on specific columns in a dataset.

These SQL features enhance data analysis and reporting, providing a clear way to detect and view duplicates within 
datasets.


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)
