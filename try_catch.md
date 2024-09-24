# Transaction Handling in TRY/CATCH Blocks

This note explains how transactions work within `TRY/CATCH` blocks in SQL Server and MySQL, demonstrating rollback and
commit scenarios. The `TRY/CATCH` structure allows for error handling in T-SQL and MySQL, where the `CATCH` or `HANDLER`
block can handle exceptions and perform necessary actions like rolling back a transaction.

## Example 1: Rollback Due to Error

### SQL Server Version

In this example, the transaction will be rolled back due to an invalid datetime value in the second `INSERT` statement:

```sql
BEGIN TRANSACTION
BEGIN TRY
    INSERT INTO dbo.Sale (Price, SaleDate, Quantity)
    VALUES (5.2, GETDATE(), 1)
    
    -- This will cause an error due to an invalid date format
    INSERT INTO dbo.Sale (Price, SaleDate, Quantity)
    VALUES (5.2, 'not a date', 1)
    
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    -- Handle the error and roll back the transaction
    ROLLBACK TRANSACTION
    THROW  -- Re-throws the caught error to the calling environment
END CATCH
```

### MySQL Version

In MySQL, you can use the `DECLARE ... HANDLER` syntax to handle errors within transactions:

```sql
START TRANSACTION;
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error and roll back the transaction
        ROLLBACK;
    END;

    INSERT INTO Sale (Price, SaleDate, Quantity)
    VALUES (5.2, NOW(), 1);
    
    -- This will cause an error due to an invalid date format
    INSERT INTO Sale (Price, SaleDate, Quantity)
    VALUES (5.2, 'not a date', 1);
    
    COMMIT;
END;
```

### Key Points:
- The first `INSERT` executes successfully, but the second `INSERT` fails due to an invalid date format (`'not a date'`).
- The error triggers the `HANDLER` block in MySQL or `CATCH` block in SQL Server, which rolls back the entire transaction.

## Example 2: Successful Transaction Commit

### SQL Server Version

In this example, both `INSERT` statements execute successfully, and the transaction is committed:

```sql
BEGIN TRANSACTION
BEGIN TRY 
    INSERT INTO dbo.Sale (Price, SaleDate, Quantity)
    VALUES (5.2, GETDATE(), 1)
    
    -- This is a valid operation
    INSERT INTO dbo.Sale (Price, SaleDate, Quantity)
    VALUES (5.3, GETDATE(), 2)
    
    COMMIT TRANSACTION
END TRY
BEGIN CATCH 
    -- If an error occurs, roll back the transaction
    ROLLBACK TRANSACTION
    THROW
END CATCH
```

### MySQL Version

```sql
START TRANSACTION;
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Handle the error and roll back the transaction
        ROLLBACK;
    END;

    INSERT INTO Sale (Price, SaleDate, Quantity)
    VALUES (5.2, NOW(), 1);
    
    -- This is a valid operation
    INSERT INTO Sale (Price, SaleDate, Quantity)
    VALUES (5.3, NOW(), 2);
    
    COMMIT;
END;
```

### Key Points:
- Both `INSERT` statements execute without errors, so the transaction is committed successfully.
- The `HANDLER` in MySQL or `CATCH` block in SQL Server is not triggered because no errors occur within the `TRY` block.

## Summary

- **Transactions in TRY/CATCH Blocks**: Using `BEGIN TRY ... END TRY` and `BEGIN CATCH ... END CATCH` in SQL Server or 
  `DECLARE ... HANDLER` in MySQL allows for error handling within SQL transactions.
- **Rollback on Error**: If an error occurs within the `TRY` block, control passes to the `CATCH` block or `HANDLER`,
  where you can perform a rollback.
- **Commit on Success**: If all operations in the `TRY` block succeed, the transaction is committed, and the `CATCH` or
  `HANDLER` block is never executed.

## Source
- [SQL Notes for Professionals](https://goalkicker.com/SQLBook)
