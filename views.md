
## Simple Views

A view can filter some rows from the base table or project only some columns from it:

```sql
CREATE VIEW new_employees_details AS
SELECT E.id, Fname, Salary, Hire_date
FROM Employees E
WHERE hire_date > DATE '2015-01-01';
```

If you select from the view:
```sql
SELECT * FROM new_employees_details;
```
| Id  | FName       | Salary | Hire_date    |
|-----|-------------|--------|--------------|
| 4   | Johnathon   | 500    | 2016-07-24   |

### Table Creation and Data Insertion
```sql
-- Creating the Employees table
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    Fname VARCHAR(50),
    Salary INT,
    Hire_date DATE,
    DepartmentId INT
);

-- Inserting data into Employees table
INSERT INTO Employees (id, Fname, Salary, Hire_date, DepartmentId) VALUES
(1, 'Alice', 700, '2014-06-15', 1),
(2, 'Bob', 800, '2015-05-20', 2),
(3, 'Charlie', 650, '2013-03-10', 1),
(4, 'Johnathon', 500, '2016-07-24', 2);
```

## Complex Views

A view can be a really complex query (aggregations, joins, subqueries, etc.). Just be sure you add column names for
everything you select:

```sql
CREATE VIEW dept_income AS
SELECT d.Name AS DepartmentName, SUM(e.salary) AS TotalSalary
FROM Employees e
JOIN Departments d ON e.DepartmentId = d.id
GROUP BY d.Name;
```

Now you can select from it as from any table:
```sql
SELECT * FROM dept_income;
```

| DepartmentName | TotalSalary |
|----------------|-------------|
| HR             | 1900        |
| Sales          | 600         |

### Table Creation and Data Insertion
```sql
-- Creating the Departments table
CREATE TABLE Departments (
    id INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Inserting data into Departments table
INSERT INTO Departments (id, Name) VALUES
(1, 'HR'),
(2, 'Sales');
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)