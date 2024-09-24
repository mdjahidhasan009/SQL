`UNION` keyword in SQL is used to combine to `SELECT` statement results without any duplicate. In order to use`UNION` and 
combine results both `SELECT` statement should have same number of column with same data type in
same order, but the length of column can be different.

## Basic `UNION` And `UNION ALL` query

Those are same for both MS SQL Server and MySQL
```sql
CREATE TABLE HR_EMPLOYEES (
    PersonID INT,
    LastName VARCHAR(30),
    FirstName VARCHAR(30),
    Position VARCHAR(30)
);

CREATE TABLE FINANCE_EMPLOYEES (
    PersonID INT,
    LastName VARCHAR(30),
    FirstName VARCHAR(30),
    Position VARCHAR(30)
);

-- Inserting some data
-- Insert data into HR_EMPLOYEES
INSERT INTO HR_EMPLOYEES (PersonID, LastName, FirstName, Position) VALUES
(1, 'Smith', 'John', 'manager'),
(2, 'Doe', 'Jane', 'assistant'),
(3, 'White', 'Alice', 'manager'),
(4, 'Smith', 'John', 'manager');  -- Duplicate on purpose for testing UNION behavior

-- Insert data into FINANCE_EMPLOYEES
INSERT INTO FINANCE_EMPLOYEES (PersonID, LastName, FirstName, Position) VALUES
(5, 'Brown', 'Emily', 'manager'),
(6, 'Smith', 'John', 'manager'),  -- Duplicate manager entry
(7, 'Miller', 'Jake', 'accountant'),
(8, 'Smith', 'John', 'manager');  -- Another duplicate
```
Let's say we want to extract the names of all the managers from our departments.

Using a `UNION` we can get all the employees from both `HR` and `Finance` departments, which hold the position of a manager 
also will remove duplicates from the result set. <br/>
This same query can be used in both MS SQL Server and MySQL.
```sql
SELECT  
    FirstName, LastName
FROM 
    HR_EMPLOYEES
WHERE 
    Position = 'manager'
UNION 
SELECT
    FirstName, LastName
FROM 
    FINANCE_EMPLOYEES
WHERE 
    Position = 'manager';
+-----------+----------+
| FirstName | LastName |
+-----------+----------+
| John      | Smith    |
| Alice     | White    |
| Emily     | Brown    |
+-----------+----------+
3 rows in set (0.00 sec)    
```
But it is recommended to use backticks(`` ` ``) or double quotes(`" "`) to wrap column names in MySQL, and square 
brackets(`[]`) in MS SQL Server.

**For MySQL**
```sql
...
WHERE 
    Position = `manager`
...
```
OR
```sql
...
WHERE 
    Position = "manager"
...
```

**For MS SQL Server**
```sql
...
WHERE 
    Position = [manager]
...
```

The `UNION` statement removes duplicate rows from the query results. 

Since it is possible to have people having the same Name and position in both departments. If we use `UNION ALL` then 
it will not remove duplicates from the result set. <br/>

If you want to use an alias for each output column, you can just put them in the first select statement, as follows:

This same query can be used in both MS SQL Server and MySQL.
```sql
SELECT
    FirstName as 'First Name', LastName as 'Last Name'
FROM
    HR_EMPLOYEES
WHERE
    Position = 'manager'
UNION ALL
SELECT
    FirstName, LastName
FROM
    FINANCE_EMPLOYEES
WHERE
    Position = 'manager';
+------------+-----------+
| First Name | Last Name |
+------------+-----------+
| John       | Smith     |
| Alice      | White     |
| John       | Smith     |
| Emily      | Brown     |
| John       | Smith     |
| John       | Smith     |
+------------+-----------+
6 rows in set (0.00 sec)    
```

## Simple explanation and Example
In simple terms:
* `UNION` joins 2 result sets while removing duplicates from the result set
* `UNION ALL` joins 2 result sets without attempting to remove duplicates

> One mistake many people make is to use a UNION when they do not need to have the duplicates removed. The additional 
> performance cost against large results sets can be very significant.

#### When you might need UNION
Suppose you need to filter a table against 2 different attributes, and you have created separate non-clustered
indexes for each column. A `UNION` enables you to leverage both indexes while still preventing duplicates.
```sql
SELECT C1, C2, C3 FROM Table1 WHERE C1 = @Param1
UNION
SELECT C1, C2, C3 FROM Table1 WHERE C2 = @Param2
```
This simplifies your performance tuning since only simple indexes are needed to perform these queries optimally.
You may even be able to get by with quite a bit fewer non-clustered indexes improving overall write performance
against the source table as well.

#### When you might need UNION ALL
Suppose you still need to filter a table against 2 attributes, but you do not need to filter duplicate records (either
because it doesn't matter or your data wouldn't produce any duplicates during the union due to your data model
design).
```sql
SELECT C1 FROM Table1
UNION ALL
SELECT C1 FROM Table2
```
This is especially useful when creating Views that join data that is designed to be physically partitioned across
multiple tables (maybe for performance reasons, but still wants to roll-up records). Since the data is already split,
having the database engine remove duplicates adds no value and just adds additional processing time to the queries.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)