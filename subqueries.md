
## Subquery in FROM clause
A subquery in a FROM clause acts similarly to a temporary table that is generated during the execution of a query
and lost afterwards.

### Example Data
Table: `Employees`
```sql
CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    Salary DECIMAL(10, 2),
    ManagerId INT
);

-- Inserting data into Employees table
INSERT INTO Employees (Id, FName, LName, Salary, ManagerId) VALUES
(1, 'John', 'Doe', 60000, NULL),
(2, 'Jane', 'Smith', 75000, 1),
(3, 'Sara', 'Johnson', 55000, 1),
(4, 'Michael', 'Brown', 80000, NULL);
```

### Query Example
```sql
SELECT Managers.Id, Employees.Salary
FROM (
    SELECT Id
    FROM Employees
    WHERE ManagerId IS NULL
) AS Managers
JOIN Employees ON Managers.Id = Employees.Id;
+----+----------+
| Id | Salary   |
+----+----------+
|  1 | 60000.00 |
|  4 | 80000.00 |
+----+----------+
2 rows in set (0.00 sec)
```

## Subquery in SELECT clause
```sql
-- Creating Cars and Customers tables
CREATE TABLE Customers (
    Id INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50)
);

CREATE TABLE Cars (
    Id INT PRIMARY KEY,
    CustomerId INT,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
);

-- Inserting data into Customers and Cars tables
INSERT INTO Customers (Id, FName, LName) VALUES
(1, 'Alice', 'Green'),
(2, 'Bob', 'Blue'),
(3, 'Charlie', 'Red');

INSERT INTO Cars (Id, CustomerId) VALUES
(1, 1),
(2, 1),
(3, 2);

-- Query
SELECT
    Id,
    FName,
    LName,
    (SELECT COUNT(*) FROM Cars WHERE Cars.CustomerId = Customers.Id) AS NumberOfCars
FROM Customers;
+------+---------+-------+--------------+
| Id   | FName   | LName | NumberOfCars |
+------+---------+-------+--------------+
|    1 | Alice   | Green |            2 |
|    2 | Bob     | Blue  |            1 |
|    3 | Charlie | Red   |            0 |
+------+---------+-------+--------------+
3 rows in set (0.01 sec)
```

## Subquery in WHERE clause
Use a subquery to filter the result set. For example, this will return all employees with a salary equal to the highest
paid employee.

```sql
SELECT *
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees);
+----+---------+-------+----------+-----------+
| Id | FName   | LName | Salary   | ManagerId |
+----+---------+-------+----------+-----------+
|  4 | Michael | Brown | 80000.00 |      NULL |
+----+---------+-------+----------+-----------+
1 row in set (0.00 sec)
```

## Correlated Subqueries
Correlated (also known as Synchronized or Coordinated) Subqueries are nested queries that make references to
the current row of their outer query:

```sql
SELECT Id
FROM Employees AS eOuter
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees eInner
    WHERE eInner.ManagerId = eOuter.ManagerId
);
+----+
| Id |
+----+
|  2 |
+----+
```

## Filter query results using query on different table
This query selects all employees not on the Supervisors table.

### Example Data
Table: `Supervisors`
```sql
CREATE TABLE Supervisors (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Inserting data into Supervisors table
INSERT INTO Supervisors (EmployeeID, Name) VALUES
(1, 'John Doe');
```

### Queries
```sql
SELECT *
FROM Employees
WHERE Id NOT IN (SELECT EmployeeID FROM Supervisors);
+----+---------+---------+----------+-----------+
| Id | FName   | LName   | Salary   | ManagerId |
+----+---------+---------+----------+-----------+
|  2 | Jane    | Smith   | 75000.00 |         1 |
|  3 | Sara    | Johnson | 55000.00 |         1 |
|  4 | Michael | Brown   | 80000.00 |      NULL |
+----+---------+---------+----------+-----------+
3 rows in set (0.00 sec)
```

The same results can be achieved using a LEFT JOIN.

```sql
SELECT *
FROM Employees AS e
LEFT JOIN Supervisors AS s ON s.EmployeeID = e.Id
WHERE s.EmployeeID IS NULL;
+----+---------+---------+----------+-----------+------------+------+
| Id | FName   | LName   | Salary   | ManagerId | EmployeeID | Name |
+----+---------+---------+----------+-----------+------------+------+
|  2 | Jane    | Smith   | 75000.00 |         1 |       NULL | NULL |
|  3 | Sara    | Johnson | 55000.00 |         1 |       NULL | NULL |
|  4 | Michael | Brown   | 80000.00 |      NULL |       NULL | NULL |
+----+---------+---------+----------+-----------+------------+------+
3 rows in set (0.00 sec)
```

## Subqueries in WHERE clause
The following example finds cities whose population is below the average temperature (obtained via a subquery).

### Example Data
Table: `Cities`
```sql
CREATE TABLE Cities (
    name VARCHAR(50),
    pop2000 INT
);

-- Inserting data into Cities table
INSERT INTO Cities (name, pop2000) VALUES
('San Francisco', 776733),
('ST LOUIS', 348189),
('Kansas City', 146866),
('New York', 8008278);
```

### Query
```sql
SELECT name, pop2000 FROM Cities
WHERE pop2000 < (SELECT AVG(pop2000) FROM Cities);
+---------------+---------+
| name          | pop2000 |
+---------------+---------+
| San Francisco |  776733 |
| ST LOUIS      |  348189 |
| Kansas City   |  146866 |
+---------------+---------+
3 rows in set (0.00 sec)
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)