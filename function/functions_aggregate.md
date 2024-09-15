## Conditional aggregation
Payments Table

| Customer | Payment_type | Amount |
|----------|--------------|--------|
| Peter    | Credit       | 100    |
| Peter    | Credit       | 300    |
| John     | Credit       | 1000   |
| John     | Debit        | 500    |

```sql
SELECT customer,
       SUM(CASE WHEN payment_type = 'Credit' THEN amount ELSE 0 END) AS credit,
       SUM(CASE WHEN payment_type = 'Debit' THEN amount ELSE 0 END) AS debit
FROM payments
GROUP BY customer;
```
Result:

| Customer | Credit | Debit |
|----------|--------|-------|
| Peter    | 400    | 0     |
| John     | 1000   | 500   |

```sql
SELECT customer,
       SUM(CASE WHEN payment_type = 'Credit' THEN 1 ELSE 0 END) AS credit_transaction_count,
       SUM(CASE WHEN payment_type = 'Debit' THEN 1 ELSE 0 END) AS debit_transaction_count
FROM payments
GROUP BY customer;
```
Result:

| Customer | credit_transaction_count | debit_transaction_count |
|----------|--------------------------|-------------------------|
| Peter    | 2                        | 0                       |
| John     | 1                        | 1                       |

## List Concatenation
List Concatenation aggregates a column or expression by combining the values into a single string for each group. A
string to delimit each value (either blank or a comma when omitted) and the order of the values in the result can be
speciﬁed. While it is not part of the SQL standard, every major relational database vendor supports it in their own
way.

**MySQL**
```sql
SELECT ColumnA
    , GROUP_CONCAT(ColumnB ORDER BY ColumnB SEPARATOR ',') AS ColumnBs
    FROM TableName
GROUP BY ColumnA
ORDER BY ColumnA;
```
Oracle & DB2
```sql
SELECT ColumnA
    , LISTAGG(ColumnB, ',') WITHIN GROUP (ORDER BY ColumnB) AS ColumnBs
  FROM TableName
GROUP BY ColumnA
ORDER BY ColumnA;
```
PostgreSQL
```sql
SELECT ColumnA
, STRING_AGG(ColumnB, ',' ORDER BY ColumnB) AS ColumnBs
FROM TableName
GROUP BY ColumnA
ORDER BY ColumnA;
```
#### SQL Server
SQL Server 2016 and earlier
```sql
WITH CTE_TableName AS (
    SELECT ColumnA, ColumnB
        FROM TableName)
SELECT t0.ColumnA
        , STUFF((
        SELECT ',' + t1.ColumnB
            FROM CTE_TableName t1
        WHERE t1.ColumnA = t0.ColumnA
        ORDER BY t1.ColumnB
            FOR XML PATH('')), 1, 1, '') AS ColumnBs
        FROM CTE_TableName t0
GROUP BY t0.ColumnA
ORDER BY ColumnA;
```
SQL Server 2017 and SQL Azure
```sql
SELECT ColumnA
        , STRING_AGG(ColumnB, ',') WITHIN GROUP (ORDER BY ColumnB) AS ColumnBs
    FROM TableName
GROUP BY ColumnA
ORDER BY ColumnA;
```
SQLite

without ordering:
```sql
SELECT ColumnA
        , GROUP_CONCAT(ColumnB, ',') AS ColumnBs
    FROM TableName
GROUP BY ColumnA
ORDER BY ColumnA;
```
ordering requires a subquery or CTE:
```sql
WITH CTE_TableName AS (
     SELECT ColumnA, ColumnB
        FROM TableName
     ORDER BY ColumnA, ColumnB)
SELECT ColumnA
        , GROUP_CONCAT(ColumnB, ',') AS ColumnBs
    FROM CTE_TableName
GROUP BY ColumnA
ORDER BY ColumnA;
```

## SUM
Sum function sum the value of all the rows in the group. If the group by clause is omitted then sums all the rows.
```sql
select sum(salary) TotalSalary
from employees;
```
| TotalSalary |
|-------------|
| 2500        |

```sql
select DepartmentId, sum(salary) TotalSalary
from employees
group by DepartmentId;
```    

| DepartmentId | TotalSalary |
|--------------|-------------|
| 1            | 2000        |
| 2            | 500         |

## AVG()
The aggregate function AVG() returns the average of a given expression, usually numeric values in a column.
Assume we have a table containing the yearly calculation of population in cities across the world. The records for
New York City look similar to the ones below:

**EXAMPLE TABLE**

| city_name            | population year |
|----------------------|-----------------|
| New York City        | 8,550,405 2015  |
| New York City ...... | ....            |
| New York City        | 8,000,9062005   | 

Notice how measurement year is absent from the query since population is being averaged over time.

RESULTS

| city_name     | avg_population |
|---------------|----------------|
| New York City | 8,250,754      |

> Note: The AVG() function will convert values to numeric types. This is especially important to keep in mind
when working with dates.

## Count
You can count the number of rows:
```sql
SELECT count(*) TotalRows
FROM employees;
```

| TotalRows |
|-----------|
| 4         |

Or count the employees per department:
```sql
SELECT DepartmentId, count(*) NumEmployees
FROM employees
GROUP BY DepartmentId;
```

| DepartmentId | NumEmployees |
|--------------|--------------|
| 1            | 3            |
| 2            | 1            |

You can count over a column/expression with the effect that will not count the NULL values:
```sql
SELECT count(ManagerId) mgr
FROM EMPLOYEES;
```
| mgr |
|-----|
| 3   |
(There is one null value managerID column)

You can also use DISTINCT inside of another function such as COUNT to only ﬁnd the DISTINCT members of the
set to perform the operation on.

For example:

```sql
SELECT COUNT(ContinentCode) AllCount
,
COUNT(DISTINCT ContinentCode) SingleCount
FROM Countries;
```
Will return different values. The SingleCount will only Count individual Continents once, while the AllCount will
include duplicates.

| ContinentCode |
|---------------|
| OC            |
| EU            |
| AS            |
| NA            |
| NA            |
| AF            |
| AF            | 

## Min
Syntax
```sql
SELECT MIN(column_name) FROM table_name;
```

Find the smallest value of column:
```sql
select min(age) from employee;
```
Above example will return smallest value for column age of employee table.


## Max
Syntax:
```sql
SELECT MAX(column_name) FROM table_name;
```
Find the maximum value of column:
```sql
select max(age) from employee;
```
Above example will return largest value for column age of employee table.


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)