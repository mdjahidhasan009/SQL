## Transaction In a TRY/CATCH
This will rollback both inserts due to an invalid datetime:
```sql
BEGIN TRANSACTION
BEGIN TRY
    INSERT INTO dbo.Sale(Price, SaleDate, Quantity)
    VALUES(5.2, GETDATE(), 1)
    INSERT INTO dbo.Sale(Price, SaleDate, Quantity)
    VALUES(5.2, 'not a date', 1)
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    THROW
    ROLLBACK TRANSACTION
END CATCH
```
This will commit both inserts:
```sql
BEGIN TRANSACTION
BEGIN TRY 
    INSERT INTO dbo.Sale(Price, SaleDate, Quantity)
    VALUES(5.2, GETDATE(), 1)
    INSERT INTO dbo.Sale(Price, SaleDate, Quantity)
    VALUES(5.3, GETDATE(), 2)
    COMMIT TRANSACTION
END TRY
BEGIN CATCH 
    THROW
    ROLLBACK TRANSACTION
END CATCH
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)