# TRUNCATE
The TRUNCATE statement deletes all data from a table. This is similar to DELETE with no ﬁlter, but, depending on
the database software, has certain restrictions and optimizations.

## Removing all rows from the Employee table
```sql
TRUNCATE TABLE Employee;
```
Using truncate table is often better then using DELETE TABLE as it ignores all the indexes and triggers and just
removes everything.

Delete table is a row based operation this means that each row is deleted. Truncate table is a data page operation
the entire data page is reallocated. If you have a table with a million rows it will be much faster to truncate the table
than it would be to use a delete table statement

Though we can delete speciﬁc Rows with DELETE, we cannot TRUNCATE speciﬁc rows, we can only TRUNCATE all
the records at once. Deleting All rows and then inserting a new record will continue to add the Auto incremented
Primary key value from the previously inserted value, where as in Truncate, the Auto Incremental primary key value
will also get reset and starts from 1.

Note that when truncating table, no foreign keys must be present, otherwise you will get an error.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)