
## CREATE TRIGGER

Triggers are database objects that are automatically executed or fired when certain events occur. This example creates
a trigger that inserts a record into a second table (`MyAudit`) after a record is inserted into the table the trigger is defined on (`MyTable`).
In SQL Server, the `inserted` and `deleted` tables are special tables used to store affected rows during `INSERT`, `UPDATE`, and `DELETE` statements.

### SQL Server Example
```sql
-- Create the MyTable table
CREATE TABLE MyTable (
    MyTableId INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Create the MyAudit table
CREATE TABLE MyAudit (
    MyTableId INT,
    UserName VARCHAR(50)
);

-- Insert initial data into MyTable
INSERT INTO MyTable (MyTableId, Name) VALUES (1, 'Sample');

-- Create the trigger on MyTable
CREATE TRIGGER MyTrigger
    ON MyTable
    AFTER INSERT
AS
BEGIN
    -- Insert audit record to MyAudit table
    INSERT INTO MyAudit(MyTableId, UserName)
    SELECT MyTableId, CURRENT_USER FROM inserted;
END;

-- Test the trigger by inserting data into MyTable
INSERT INTO MyTable (MyTableId, Name) VALUES (2, 'Another Sample');

-- Check the MyAudit table to see the trigger effect
SELECT * FROM MyAudit;
```

### MySQL Equivalent
MySQL does not have `inserted` and `deleted` tables. Instead, you can directly reference the `NEW` and `OLD` pseudo-tables in triggers.

```sql
-- Create the MyTable table
CREATE TABLE MyTable (
    MyTableId INT PRIMARY KEY,
    Name VARCHAR(50)
);

-- Create the MyAudit table
CREATE TABLE MyAudit (
    MyTableId INT,
    UserName VARCHAR(50)
);

-- Insert initial data into MyTable
INSERT INTO MyTable (MyTableId, Name) VALUES (1, 'Sample');

-- Create the trigger on MyTable
DELIMITER //

CREATE TRIGGER MyTrigger
AFTER INSERT ON MyTable
FOR EACH ROW
BEGIN
    -- Insert audit record to MyAudit table
    INSERT INTO MyAudit (MyTableId, UserName)
    VALUES (NEW.MyTableId, USER());
END; //

DELIMITER ;

-- Test the trigger by inserting data into MyTable
INSERT INTO MyTable (MyTableId, Name) VALUES (2, 'Another Sample');

-- Check the MyAudit table to see the trigger effect
SELECT * FROM MyAudit;
```

## Use Trigger to Manage a "Recycle Bin" for Deleted Items

Triggers can also be used to manage a "recycle bin" by capturing deleted records into another table.

### SQL Server Example
```sql
-- Create the Books table
CREATE TABLE MyBooksDB.Books (
    BookId INT PRIMARY KEY,
    Title VARCHAR(100)
);

-- Create the BooksRecycleBin table
CREATE TABLE MyBooksDB.BooksRecycleBin (
    BookId INT,
    Title VARCHAR(100)
);

-- Insert initial data into Books table
INSERT INTO MyBooksDB.Books (BookId, Title) VALUES (1, 'SQL Mastery');

-- Create the trigger to capture deleted rows
CREATE TRIGGER BooksDeleteTrigger
    ON MyBooksDB.Books
    AFTER DELETE
AS
    INSERT INTO MyBooksDB.BooksRecycleBin
        SELECT * FROM deleted;
GO

-- Test the trigger by deleting data from Books table
DELETE FROM MyBooksDB.Books WHERE BookId = 1;

-- Check the BooksRecycleBin to see the deleted record
SELECT * FROM MyBooksDB.BooksRecycleBin;
```

### MySQL Equivalent
```sql
-- Create the Books table
CREATE TABLE Books (
    BookId INT PRIMARY KEY,
    Title VARCHAR(100)
);

-- Create the BooksRecycleBin table
CREATE TABLE BooksRecycleBin (
    BookId INT,
    Title VARCHAR(100)
);

-- Insert initial data into Books table
INSERT INTO Books (BookId, Title) VALUES (1, 'SQL Mastery');

-- Create the trigger to capture deleted rows
DELIMITER //

CREATE TRIGGER BooksDeleteTrigger
AFTER DELETE ON Books
FOR EACH ROW
BEGIN
    INSERT INTO BooksRecycleBin (BookId, Title)
    VALUES (OLD.BookId, OLD.Title);
END; //

DELIMITER ;

-- Test the trigger by deleting data from Books table
DELETE FROM Books WHERE BookId = 1;

-- Check the BooksRecycleBin to see the deleted record
SELECT * FROM BooksRecycleBin;
```

---

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)