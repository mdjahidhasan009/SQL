# BETWEEN to Filter Results
> Note: The BETWEEN operator is inclusive means that the values you specify in the query will be included in the
> results if the value is greater than or equal to the lower value and less than or equal to the higher value.

The following examples use the Item Sales and Customers sample databases.

Using the BETWEEN operator with Numbers:
```sql
SELECT * FROM ItemSales
WHERE Quantity BETWEEN 10 AND 17
```
This query will return all ItemSales records that have a quantity that is greater or equal to 10 and less than or equal
to 17. The results will look like:

```sql
mysql> SELECT * FROM ItemSales;
+----+------------+--------+----------+-------+
| Id | SaleDate   | ItemId | Quantity | Price |
+----+------------+--------+----------+-------+
|  1 | 2013-07-11 |    100 |       20 | 34.50 |
|  3 | 2013-07-11 |    100 |       20 | 34.50 |
|  4 | 2013-07-23 |    100 |       15 | 34.50 |
|  5 | 2013-07-24 |    145 |       10 | 34.50 |
|  6 | 2013-05-24 |    100 |       20 | 34.50 |
|  7 | 2013-05-23 |    100 |       20 | 34.50 |
+----+------------+--------+----------+-------+
6 rows in set (0.00 sec)
```

## Using the BETWEEN operator with Date Values
```sql
SELECT * From ItemSales
WHERE SaleDate BETWEEN '2013-05-24' AND '2013-07-11';
```
This query will return all ItemSales records with a SaleDate that is greater than or equal to May 24, 2013 and less
than or equal to July 11, 2013.

```sql
mysql> SELECT * From ItemSales WHERE SaleDate BETWEEN '2013-05-24' AND '2013-07-11';
+----+------------+--------+----------+-------+
| Id | SaleDate   | ItemId | Quantity | Price |
+----+------------+--------+----------+-------+
|  1 | 2013-07-11 |    100 |       20 | 34.50 |
|  3 | 2013-07-11 |    100 |       20 | 34.50 |
|  6 | 2013-05-24 |    100 |       20 | 34.50 |
+----+------------+--------+----------+-------+
3 rows in set (0.00 sec)
```


## Understanding DATE vs. DATETIME in MySQL

### DATE vs. DATETIME
- **DATE**: Stores only the date in the format `YYYY-MM-DD`.
- **DATETIME**: Stores both date and time in the format `YYYY-MM-DD HH:MM:SS`.

### Why the Difference Matters
When you compare `DATETIME` values, the time portion can affect the outcome. For instance, two records with the same 
date but different times will be considered different when compared as `DATETIME`. If your intention is to compare only
the dates, you need to handle the `DATETIME` values accordingly.

### Method 1: Converting DATETIME to DATE
One common approach is to extract the `DATE` part from the `DATETIME` values before performing the comparison. You can
use the `DATE()` function for this purpose.

#### Example Scenario
**Table:** `events`

| id | event_name | event_datetime        |
|----|------------|-----------------------|
| 1  | Conference | 2024-04-15 09:00:00   |
| 2  | Meeting    | 2024-04-15 15:30:00   |
| 3  | Webinar    | 2024-04-16 11:00:00   |

**Goal:** Retrieve all events that occurred on `2024-04-15`, regardless of the time.

### SQL Query Using `DATE()`

```sql
SELECT *
FROM events
WHERE DATE(event_datetime) = '2024-04-15';
```

**Result:**

| id | event_name | event_datetime      |
|----|------------|---------------------|
| 1  | Conference | 2024-04-15 09:00:00 |
| 2  | Meeting    | 2024-04-15 15:30:00 |

#### Explanation
- The `DATE(event_datetime)` function extracts the date part from the `DATETIME` field.
- The `WHERE` clause compares only the date portion, ignoring the time.

### Method 2: Adding or Subtracting 24 Hours
In some scenarios, especially when dealing with ranges or boundaries, you might need to adjust the `DATETIME` values by
adding or subtracting 24 hours (1 day) to ensure accurate comparisons.

#### Example Scenario
**Table:** `subscriptions`

