ALTER command in SQL is used to modify column/constraint in a table

## Add Column(s)
Syntax:
```sql
ALTER TABLE table_name
ADD column_name datatype;
```
Example:
```sql
ALTER TABLE Employees 
ADD StartingDate date NOT NULL DEFAULT GetData(),
    DateOfBirth date NULL
```
The above statement would add columns named `StartingDate` which cannot be `NULL` with default value as current date and
`DateOfBirth` which can be `NULL` in Employees table.

## Drop Column
Syntax:
```sql
ALTER TABLE table_name
DROP COLUMN column_name;
```
Example:
```sql
ALTER TABLE Employees
DROP COLUMN salary;
```
This will not only delete information from that column, but will drop the column salary from table employees(the
column will no more exist).

## Add Primary Key
Syntax:
```sql
ALTER TABLE table_name
ADD pk_column_name PRIMARY KEY(column_name);
```
Example:
```sql
ALTER TABLE EMPLOYEES 
ADD pk_EmployeeID PRIMARY KEY (ID);
```
This will add a Primary key to the table `Employees` on the field `ID`. Including more than one column name in the
parentheses along with `ID` will create a Composite Primary Key. When adding more than one column, the column
names must be separated by commas.
```sql
ALTER TABLE EMPLOYEES ADD pk_EmployeeID PRIMARY KEY(ID, FName);
```

## Alter Column
Syntax:
```sql
ALTER TABLE table_name
ALTER COLUMN column_name datatype;
```
Example:
```sql
ALTER TABLE Employees
ALTER COLUMN StartingDate DATETIME NOT NULL DEFAULT (GETDATE())
```
This query will alter the column datatype of StartingDate and change it from simple date to datetime and set default to 
current date.

## Drop Constraint
Syntax:
```sql
ALTER TABLE table_name
DROP CONSTRAINT constraint_name;
```
Example:
```sql
ALTER TABLE Employees
DROP CONSTRAINT DefaultSalary
```
This Drops a constraint called DefaultSalary from the employees table definition.

**Note:** Ensure that constraints of the column are dropped before dropping a column.


## Update (Rename) a Column

To rename a column in SQL, you use the `ALTER TABLE` command. The syntax varies depending on the SQL dialect you are
using.

### MySQL

In MySQL, use the `ALTER TABLE` command with the `CHANGE` keyword to rename a column. You must specify both the old
column name, the new column name, and the column's data type.

Syntax:
```
Example:
```sql
ALTER TABLE table_name
CHANGE old_column_name new_column_name data_type;
```

#### Example:
If you want to change the column name `FName` to `FirstName` in the `Employee` table:

```sql
ALTER TABLE Employee
CHANGE FName FirstName VARCHAR(35);
```

### SQL Server

In SQL Server, use the `sp_rename` stored procedure to rename a column.

```sql
EXEC sp_rename 'table_name.old_column_name', 'new_column_name', 'COLUMN';
```

#### Example:
To change `FName` to `FirstName` in the `Employee` table in SQL Server:

```sql
EXEC sp_rename 'Employee.FName', 'FirstName', 'COLUMN';
```

### PostgreSQL and Oracle

In PostgreSQL and Oracle, you use the `ALTER TABLE` command with the `RENAME COLUMN` clause.

```sql
ALTER TABLE table_name
RENAME COLUMN old_column_name TO new_column_name;
```

#### Example:
To change `FName` to `FirstName` in the `Employee` table:

```sql
ALTER TABLE Employee
RENAME COLUMN FName TO FirstName;
```

#### Summary:
- **MySQL**: Use `CHANGE` with `ALTER TABLE`.
- **SQL Server**: Use `sp_rename`.
- **PostgreSQL/Oracle**: Use `RENAME COLUMN` with `ALTER TABLE`.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)