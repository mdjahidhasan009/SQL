## Conditional aggregation
<details>
<summary>Payments table creation and data insertion</summary>

```sql
-- Creating the Payments table
CREATE TABLE Payments (
    Customer VARCHAR(50),
    Payment_type VARCHAR(10),
    Amount INT
);

-- Inserting data into the Payments table
INSERT INTO Payments (Customer, Payment_type, Amount) VALUES
('Peter', 'Credit', 100),
('Peter', 'Credit', 300),
('John', 'Credit', 1000),
('John', 'Debit', 500);
```
</details>

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
FROM Payments
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
FROM Payments
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
specified. While it is not part of the SQL standard, every major relational database vendor supports it in their own
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

### Example of List Concatenation in MySQL

#### Table Structure and Data Insertion

Let's start with creating a sample table and inserting data to demonstrate the `GROUP_CONCAT` function.

```sql
-- Create the example table
CREATE TABLE Orders (
    Customer VARCHAR(50),
    Product VARCHAR(50)
);

-- Insert sample data into the table
INSERT INTO Orders (Customer, Product) VALUES
('Alice', 'Apples'),
('Alice', 'Bananas'),
('Alice', 'Cherries'),
('Bob', 'Dates'),
('Bob', 'Elderberries'),
('Carol', 'Figs');
```

#### MySQL Query Using `GROUP_CONCAT`

```sql
-- Using GROUP_CONCAT to concatenate products by customer
SELECT Customer,
       GROUP_CONCAT(Product ORDER BY Product SEPARATOR ', ') AS Products
FROM Orders
GROUP BY Customer
ORDER BY Customer;
```

#### Explanation of the Query

1. **GROUP_CONCAT Function**:
    - `GROUP_CONCAT()` is used to aggregate values from a column into a single string for each group defined by the 
      `GROUP BY` clause.
    - The syntax `GROUP_CONCAT(Product ORDER BY Product SEPARATOR ', ')` combines all `Product` values for each `Customer`,
      ordering them alphabetically and separating them with a comma and space.

2. **ORDER BY within GROUP_CONCAT**:
    - The `ORDER BY Product` inside `GROUP_CONCAT` ensures that the concatenated values are ordered within each group.

3. **GROUP BY Clause**:
    - The `GROUP BY Customer` groups the rows by each unique `Customer`, so `GROUP_CONCAT` operates within each group.

4. **Final Output**:
    - The query outputs each customer along with a list of their ordered products in a single row.

#### Result of the Query

| Customer | Products                    |
|----------|-----------------------------|
| Alice    | Apples, Bananas, Cherries   |
| Bob      | Dates, Elderberries         |
| Carol    | Figs                        |

#### Summary

- `GROUP_CONCAT` is highly useful for combining values from multiple rows into a single, concatenated string.
- You can control the order of the concatenated values and the separator used, making it a flexible tool for data 
  aggregation and reporting in MySQL.



## SUM
`SUM` function sum the value of all the rows in the group. If the `GROUP BY` clause is omitted then sums all the rows.
```sql
SELECT SELECT(salary) TotalSalary
FROM employees;
```
| TotalSalary |
|-------------|
| 2500        |

```sql
SELECT DepartmentId, SELECT(salary) AS TotalSalary
FROM employees
GROUP BY DepartmentId;

```    

| DepartmentId | TotalSalary |
|--------------|-------------|
| 1            | 2000        |
| 2            | 500         |



## AVG()
The aggregate function `AVG()` returns the average of a given expression, usually numeric values in a column.
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

> Note: The AVG() function will convert values to numeric types. This is especially important to keep in mind when 
> working with dates.



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

You can also use DISTINCT inside of another function such as COUNT to only find the DISTINCT members of the
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
SELECT MIN(age) FROM employee;
```
Above example will return the smallest value for column age of employee table.



## Max
Syntax:
```sql
SELECT MAX(column_name) FROM table_name;
```
Find the maximum value of column:
```sql
SELECT MAX(age) FROM employee;
```
Above example will return the largest value for column age of employee table.


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)