| id | user_id | start_datetime       | end_datetime         |
|----|---------|----------------------|----------------------|
| 1  | 101     | 2024-04-01 10:00:00  | 2024-04-10 10:00:00  |
| 2  | 102     | 2024-04-05 08:30:00  | 2024-04-15 08:30:00  |
| 3  | 103     | 2024-04-10 12:00:00  | 2024-04-20 12:00:00  |

**Goal:** Find all subscriptions active on `2024-04-15`. A subscription is active if the date falls between `start_datetime` and `end_datetime`. To include subscriptions that end exactly on `2024-04-15`, you might need to add 24 hours to the end date.

### SQL Query Without Adjusting

```sql
SELECT *
FROM subscriptions
WHERE '2024-04-15' BETWEEN DATE(start_datetime) AND DATE(end_datetime);
```

**Result:**

| id | user_id | start_datetime      | end_datetime        |
|----|---------|---------------------|---------------------|
| 2  | 102     | 2024-04-05 08:30:00 | 2024-04-15 08:30:00 |

**Issue:** The subscription with `id=3` ends on `2024-04-20`, so it's not included, but suppose you want to include 
subscriptions that are active up to the end of `2024-04-15`.

### Adjusting `end_datetime` by Adding 24 Hours

```sql
SELECT *
FROM subscriptions
WHERE '2024-04-15' BETWEEN DATE(start_datetime) AND DATE(end_datetime + INTERVAL 1 DAY);
```

**Result:**

| id | user_id | start_datetime      | end_datetime        |
|----|---------|---------------------|---------------------|
| 2  | 102     | 2024-04-05 08:30:00 | 2024-04-15 08:30:00 |
| 3  | 103     | 2024-04-10 12:00:00 | 2024-04-20 12:00:00 |

**Explanation:**
- Adding `INTERVAL 1 DAY` to `end_datetime` ensures that the end date is inclusive up to the entire day.
- Now, if a subscription ends on `2024-04-15 08:30:00`, adding 24 hours makes the comparison inclusive for the whole day.


## Alternative: Using < Operator with Next Day
Another way to include the entire day without adjusting the `end_datetime` is to compare using the `<` operator with the
next day.

```sql
SELECT *
FROM subscriptions
WHERE start_datetime <= '2024-04-15 23:59:59'
  AND end_datetime >= '2024-04-15 00:00:00';
```

Or more elegantly:

```sql
SELECT *
FROM subscriptions
WHERE '2024-04-15' >= DATE(start_datetime)
  AND '2024-04-15' < DATE(end_datetime) + INTERVAL 1 DAY;
```

## When to Use Each Method
- **Converting to DATE**: Use when you need to compare only the date portions and ignore the time. It's straightforward
  and efficient for date-based comparisons.

- **Adding/Subtracting 24 Hours**: Use when dealing with date ranges where inclusivity of the end date is crucial, 
  especially when the DATETIME includes specific times that might exclude records unintentionally.

## Practical Example with a Sample Table
Let's create a sample table to demonstrate both methods.

### Creating the Table

```sql
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATETIME
);
```

### Inserting Sample Data

```sql
INSERT INTO orders (order_id, order_date) VALUES
(1, '2024-09-20 14:30:00'),
(2, '2024-09-21 09:15:00'),
(3, '2024-09-21 23:45:00'),
(4, '2024-09-22 00:05:00');
```

### Scenario 1: Retrieve Orders on `2024-09-21`
**Using DATE() Function**

```sql
SELECT *
FROM orders
WHERE DATE(order_date) = '2024-09-21';
```

**Result:**

| order_id | order_date           |
|----------|----------------------|
| 2        | 2024-09-21 09:15:00  |
| 3        | 2024-09-21 23:45:00  |

### Scenario 2: Retrieve Orders Up to `2024-09-21` Inclusive
**Using DATE() and Adding 1 Day to `end_date`**

```sql
SELECT *
FROM orders
WHERE order_date < DATE('2024-09-21') + INTERVAL 1 DAY;
```

**Result:**

| order_id | order_date           |
|----------|----------------------|
| 1        | 2024-09-20 14:30:00  |
| 2        | 2024-09-21 09:15:00  |
| 3        | 2024-09-21 23:45:00  |

**Explanation:**
- `DATE('2024-09-21') + INTERVAL 1 DAY` results in `2024-09-22 00:00:00`.
- The `<` operator ensures that all orders before `2024-09-22 00:00:00` are included, effectively including all orders on `2024-09-21` regardless of time.

