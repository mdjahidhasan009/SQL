# `NULL`
`NULL` in SQL, as well as programming in general, means literally "nothing". In SQL, it is easier to understand as "the
absence of any value".

It is important to distinguish it from seemingly empty values, such as the empty string `''` or the number `0`, neither
of which are actually `NULL`.

It is also important to be careful not to enclose `NULL` in quotes, like `'NULL'`, which is allowed in columns that accept
text, but is not `NULL` and can cause errors and incorrect data sets.

## Filtering for NULL in queries
The syntax for ﬁltering for `NULL` (i.e. the absence of a value) in `WHERE` blocks is slightly diﬀerent than ﬁltering for
speciﬁc values.
```sql
SELECT * FROM Employees WHERE ManagerId IS NULL ;
SELECT * FROM Employees WHERE ManagerId IS NOT NULL ;
```
Note that because `NULL` is not equal to anything, not even to itself, using equality operators = `NULL` or `<>` `NULL` (or
`!= NULL`) will always yield the `truth` value of `UNKNOWN` which will be rejected by `WHERE`.
`WHERE` ﬁlters all rows that the condition is `FALSE` or `UNKNOWN` and keeps only rows that the condition is `TRUE`.

## Nullable columns in tables
When creating tables it is possible to declare a column as nullable or non-nullable.
```sql
CREATE TABLE MyTable
(
    MyCol1 INT NOT NULL, -- non-nullable
    MyCol2 INT NULL,     -- nullable
);
```
By default every column (except those in primary key constraint) is nullable unless we explicitly set `NOT NULL`
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
INSERT INTO MyTable (MyCol1, MyCol2) VALUES (1, NULL) ;
-- works fine
INSERT INTO MyTable (MyCol1, MyCol2) VALUES (NULL, 2) ;
-- cannot insert
-- the value NULL into column 'MyCol1', table 'MyTable';
-- column does not allow nulls. INSERT fails.

## Updating ﬁelds to NULL
Setting a ﬁeld to `NULL` works exactly like with any other value:
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