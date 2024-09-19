## Simple IN clause
To get records having any of the given ids
```sql
mysql> SELECT 
    *
FROM
    Products
WHERE
    Id IN (1 , 8, 3);
+----+-----------+-------+
| Id | Name      | Price |
+----+-----------+-------+
|  1 | Product A |  10.0 |
|  3 | Product B |  20.0 |
|  8 | Product C |  15.5 |
+----+-----------+-------+
3 rows in set (0.00 sec)
```
The query above is equal to 
```sql
SELECT 
    *
FROM
    Products
WHERE
    Id = 1 OR Id = 8 OR Id = 3;
```

## Using IN clause with a subquery
```sql
mysql> SELECT DISTINCT CustomerId FROM Orders;
+------------+
| CustomerId |
+------------+
|          1 |
|          2 |
|          3 |
|          4 |
+------------+
4 rows in set (0.00 sec)
```

```sql
SELECT 
    *
FROM
    Customers
WHERE
    Id IN (SELECT DISTINCT
            CustomerId
        FROM
            Orders);
+----+-----------+----------+---------------------------+
| Id | FirstName | LastName | Email                     |
+----+-----------+----------+---------------------------+
|  1 | John      | Doe      | john.doe@example.com      |
|  2 | Jane      | Smith    | jane.smith@example.com    |
|  3 | Alice     | Johnson  | alice.johnson@example.com |
|  4 | Bob       | Brown    | bob.brown@example.com     |
+----+-----------+----------+---------------------------+
4 rows in set (0.00 sec)
```
The above will give you all the customers that have orders in the system.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)