## Performance Considerations
- **Using Functions on Columns**: Applying functions like `DATE()` directly on columns (e.g., `DATE(order_date)`) can
  prevent MySQL from using indexes efficiently, potentially leading to slower queries on large datasets.

- **Alternative Approach**: To maintain index usage, structure your `WHERE` clause to avoid wrapping columns in functions.

**Example:**

Instead of:

```sql
WHERE DATE(order_date) = '2024-09-21'
```

Use:

```sql
WHERE order_date >= '2024-09-21 00:00:00'
  AND order_date < '2024-09-22 00:00:00'
```

**Benefits:**
- Allows MySQL to utilize indexes on `order_date`.
- Improves query performance, especially on large tables.

### Summary
- **Comparing DATETIME vs. DATE**: Direct comparisons of `DATETIME` include both date and time, which might not be 
  desirable when only the date is relevant.
- **Converting to DATE**: Use the `DATE()` function to extract the date part for accurate date-only comparisons.
- **Adjusting by 24 Hours**: Add or subtract intervals to include entire days in range-based comparisons.




## `BETWEEN` Operator with Letters in SQL

#### SQL Query Example
```sql
SELECT Id, FName, LName 
FROM Customers
WHERE LName BETWEEN 'D' AND 'L';
```

### How It Works
- The `BETWEEN 'D' AND 'L'` clause checks only the first letter of the `LName` values in the `Customers` table.
- It performs a lexicographical (dictionary) comparison, checking if the first letter of `LName` falls within the range 
  from 'D' to 'L', inclusive.

## Behavior Explained
- The `BETWEEN` operator filters records within a specified range based on the first letter.
- The comparison is usually case-sensitive depending on the collation settings of your database, which means it treats 
  uppercase and lowercase letters separately.

### What This Query Matches
- **Matches**: Any last name starting with 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', or 'L'.
- **Examples of Matching Last Names**:
    - `Doe`
    - `Ellis`
    - `Fisher`
    - `Johnson`

### What This Query Does Not Match
- **Does Not Match**: Last names starting with letters outside the range 'D' to 'L'.
- **Examples of Non-Matching Last Names**:
    - `Baker` (starts with 'B')
    - `Miller` (starts with 'M')
    - `Nash` (starts with 'N')

### Critical and Tough Examples

### 1. Case Sensitivity Example
If your database collation is case-sensitive, the query will differentiate between uppercase and lowercase. For instance:
- `LName BETWEEN 'd' AND 'l'` will only match lowercase letters between 'd' and 'l', not 'D' to 'L'.

### 2. Special Characters and Accents
- If names have special characters or accents (e.g., `Álvarez`, `Öhman`), they might fall outside the expected range 
  depending on collation.
- Example: `LName BETWEEN 'Á' AND 'O'` might include accented letters like 'É' and 'Ö'.

### 3. Including Numerical Values
- If `LName` has numeric values or symbols (e.g., `123Smith`, `#Brown`), those might fall unexpectedly within or outside 
  the range, based on ASCII values.
- For example: `LName BETWEEN '1' AND '9'` will include names starting with numbers.

### 4. Using the `BETWEEN` with Mixed-Case Collations
- In collations where lowercase is treated after uppercase (e.g., binary collations), `BETWEEN 'D' AND 'l'` might 
  exclude `Doe` but include `lee`.

## Key Points to Remember
- The `BETWEEN` operator can behave differently based on collation settings, especially with mixed cases, accented
  characters, and non-alphabetical symbols.
- It’s essential to understand your database’s collation to ensure the correct range filtering when using `BETWEEN` with
  letters.

### Conclusion
Using `BETWEEN` with letter ranges is a powerful way to filter data alphabetically. However, it is crucial to be mindful of special cases, collation settings, and the inclusion of non-alphabetical characters that may affect the results.





## Use HAVING with Aggregate Functions
Unlike the WHERE clause, HAVING can be used with aggregate functions.
> An aggregate function is a function where the values of multiple rows are grouped together as input on certain criteria
> to form a single value of more significant meaning or measurement

Common aggregate functions include `COUNT()`, `SUM()`, `MIN()`, and `MAX()`.

This example uses the Car Table from the Example Databases.

