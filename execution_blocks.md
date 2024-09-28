
## Using BEGIN ... END

The `BEGIN ... END` statement is used to group multiple SQL statements into a single transaction block. This allows you 
to execute a set of operations atomically, meaning all the operations within the block will either succeed together or
fail together.

### Example Usage

```sql
BEGIN
    UPDATE Employees SET PhoneNumber = '5551234567' WHERE Id = 1;
    UPDATE Employees SET Salary = 650 WHERE Id = 3;
END
```

In this example, two `UPDATE` statements are wrapped inside a `BEGIN ... END` block, ensuring that both updates are
executed as part of a single transaction.

### Creating the Employees Table and Inserting Data

```sql
-- Creating the Employees table
CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    PhoneNumber VARCHAR(15),
    Salary DECIMAL(10, 2)
);

-- Inserting data into Employees table
INSERT INTO Employees (Id, FName, LName, PhoneNumber, Salary) VALUES
(1, 'John', 'Doe', '5551231234', 600),
(2, 'Jane', 'Smith', '5559876543', 700),
(3, 'Alice', 'Johnson', '5551112222', 500);
```

### MySQL Equivalent

In MySQL, the `BEGIN ... END` block is used within stored procedures or triggers. However, if you are executing these
statements outside of such contexts, you can use `START TRANSACTION` instead of `BEGIN`. Here’s how it would look in 
MySQL:

```sql
START TRANSACTION;
    UPDATE Employees SET PhoneNumber = '5551234567' WHERE Id = 1;
    UPDATE Employees SET Salary = 650 WHERE Id = 3;
COMMIT;
```

The `START TRANSACTION` statement begins a transaction block, and the `COMMIT` statement finalizes it, making the 
changes permanent.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)