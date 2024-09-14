# SQL Constraints
Constraints are used to set rules for all records in the table. If any constraints get violated then it can abort the
action that caused it.

Constraints are defined while creating the table using the `CREATE TABLE` statement or added later using the `ALTER TABLE` 
statement.

There are 5 major constraints are used in SQL, such as
### `NOT NULL`
That indicates that the column must have some value and cannot be left null.

### `UNIQUE`
This constraint is used to ensure that each row and column has unique value and no value is being repeated in any row or
column.

### `PRIMARY KEY`
This constraint is used in association with `NOT NULL` and `UNIQUE` constraints such as on one or the combination of more
than one column to identify the particular record with a unique identify. A table can have only one primary key that
consists of single or multiple fields.

### `FOREIGN KEY`
It is used to ensure the referential integrity of data in the table and also matches the value in one table with another
using primary key.

### `CHECK`
It is used to ensure whether the value in columns fulfills the specified condition. We can limit the values or type of
data that can be stored in a column. They are used to enforce domain integrity.

```sql
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,          -- PRIMARY KEY constraint (NOT NULL is implied)
    name VARCHAR(100) NOT NULL,      -- NOT NULL constraint for the name field
    email VARCHAR(255) UNIQUE,       -- UNIQUE constraint
    age INT CHECK (age >= 18),       -- CHECK constraint
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)  -- FOREIGN KEY constraint
);
```

```sql
ALTER TABLE Employees
ADD name VARCHAR(100) NOT NULL;
```