**MS SQL Server**
```sql
SELECT CustomerId, COUNT(Id) AS [Number of Cars]
FROM Cars
GROUP BY CustomerId
HAVING COUNT(Id) > 1;
```
**MySQL**
```sql
SELECT CustomerId, COUNT(Id) AS `Number of Cars`
FROM Cars
GROUP BY CustomerId
HAVING COUNT(Id) > 1;
```

This query will return the CustomerId and Number of Cars count of any customer who has more than one car. In
this case, the only customer who has more than one car is Customer #1.

The results will look like:

| CustomerId | Number of Cars |
|------------|----------------|
| 1          | 2              |

## WHERE clause with NULL/NOT NULL values

This statement will return all `Employee` records where the value of the `ManagerId` column is `NULL`.
```sql
SELECT 
    *
FROM
    Employees
WHERE
    ManagerId IS NULL;
+----+-------+-------+-------------+-----------+--------------+---------+------------+-------------+--------------+
| Id | FName | LName | PhoneNumber | ManagerId | DepartmentId | Salary  | Hire_Date  | CreatedDate | ModifiedDate |
+----+-------+-------+-------------+-----------+--------------+---------+------------+-------------+--------------+
|  1 | James | Smith | 1234567890  |      NULL |            1 | 1000.00 | 2002-01-01 | 2002-01-01  | 2002-01-01   |
+----+-------+-------+-------------+-----------+--------------+---------+------------+-------------+--------------+
1 row in set (0.00 sec)    
```

This statement will return all `Employee` records where the value of the `ManagerId` is not `NULL`.
```sql
SELECT 
    *
FROM
    Employees
WHERE
    ManagerId IS NOT NULL;
+----+-----------+----------+-------------+-----------+--------------+--------+------------+-------------+--------------+
| Id | FName     | LName    | PhoneNumber | ManagerId | DepartmentId | Salary | Hire_Date  | CreatedDate | ModifiedDate |
+----+-----------+----------+-------------+-----------+--------------+--------+------------+-------------+--------------+
|  2 | John      | Johnson  | 2468101214  |         1 |            1 | 400.00 | 2005-03-23 | 2005-03-23  | 2002-01-01   |
|  3 | Michael   | Williams | 1357911131  |         1 |            2 | 600.00 | 2009-05-12 | 2009-05-12  | NULL         |
|  4 | Johnathon | Smith    | 1212121212  |         2 |            1 | 500.00 | 2016-07-24 | 2016-07-24  | 2002-01-01   |
+----+-----------+----------+-------------+-----------+--------------+--------+------------+-------------+--------------+
3 rows in set (0.00 sec)    
```

Note: The same query will not return results if you change the WHERE clause to `WHERE ManagerId = NULL` or `WHERE
ManagerId <> NULL`.

## Equality
```sql
SELECT * FROM Employees
```

This statement will return all the rows from the table Employees.

| Id  | FName     | LName    | PhoneNumber  | ManagerId  | DepartmentId  | Salary  | Hire_date  | CreatedDate | ModifiedDate |
|-----|-----------|----------|--------------|------------|---------------|---------|------------|-------------|--------------|
| 1   | James     | Smith    | 1234567890   | NULL       | 1             | 1000    | 01-01-2002 | 01-01-2002  | 01-01-2002   |
| 2   | John      | Johnson  | 2468101214   | 1          | 1             | 400     | 23-03-2005 | 23-03-2005  | 01-01-2002   |
| 3   | Michael   | Williams | 1357911131   | 1          | 2             | 600     | 12-05-2009 | 12-05-2009  | NULL         |
| 4   | Johnathon | Smith    | 1212121212   | 2          | 1             | 500     | 24-07-2016 | 24-07-2016  | 01-01-2002   |

Using a WHERE at the end of your SELECT statement allows you to limit the returned rows to a condition. In this case,
where there is an exact match using the = sign:
```sql
SELECT * FROM Employees WHERE DepartmentId = 1
```
Will only return the rows where the DepartmentId is equal to 1:

