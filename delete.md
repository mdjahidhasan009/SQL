# Delete
The DELETE statement is used to delete records from a table.

## DELETE all rows
Omitting a WHERE clause will delete all rows from a table.
```sql
DELETE FROM Employees
```
See TRUNCATE documentation for details on how TRUNCATE performance can be better because it ignores triggers
and indexes and logs to just delete the data.

## DELETE certain rows with WHERE
This will delete all rows that match the WHERE criteria.
```sql
DELETE FROM Employees
WHERE FName = 'John`;
```

## TRUNCATE clause
Use this to reset the table to the condition at which it was created. This deletes all rows and resets values such as
auto-increment. It also doesn't log each individual row deletion.

```sql
TRANCATE TABLE Employee
```

## DELETE certain rows based upon comparisons with other tables
It is possible to DELETE data from a table if it matches (or mismatches) certain data in other tables.

Let's assume we want to DELETE data from Source once its loaded into Target.
```sql
DELETE FROM SOURCE 
WHERE EXITS ( SELECT 1 -- specific value in SELECT doesn't matter
              FROM TARGET
              WHERE Source.ID = Target.ID )
```
Most common RDBMS implementations (e.g. MySQL, Oracle, PostgresSQL, Teradata) allow tables to be joined
during DELETE allowing more complex comparison in a compact syntax.

Adding complexity to original scenario, let's assume Aggregate is built from Target once a day and does not contain
the same ID but contains the same date. Let us also assume that we want to delete data from Source only after the
aggregate is populated for the day

On MySQL, Oracle and Teradata this can be done using:
```sql
DELETE FROM Source
WHERE Source.ID = TargetSchema.Target.ID
      AND TargetSchema.Target.Date = AggregateSchema.Aggregate.Date
```
In PostgreSQL use:
```sql
DELETE FROM Source
USING TargetSchema.Target, AggregateSchema.Aggregate
WHERE Source.ID = TargetSchema.Target.ID
      AND TargetSchema.Target.Date = AggregateSchema.Aggregate.AggDate
```


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)