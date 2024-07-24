A materialized view is a view whose results are physically stored and must be periodically refreshed in order to
remain current. They are therefore useful for storing the results of complex, long-running queries when realtime
results are not required. Materialized views can be created in Oracle and PostgreSQL. Other database systems oﬀer
similar functionality, such as SQL Server's indexed views or DB2's materialized query tables.

## PostgreSQL example
```sql
CREATE TABLE mytable (number INT);
INSERT INTO mytable VALUES (1);
CREATE MATERIALIZED VIEW myview AS SELECT * FROM mytable;
SELECT * FROM myview;
```
Output
```
number
--------
1
(1 row)
```

```sql
INSERT INTO mytable VALUES(2);
SELECT * FROM myview;
```
Output
```
number
--------
1
(1 row)
```

```sql
REFRESH MATERIALIZED VIEW myview;
SELECT * FROM myview;
```
Output
```
number
--------
1
2
(2 rows)
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)