| Id  | FName     | LName    | PhoneNumber  | ManagerId  | DepartmentId  | Salary  | Hire_date  | CreatedDate | ModifiedDate |
|-----|-----------|----------|--------------|------------|---------------|---------|------------|-------------|--------------|
| 1   | James     | Smith    | 1234567890   | NULL       | 1             | 1000    | 01-01-2002 | 01-01-2002  | 01-01-2002   |
| 2   | John      | Johnson  | 2468101214   | 1          | 1             | 400     | 23-03-2005 | 23-03-2005  | 01-01-2002   |
| 4   | Johnathon | Smith    | 1212121212   | 2          | 1             | 500     | 24-07-2016 | 24-07-2016  | 01-01-2002   |


## The WHERE clause only returns rows that match its criteria
Steam has a games under $10 section of their store page. Somewhere deep in the heart of their systems, there's probably 
a query that looks something like:
```sql
SELECT *
FROM Items
WHERE Price < 10
```

## AND, and OR
You can also combine several operators together to create more complex WHERE conditions. The following examples
use the Employees table:

| Id  | FName     | LName    | PhoneNumber  | ManagerId  | DepartmentId  | Salary  | Hire_date  | CreatedDate | ModifiedDate |
|-----|-----------|----------|--------------|------------|---------------|---------|------------|-------------|--------------|
| 1   | James     | Smith    | 1234567890   | NULL       | 1             | 1000    | 01-01-2002 | 01-01-2002  | 01-01-2002   |
| 2   | John      | Johnson  | 2468101214   | 1          | 1             | 400     | 23-03-2005 | 23-03-2005  | 01-01-2002   |
| 3   | Michael   | Williams | 1357911131   | 1          | 2             | 600     | 12-05-2009 | 12-05-2009  | NULL         |
| 4   | Johnathon | Smith    | 1212121212   | 2          | 1             | 500     | 24-07-2016 | 24-07-2016  | 01-01-2002   |


**AND**
```sql
SELECT * FROM Employees WHERE DepartmentId = 1 AND ManagerId = 1
```
Will return:

| Id  | FName     | LName    | PhoneNumber  | ManagerId  | DepartmentId  | Salary  | Hire_date  | CreatedDate | ModifiedDate |
|-----|-----------|----------|--------------|------------|---------------|---------|------------|-------------|--------------|
| 2   | John      | Johnson  | 2468101214   | 1          | 1             | 400     | 23-03-2005 | 23-03-2005  | 01-01-2002   |

**OR**
```sql
SELECT * FROM Employees WHERE DepartmentId = 2 OR ManagerId = 2
```
Will return:

| Id  | FName     | LName    | PhoneNumber  | ManagerId  | DepartmentId  | Salary  | Hire_date  | CreatedDate | ModifiedDate |
|-----|-----------|----------|--------------|------------|---------------|---------|------------|-------------|--------------|
| 3   | Michael   | Williams | 1357911131   | 1          | 2             | 600     | 12-05-2009 | 12-05-2009  | NULL         |
| 4   | Johnathon | Smith    | 1212121212   | 2          | 1             | 500     | 24-07-2016 | 24-07-2016  | 01-01-2002   |


## Use IN to return rows with a value contained in a list
This example uses the Car Table from the Example Databases.
```sql
SELECT * 
FROM Cars
WHERE TotalCost IN (100, 200, 300)
```
This query will return Car #2 which costs 200 and Car #3 which costs 100. Note that this is equivalent to using
multiple clauses with OR, e.g.:
```sql
SELECT * 
FROM Cars
WHERE TotalCost = 100 OR TotalCost = 200 or TotalCost = 300
```

## Use LIKE to find matching strings and substrings
See full documentation on LIKE operator.

This example uses the Employees Table from the Example Databases.
```sql
SELECT *
FROM Employees
WHERE FName LIKE 'John'
```
This query will only return Employee #1 whose first name matches 'John' exactly. 
```sql
SELECT *
FROM Employees
WHERE FName like 'John%'
```
Adding % allows you to search for a substring:
* John% - will return any Employee whose name begins with 'John', followed by any amount of characters
* %John - will return any Employee whose name ends with 'John', proceeded by any amount of characters
* %John% - will return any Employee whose name contains 'John' anywhere within the value
In this case, the query will return Employee #2 whose name is 'John' as well as Employee #4 whose name is
'Johnathon'.


