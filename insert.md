## INSERT data from another table using SELECT

```sql
INSERT INTO Customers (FName, LName, PhoneNumber)
SELECT FName, LName, PhoneNumber FROM Employees
```
This example will insert all Employees into the Customers table. Since the two tables have diﬀerent ﬁelds and you
don't want to move all the ﬁelds over, you need to set which ﬁelds to insert into and which ﬁelds to select. The
correlating ﬁeld names don't need to be called the same thing, but then need to be the same data type. This
example is assuming that the Id ﬁeld has an Identity Speciﬁcation set and will auto increment.

If you have two tables that have exactly the same ﬁeld names and just want to move all the records over you can
use:
```sql
INSERT INTO Table1
SELECT * FROM Table2
```

## Insert New Row
```sql
INSERT INTO Customers
VALUES ('Zack', 'Smith', 'zack@example.com', '7049989942', 'EMAIL');
```
This statement will insert a new row into the Customers table. Note that a value was not speciﬁed for the Id column,
as it will be added automatically. However, all other column values must be speciﬁed.

## Insert Only Speciﬁed Columns
```sql
INSERT INTO Customers (FName, LName, Email, PreferredContact)
VALUES ('Zack', 'Smith', 'zack@example.com', 'EMAIL');
```
This statement will insert a new row into the Customers table. Data will only be inserted into the columns speciﬁed -
note that no value was provided for the PhoneNumber column. Note, however, that all columns marked as not null
must be included.

## Insert multiple rows at once
Multiple rows can be inserted with a single insert command:
```sql
INSERT INTO tbl_name (field1, field2, field3)
VALUES (1,2,3), (4,5,6), (7,8,9);
```
For inserting large quantities of data (bulk insert) at the same time, DBMS-speciﬁc features and recommendations
exist.  


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)