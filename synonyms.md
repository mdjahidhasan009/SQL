
## Create Synonym

### Overview
A synonym is a database object that serves as an alias for another database object, such as a table, view, or stored procedure.
Synonyms are often used to simplify SQL code by providing a shorter or more meaningful name for an object or to provide a layer of abstraction.

### SQL Server Example
The following SQL creates a synonym named `EmployeeData` for the `Employees` table in the `MyDatabase` database:

```sql
-- Creating a sample Employees table
CREATE TABLE MyDatabase.dbo.Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50)
);

-- Inserting sample data into Employees table
INSERT INTO MyDatabase.dbo.Employees (EmployeeID, FirstName, LastName, Department) VALUES
(1, 'John', 'Doe', 'HR'),
(2, 'Jane', 'Smith', 'IT'),
(3, 'Michael', 'Johnson', 'Finance');

-- Creating a synonym for the Employees table
CREATE SYNONYM EmployeeData
FOR MyDatabase.dbo.Employees;
```

### Using the Synonym
Once the synonym is created, you can use `EmployeeData` as if it were the `Employees` table:

```sql
-- Selecting data using the synonym
SELECT * FROM EmployeeData;
```

### MySQL Equivalent
MySQL does not directly support synonyms. However, similar functionality can be achieved using Views. Below is an example:

```sql
-- Creating a sample Employees table in MySQL
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50)
);

-- Inserting sample data into Employees table
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department) VALUES
(1, 'John', 'Doe', 'HR'),
(2, 'Jane', 'Smith', 'IT'),
(3, 'Michael', 'Johnson', 'Finance');

-- Creating a view to act as a synonym in MySQL
CREATE VIEW EmployeeData AS
SELECT * FROM Employees;
```

### Using the View in MySQL
```sql
-- Selecting data using the view as a synonym
SELECT * FROM EmployeeData;
```

### Key Points
- **Synonyms** in SQL Server allow for simplified and more manageable SQL code by providing alternative names for database objects.
- **Views** in MySQL can be used as an alternative to synonyms, providing similar functionality.
- Synonyms and views both help in abstracting and managing access to underlying database objects.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)