## Understanding WHERE EXISTS in SQL
### Overview
The `WHERE EXISTS` clause is used in SQL to filter rows based on the presence of rows in a related subquery. It checks 
if the subquery returns any rows and, if it does, the condition is considered met. It is often used when you need to 
check the existence of records in one table based on criteria from another table.

### How WHERE EXISTS Works
- `EXISTS` evaluates to `TRUE` if the subquery returns one or more rows.
- If the subquery returns no rows, `EXISTS` evaluates to `FALSE`.
- The subquery usually contains a correlated reference to the outer query, often linking the two tables based on a 
  common column.

### Syntax
```sql
SELECT columns
FROM TableName t
WHERE EXISTS (
    SELECT 1 
    FROM TableName1 t1 
    WHERE t.Id = t1.Id
);
```

### Explanation of the Syntax
- **`SELECT columns FROM TableName t`**: This part selects the desired columns from the main table (`TableName`).
- **`WHERE EXISTS`**: Checks whether the subquery returns any rows.
- **Subquery (`SELECT 1 FROM TableName1 t1 WHERE t.Id = t1.Id`)**: Returns rows based on the condition; if any row is 
  found, the `EXISTS` clause is satisfied.

### Example Scenario

### Tables:
1. **`Orders` Table**

| OrderId | CustomerId | OrderDate   |
|---------|------------|-------------|
| 1       | 101        | 2024-01-01  |
| 2       | 102        | 2024-02-01  |
| 3       | 103        | 2024-03-01  |
| 4       | 101        | 2024-04-01  |

2. **`Customers` Table**

| CustomerId | Name     |
|------------|----------|
| 101        | Alice    |
| 104        | Bob      |

### Example Query: Using WHERE EXISTS
Let's say we want to find all `Orders` placed by customers who exist in the `Customers` table.

```sql
SELECT * 
FROM Orders o 
WHERE EXISTS (
    SELECT 1 
    FROM Customers c 
    WHERE o.CustomerId = c.CustomerId
);
```

### Explanation of the Example
- **Main Query**: Selects all columns from the `Orders` table (`o`).
- **Subquery**: Selects `1` from the `Customers` table (`c`) where the `CustomerId` in `Orders` matches a `CustomerId` 
  in `Customers`.
- **Result**: The query will return orders for customers that exist in the `Customers` table.

### Result:

| OrderId | CustomerId | OrderDate   |
|---------|------------|-------------|
| 1       | 101        | 2024-01-01  |
| 4       | 101        | 2024-04-01  |

### Key Points
- **Performance**: `EXISTS` is efficient for checking the existence of records without scanning the entire table, as it 
  stops searching once it finds a match.
- **Difference from `IN`**: `EXISTS` is often preferred over `IN` when dealing with subqueries because it stops 
  processing once a match is found, whereas `IN` evaluates all values.
- **Use Case**: Commonly used for filtering records based on relationships between tables, such as verifying whether
  related records exist.

### Conclusion
The `WHERE EXISTS` clause is a powerful tool for checking the presence of related records in another table, making it an essential component for filtering results based on relationships between data sets. Understanding its behavior helps optimize queries and improve data retrieval efficiency.

## Use HAVING to check for multiple conditions in a group
Orders Table

| CustomerId | ProductId | Quantity | Price |
|------------|-----------|----------|-------|
| 1          | 2         | 5        | 100   |
| 1          | 3         | 2        | 200   |
| 1          | 4         | 1        | 500   |
| 2          | 1         | 4        | 50    |
| 3          | 5         | 6        | 700   |

To check for customers who have ordered both - ProductID 2 and 3, HAVING can be used
```sql
SELECT 
    CustomerID
FROM
    Orders
WHERE
    ProductId IN (2 , 3)
GROUP BY CustomerId
HAVING COUNT(DISTINCT ProductId) = 2;
```
Return value:

| customerId |
|------------|
| 1          |

The query selects only records with the productIDs in questions and with the HAVING clause checks for groups having 2 
productIds and not just one.

Another possibility would be
```sql
SELECT CustomerId
FROM Orders
GROUP BY CustomerId
HAVING SUM(CASE WHEN ProductId = 2 THEN 1 ELSE 0 END) > 0
   AND SUM(CASE WHEN ProductId = 3 THEN 1 ELSE 0 END) > 0;
```

This query selects only groups having at least one record with productID 2 and at least one with productID 3.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)