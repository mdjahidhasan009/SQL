# `NULL`
`NULL` in SQL, as well as programming in general, means literally "nothing". In SQL, it is easier to understand as "the
absence of any value".

It is important to distinguish it from seemingly empty values, such as the empty string `''` or the number `0`, neither
of which are actually `NULL`.

It is also important to be careful not to enclose `NULL` in quotes, like `'NULL'`, which is allowed in columns that 
accept text, but is not `NULL` and can cause errors and incorrect data sets.

## Filtering for NULL in SQL Queries

In SQL, `NULL` represents the absence of a value, and filtering for `NULL` values in `WHERE` clauses requires special 
handling because `NULL` is not considered equal to anything, not even itself.

### Syntax for Filtering `NULL`
To check if a column contains `NULL` or does not contain `NULL`, you need to use the `IS NULL` or `IS NOT NULL` 
operators, respectively.

### Examples

#### 1. Filtering for `NULL`
```sql
SELECT * FROM Employees WHERE ManagerId IS NULL;
```
This query selects all rows from the `Employees` table where the `ManagerId` column has no value (i.e., is `NULL`).

#### 2. Filtering for Non-`NULL`
```sql
SELECT * FROM Employees WHERE ManagerId IS NOT NULL;
```
This query selects all rows where the `ManagerId` column contains a value (i.e., is not `NULL`).

## Why Not Use Equality Operators for `NULL`?
In SQL, using comparison operators like `=`, `<>` (not equal), or `!=` with `NULL` does not work as expected. `NULL` is 
not considered equal or not equal to any value, including itself. Therefore:
- `NULL = NULL` is `UNKNOWN` (not `TRUE`).
- `NULL != NULL` or `NULL <> NULL` is also `UNKNOWN`.

### Example:
```sql
SELECT * FROM Employees WHERE ManagerId = NULL;  -- This will not work as expected!
SELECT * FROM Employees WHERE ManagerId <> NULL; -- This will not work as expected!
```
Both queries will return no rows because the comparisons yield `UNKNOWN`, and the `WHERE` clause filters out rows where the condition is either `FALSE` or `UNKNOWN`.

### Why `<> NULL` Does Not Return All Rows:
It might seem like using `<> NULL` should return all rows, since `NULL` is not equal to anything. However, in SQL, 
**any comparison with `NULL` results in `UNKNOWN`**, not `TRUE` or `FALSE`.

Therefore:
- `ManagerId <> NULL` does not evaluate to `TRUE` for any rows.
- Instead, it evaluates to `UNKNOWN` for all rows, and the `WHERE` clause only returns rows where the condition is 
- `TRUE`. Rows where the condition is `FALSE` or `UNKNOWN` are excluded.

## Key Points:
1. **Use `IS NULL` or `IS NOT NULL`**:
    - Always use `IS NULL` to filter for rows where a column has a `NULL` value.
    - Use `IS NOT NULL` to filter for rows where a column has a value (i.e., is not `NULL`).

2. **`NULL` in Comparisons**:
    - Comparisons with `NULL` using `=`, `<>`, or `!=` result in `UNKNOWN`, which is treated as `FALSE` in `WHERE`
      clauses.
    - The `WHERE` clause keeps only rows where the condition is `TRUE`.

## Conclusion:
When filtering for `NULL` values in SQL queries, always use `IS NULL` or `IS NOT NULL` in `WHERE` conditions. Avoid 
using equality (`=`), inequality (`<>` or `!=`) operators with `NULL` because they will not behave as expected.

## Nullable columns in tables
When creating tables it is possible to declare a column as nullable or non-nullable.
```sql
CREATE TABLE MyTable
(
    MyCol1 INT NOT NULL, -- non-nullable
    MyCol2 INT NULL,     -- nullable
);
```
By default, every column (except those in primary key constraint) is nullable unless we explicitly set `NOT NULL`
constraint.

Attempting to assign `NULL` to a non-nullable column will result in an error.
```sql
INSERT INTO MyTable(MyCol1, MyCol2) VALUES (1, null) -- works fine
```
```sql
INSERT INTO MyTable(MyCol1, MyCol2) VALUES (null, 2);
        -- can not insert
        -- the value NULL into column 'MyCol1' table 'MyTable'
        -- column does not allow nulls. INSERT fails.
```
```
INSERT INTO MyTable (MyCol1, MyCol2) VALUES (1, NULL) ;
-- works fine
INSERT INTO MyTable (MyCol1, MyCol2) VALUES (NULL, 2) ;
-- cannot insert
-- the value NULL into column 'MyCol1', table 'MyTable';
-- column does not allow nulls. INSERT fails.
```

## Updating ﬁelds to NULL
Setting a field to `NULL` works exactly like with any other value:
```sql
UPDATE EMPLOYEE
SET Manager = NULL
WHERE Id = 4
```

## Inserting rows with `NULL` ﬁelds
For example inserting an employee with no phone number and no manager into the Employees example table:
```sql
INSERT INTO Employee
(Id, FName, LName, PhoneNumber, ManagerId, DepartmentId, Salary, HireDate)
VALUES
(5, 'Jane', 'Doe', NULL, NULL, 2, 800, '2016-07-22')
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)