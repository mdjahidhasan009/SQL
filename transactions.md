
## Simple Transaction
A transaction is a sequence of SQL operations that are treated as a single unit of work. A transaction ensures that all operations
are completed successfully or none are applied, maintaining the integrity of the database.

### Example: Simple Transaction
```sql
-- Transaction in SQL Server
BEGIN TRANSACTION
    INSERT INTO DeletedEmployees (EmployeeID, DateDeleted, User)
        (SELECT 123, GetDate(), CURRENT_USER);
    DELETE FROM Employees WHERE EmployeeID = 123;
COMMIT TRANSACTION
```

### MySQL Equivalent
In MySQL, the syntax is similar, but `CURRENT_USER()` is used instead of `CURRENT_USER`.

```sql
-- Transaction in MySQL
START TRANSACTION;
    INSERT INTO DeletedEmployees (EmployeeID, DateDeleted, User)
        (SELECT 123, NOW(), CURRENT_USER());
    DELETE FROM Employees WHERE EmployeeID = 123;
COMMIT;
```

### Table Creation and Data Insertion
```sql
-- Creating Employees Table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    DateDeleted DATETIME,
    User VARCHAR(50)
);

-- Creating DeletedEmployees Table
CREATE TABLE DeletedEmployees (
    EmployeeID INT PRIMARY KEY,
    DateDeleted DATETIME,
    User VARCHAR(50)
);

-- Inserting Data into Employees Table
INSERT INTO Employees (EmployeeID, Name, DateDeleted, User) VALUES
(123, 'John Doe', NULL, 'admin');
```

## Rollback Transaction
When something fails in your transaction code and you want to undo it, you can rollback your transaction.

### Example: Rollback Transaction
```sql
-- Rollback in SQL Server
BEGIN TRY
    BEGIN TRANSACTION
        INSERT INTO Users (ID, Name, Age)
        VALUES (1, 'Bob', 24);

        DELETE FROM Users WHERE Name = 'Todd';
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION
END CATCH
```

### MySQL Equivalent
In MySQL, the `TRY...CATCH` block is not available. Instead, error handling can be achieved by checking for errors and conditionally rolling back.

```sql
-- Rollback in MySQL
START TRANSACTION;
    INSERT INTO Users (ID, Name, Age)
    VALUES (1, 'Bob', 24);

    DELETE FROM Users WHERE Name = 'Todd';
    
    -- Check for errors and rollback if necessary
    IF (SELECT ROW_COUNT()) = 0 THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;
```

### Table Creation and Data Insertion
```sql
-- Creating Users Table
CREATE TABLE Users (
    ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

-- Inserting Data into Users Table
INSERT INTO Users (ID, Name, Age) VALUES
(2, 'Todd', 30),
(3, 'Alice', 28);
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)