ALTER command in SQL is used to modify column/constraint in a table

## Add Column(s)
```sql
ALTER TABLE Employees 
ADD StartingDate date NOT NULL DEFAULT GetData(),
    DateOfBirth date NULL
```
The above statement would add columns named StartingDate which cannot be NULL with default value as current
date and DateOfBirth which can be NULL in Employees table.

## Drop Column
```sql
ALTER TABLE Employees
DROP COLUMN salary;
```
This will not only delete information from that column, but will drop the column salary from table employees(the
column will no more exist).

## Add Primary Key
```sql
ALTER TABLE EMPLOYEES ADD pk_EmployeeID PRIMARY KEY (ID);
```
This will add a Primary key to the table Employees on the ﬁeld ID. Including more than one column name in the
parentheses along with ID will create a Composite Primary Key. When adding more than one column, the column
names must be separated by commas.
```sql
ALTER TABLE EMPLOYEES ADD pk_EmployeeID PRIMARY KEY(ID, FName);
```

## Alter Column
```sql
ALTER TABLE Employees
ALTER COLUMN StartingDate DATETIME NOT NULL DEFAULT (GETDATE())
```
This query will alter the column datatype of StartingDate and change it from simple date to datetime and set
default to current date.

## Drop Constraint
```sql
ALTER TABLE Employees
DROP CONSTRAINT DefaultSalary
```
This Drops a constraint called DefaultSalary from the employees table deﬁnition.

**Note:** Ensure that constraints of the column are dropped before dropping a column.


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)