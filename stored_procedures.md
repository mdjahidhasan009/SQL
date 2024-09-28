
## Create and Call a Stored Procedure

Stored procedures can be created through a database management GUI (e.g., SQL Server), or through a SQL statement as follows:

### SQL Server Example

```sql
-- Define a name and parameters
CREATE PROCEDURE Northwind.getEmployee
    @LastName nvarchar(50),
    @FirstName nvarchar(50)
AS

-- Define the query to be run
SELECT FirstName, LastName, Department
FROM Northwind.vEmployeeDepartment
WHERE FirstName = @FirstName AND LastName = @LastName
AND EndDate IS NULL;
```

### Calling the Procedure

```sql
EXECUTE Northwind.getEmployee N'Ackerman', N'Pilar';

-- Or
EXEC Northwind.getEmployee @LastName = N'Ackerman', @FirstName = N'Pilar';
GO

-- Or
EXECUTE Northwind.getEmployee @FirstName = N'Pilar', @LastName = N'Ackerman';
GO
```

### MySQL Equivalent

In MySQL, stored procedures can be created with a similar approach, but the syntax slightly differs:

### Creating the Stored Procedure in MySQL

```sql
-- Create the table structure
CREATE TABLE Employees (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    EndDate DATE
);

-- Insert sample data
INSERT INTO Employees (FirstName, LastName, Department, EndDate) VALUES
('Pilar', 'Ackerman', 'HR', NULL),
('John', 'Doe', 'IT', NULL),
('Jane', 'Smith', 'Sales', '2023-01-01');

-- Create the stored procedure
DELIMITER //
CREATE PROCEDURE getEmployee (IN LastName VARCHAR(50), IN FirstName VARCHAR(50))
BEGIN
    SELECT FirstName, LastName, Department
    FROM Employees
    WHERE FirstName = FirstName AND LastName = LastName AND EndDate IS NULL;
END //
DELIMITER ;
```

### Calling the Procedure in MySQL

```sql
CALL getEmployee('Ackerman', 'Pilar');
```

This example shows how stored procedures can be utilized to encapsulate SQL queries for reuse and abstraction. The procedure can be invoked with different parameters to fetch relevant data.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)