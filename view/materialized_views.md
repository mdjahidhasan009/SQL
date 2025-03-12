
# Materialized Views in SQL

A materialized view is a view whose results are physically stored and must be periodically refreshed to remain current.
They are useful for storing the results of complex, long-running queries when real-time results are not required.
Materialized views can be created in Oracle and PostgreSQL. Other database systems offer similar functionality, such as
SQL Server's indexed views or DB2's materialized query tables.

## PostgreSQL Example

### Creating a Table and Materialized View

```sql
-- Creating the table
CREATE TABLE mytable (number INT);

-- Inserting data into the table
INSERT INTO mytable VALUES (1);

-- Creating a materialized view
CREATE MATERIALIZED VIEW myview AS SELECT * FROM mytable;

-- Selecting data from the materialized view
SELECT * FROM myview;
```
**Output**

```
number
--------
1
(1 row)
```

### Updating the Table and Refreshing the Materialized View

```sql
-- Inserting additional data into the table
INSERT INTO mytable VALUES (2);

-- Selecting data from the materialized view without refreshing
SELECT * FROM myview;
```
**Output**

```
number
--------
1
(1 row)
```

```sql
-- Refreshing the materialized view
REFRESH MATERIALIZED VIEW myview;

-- Selecting data from the materialized view after refresh
SELECT * FROM myview;
```
**Output**

```
number
--------
1
2
(2 rows)
```

## MySQL Equivalent

MySQL does not support materialized views directly, but you can achieve similar functionality using a table to store
the results of the query and periodically update it using triggers or scheduled events.

### Creating a Table and Simulating a Materialized View

```sql
-- Creating the table
CREATE TABLE mytable (number INT);

-- Inserting data into the table
INSERT INTO mytable VALUES (1);

-- Creating a "materialized view" table
CREATE TABLE myview AS SELECT * FROM mytable;

-- Selecting data from the "materialized view"
SELECT * FROM myview;
```

### Updating the Table and Simulating Refresh

```sql
-- Inserting additional data into the table
INSERT INTO mytable VALUES (2);

-- The "materialized view" does not automatically update
SELECT * FROM myview;
```

**To simulate a refresh, you need to manually update the view table:**

```sql
-- Refreshing the "materialized view" by re-inserting data
TRUNCATE TABLE myview;
INSERT INTO myview SELECT * FROM mytable;

-- Selecting data from the "materialized view" after manual refresh
SELECT * FROM myview;
```

## Conclusion

Materialized views provide a convenient way to store and refresh query results in databases that support them.
In databases like MySQL that do not natively support materialized views, similar functionality can be achieved through
manual methods such as creating tables and managing data refreshes programmatically.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)