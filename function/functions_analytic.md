# Functions (Analytic)
You use analytic functions to determine values based on groups of values. For example, you can use this type of function
to determine running totals, percentages, or the top result within a group.

## LAG and LEAD Functions

The `LAG` and `LEAD` functions are powerful window functions that allow you to access data from other rows in the result
set without the need for a self-join. These functions are often used for comparisons within the same result set.

### LAG Function

The `LAG` function provides data on rows before the current row in the same result set. For example, in a `SELECT` 
statement, you can compare values in the current row with values in a previous row.

- **Syntax**: `LAG(scalar_expression, offset, default) OVER (PARTITION BY expression ORDER BY expression)`
- **Parameters**:
    - `scalar_expression`: Specifies the values that should be compared.
    - `offset`: The number of rows before the current row that will be used in the comparison. Defaults to 1 if not
      specified.
    - `default`: Specifies the value to be returned when the expression at the specified offset has a `NULL` value.

### LEAD Function

The `LEAD` function provides data on rows after the current row in the result set. For example, in a `SELECT` statement,
you can compare values in the current row with values in the following row.

- **Syntax**: `LEAD(scalar_expression, offset, default) OVER (PARTITION BY expression ORDER BY expression)`
- **Parameters**:
    - `scalar_expression`: Specifies the values that should be compared.
    - `offset`: The number of rows after the current row that will be used in the comparison. Defaults to 1 if not 
      specified.
    - `default`: Specifies the value to be returned when the expression at the specified offset has a `NULL` value.

### Creating the SalesPerson Table and Inserting Data

```sql
-- Creating the SalesPerson table
CREATE TABLE SalesPerson (
    BusinessEntityID INT PRIMARY KEY,
    SalesYTD DECIMAL(18,4)
);

-- Inserting data into SalesPerson table
INSERT INTO SalesPerson (BusinessEntityID, SalesYTD) VALUES
(274, 559697.5639),
(275, 3763178.1787),
(276, 4251368.5497),
(277, 3189418.3662),
(278, 1453719.4653),
(279, 2315185.6110);
```

### Example Usage in SQL Server

This example uses the `LEAD` and `LAG` functions to compare the sales values for each employee to date with those of the 
employees listed above and below, with records ordered based on the `BusinessEntityID` column.

```sql
SELECT BusinessEntityID, SalesYTD,
    LEAD(SalesYTD, 1, 0) OVER(ORDER BY BusinessEntityID) AS "Lead value",
    LAG(SalesYTD, 1, 0) OVER(ORDER BY BusinessEntityID) AS "Lag value"
FROM SalesPerson;
```

### Explanation:

- **`LEAD(SalesYTD, 1, 0)`**: Returns the `SalesYTD` value from the next row. If there is no next row, it returns `0`.
- **`LAG(SalesYTD, 1, 0)`**: Returns the `SalesYTD` value from the previous row. If there is no previous row, it returns 
  `0`.

### MySQL Equivalent

MySQL natively supports `LAG` and `LEAD` functions starting from version 8.0. If you are using MySQL 8.0 or later, you
can use the same syntax:

```sql
-- MySQL 8.0 Example
SELECT BusinessEntityID, SalesYTD,
    LEAD(SalesYTD, 1, 0) OVER(ORDER BY BusinessEntityID) AS "Lead value",
    LAG(SalesYTD, 1, 0) OVER(ORDER BY BusinessEntityID) AS "Lag value"
FROM SalesPerson;
```

### Alternative Approach for MySQL Versions Below 8.0

For MySQL versions below 8.0, `LAG` and `LEAD` are not supported. You can achieve similar functionality using session
variables:

```sql
-- Alternative using session variables in MySQL below 8.0
SET @prev_sales = 0;
SET @next_sales = 0;

SELECT BusinessEntityID, SalesYTD,
    @next_sales := IF(@prev_sales = 0, 0, @prev_sales) AS "Lead value",
    @prev_sales := SalesYTD AS "Lag value"
FROM (
    SELECT BusinessEntityID, SalesYTD
    FROM SalesPerson
    ORDER BY BusinessEntityID
) AS sorted_sales;
```

### Result:

| BusinessEntityID | SalesYTD       | Lead  value  | Lag value    |
|------------------|----------------|--------------|--------------|
| 274              | 559697.5639    | 3763178.1787 | 0.0000       |
| 275              | 3763178.1787   | 4251368.5497 | 559697.5639  |
| 276              | 4251368.5497   | 3189418.3662 | 3763178.1787 |
| 277              | 3189418.3662   | 1453719.4653 | 4251368.5497 |
| 278              | 1453719.4653   | 2315185.6110 | 3189418.3662 |
| 279              | 2315185.6110   | 1352577.1325 | 1453719.4653 |

### Key Points:

- **LAG**: Accesses data from previous rows in the result set.
- **LEAD**: Accesses data from subsequent rows in the result set.
- MySQL 8.0 and above support LAG and LEAD natively.
- For earlier versions of MySQL, alternative approaches using session variables can achieve similar results.



## PERCENTILE_DISC and PERCENTILE_CONT

The `PERCENTILE_DISC` and `PERCENTILE_CONT` functions are used to calculate percentiles within a dataset, particularly 
useful in statistical analysis and data ranking.

### PERCENTILE_DISC Function

The `PERCENTILE_DISC` function lists the value of the first entry where the cumulative distribution is higher than the 
percentile that you provide using the `numeric_literal` parameter.

- **Usage**: Returns the discrete value corresponding to a given percentile within a set of data.
- **Grouping**: The values are grouped by rowset or partition, as specified by the `WITHIN GROUP` clause.

### PERCENTILE_CONT Function

The `PERCENTILE_CONT` function is similar to the `PERCENTILE_DISC` function, but it returns the average of the sum of 
the first matching entry and the next entry.

- **Usage**: Returns a continuous value representing the percentile within the specified data set.

### Example Usage

```sql
SELECT BusinessEntityID, JobTitle, SickLeaveHours,
    CUME_DIST() OVER(PARTITION BY JobTitle ORDER BY SickLeaveHours ASC) AS "Cumulative Distribution",
    PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY SickLeaveHours) OVER(PARTITION BY JobTitle) AS "Percentile Discreet"
FROM Employee;
```

### Using PERCENTILE_CONT

To base the calculation on a set of values, use the `PERCENTILE_CONT` function. The `Percentile Continuous` column lists 
the average value of the sum of the result value and the next highest matching value.

```sql
SELECT BusinessEntityID, JobTitle, SickLeaveHours,
    CUME_DIST() OVER(PARTITION BY JobTitle ORDER BY SickLeaveHours ASC) AS "Cumulative Distribution",
    PERCENTILE_DISC(0.5) WITHIN GROUP(ORDER BY SickLeaveHours) OVER(PARTITION BY JobTitle) AS "Percentile Discreet",
    PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY SickLeaveHours) OVER(PARTITION BY JobTitle) AS "Percentile Continuous"
FROM Employee;
```

### MySQL Equivalent

MySQL does not natively support `PERCENTILE_DISC` and `PERCENTILE_CONT`. However, you can use alternative methods to 
achieve similar results, such as using window functions like `NTILE` or manual calculations using `ORDER BY`, subqueries,
and `LIMIT`.

#### Alternative Approach for MySQL:

You can approximate these functions using subqueries:

```sql
-- Calculate the discrete percentile using a subquery
SELECT e.BusinessEntityID, e.JobTitle, e.SickLeaveHours, 
       (SELECT SickLeaveHours 
        FROM Employee e2 
        WHERE e2.JobTitle = e.JobTitle 
        ORDER BY e2.SickLeaveHours 
        LIMIT 1 OFFSET FLOOR(0.5 * COUNT(*) OVER(PARTITION BY e.JobTitle))) AS Percentile_Discreet
FROM Employee e;

-- Calculating cumulative distribution using MySQL 8+ window functions:
SELECT BusinessEntityID, JobTitle, SickLeaveHours,
       ROW_NUMBER() OVER (PARTITION BY JobTitle ORDER BY SickLeaveHours) / COUNT(*) OVER (PARTITION BY JobTitle) AS Cumulative_Distribution
FROM Employee;
```

### Creating the Employee Table and Inserting Data

```sql
-- Creating the Employee table
CREATE TABLE Employee (
    BusinessEntityID INT PRIMARY KEY,
    JobTitle VARCHAR(50),
    SickLeaveHours INT
);

-- Inserting data into Employee table
INSERT INTO Employee (BusinessEntityID, JobTitle, SickLeaveHours) VALUES
(272, 'Application Specialist', 55),
(268, 'Application Specialist', 56),
(269, 'Application Specialist', 56),
(267, 'Application Specialist', 57);
```

### Key Points

- **PERCENTILE_DISC**: Finds the discrete value in the dataset that matches or exceeds the specified percentile.
- **PERCENTILE_CONT**: Calculates the continuous average value of a percentile within the dataset.
- MySQL does not directly support these functions but allows workarounds with subqueries or window functions.




## FIRST_VALUE Function

The `FIRST_VALUE` function is used to retrieve the first value in an ordered result set, identified using a scalar 
expression. This function is commonly used to find the first occurrence of a value within a specific ordering of rows.

### Usage

The `FIRST_VALUE` function is particularly useful when you want to determine the first value in a subset of data that 
meets certain conditions. The ordering of the result set is defined using the `OVER` clause with an `ORDER BY` statement.

### Creating the SalesTaxRate Table and Inserting Data

```sql
-- Creating the SalesTaxRate table
CREATE TABLE SalesTaxRate (
    StateProvinceID INT PRIMARY KEY,
    Name VARCHAR(100),
    TaxRate DECIMAL(5, 2)
);

-- Inserting data into SalesTaxRate table
INSERT INTO SalesTaxRate (StateProvinceID, Name, TaxRate) VALUES
(74, 'Utah State Sales', 5.00),
(36, 'Minnesota State Sales Tax', 6.75),
(30, 'Massachusetts State Sales Tax', 7.00),
(1, 'Canadian GST', 7.00),
(57, 'Canadian GST', 7.00),
(63, 'Canadian GST', 7.00);
```

### Example Usage

```sql
SELECT StateProvinceID, Name, TaxRate,
    FIRST_VALUE(StateProvinceID) OVER(ORDER BY TaxRate ASC) AS FirstValue
FROM SalesTaxRate;
```

In this example, the `FIRST_VALUE` function is used to return the ID of the state or province with the lowest tax rate. 
The `OVER` clause is used to order the tax rates to obtain the lowest rate.

**Result**:

| StateProvinceID | Name                          | TaxRate | FirstValue |
|-----------------|-------------------------------|---------|------------|
| 74              | Utah State Sales              | 5.00    | 74         |
| 36              | Minnesota State Sales Tax     | 6.75    | 74         |
| 30              | Massachusetts State Sales Tax | 7.00    | 74         |
| 1               | Canadian GST                  | 7.00    | 74         |
| 57              | Canadian GST                  | 7.00    | 74         |
| 63              | Canadian GST                  | 7.00    | 74         |

### MySQL Equivalent

MySQL 8.0 and above support the `FIRST_VALUE` function natively, and the syntax is the same as shown in the example. If
using MySQL 8.0 or later, you can directly use the above command.

For versions below MySQL 8.0, you may need to emulate the `FIRST_VALUE` function by using subqueries or other techniques 
to achieve a similar result.

### Key Points

- **FIRST_VALUE**: Retrieves the first value in a specified ordering of rows within a partition or the entire result set.
- **MySQL 8.0+**: Directly supports the `FIRST_VALUE` function, providing the same syntax as other SQL platforms.

### FIRST_VALUE Function with PARTITION BY and ORDER BY

#### Key Points

The `FIRST_VALUE` function can return different values for different rows if the ordering criteria used in the `OVER` 
clause change within partitions. Here's how:

1. **Partitioning by Another Column**:
    - If the `FIRST_VALUE` function is used with a `PARTITION BY` clause, it will return the first value within each 
      partition, resulting in potentially different `FirstValue` results for different rows.

2. **Changing the `ORDER BY` Criteria**:
    - If the `ORDER BY` clause inside the `OVER` clause changes, for example by ordering by different columns or using a
      different sorting order (ascending/descending), the first value can change accordingly.

### Example of Partitioning Effect

Consider adding a partition in the query:

```sql
SELECT StateProvinceID, Name, TaxRate,
    FIRST_VALUE(StateProvinceID) OVER(PARTITION BY Name ORDER BY TaxRate ASC) AS FirstValue
FROM SalesTaxRate;
```

**Result (hypothetical):**

| StateProvinceID | Name                          | TaxRate | FirstValue |
|-----------------|-------------------------------|---------|------------|
| 74              | Utah State Sales              | 5.00    | 74         |
| 36              | Minnesota State Sales Tax     | 6.75    | 36         |
| 30              | Massachusetts State Sales Tax | 7.00    | 30         |
| 1               | Canadian GST                  | 7.00    | 1          |
| 57              | Canadian GST                  | 7.00    | 1          |
| 63              | Canadian GST                  | 7.00    | 1          |

Here, `FirstValue` can differ because it’s now determined within each partition (`Name` column).

### Conclusion

- **Without `PARTITION BY`**, `FIRST_VALUE` returns the same value across the ordered set.
- **With `PARTITION BY`**, it adjusts based on each partition's ordered rows, potentially leading to varied results per 
  row.


## LAST_VALUE Function

The `LAST_VALUE` function provides the last value in an ordered result set, which is specified using a scalar expression.
It is used to retrieve the last value in a subset of data ordered by specified criteria.

### Usage

The `LAST_VALUE` function is particularly useful when you want to determine the last occurrence of a value within a 
specific ordering of rows. The ordering of the result set is defined using the `OVER` clause with an `ORDER BY` statement.

### Example Usage

```sql
SELECT TerritoryID, StartDate, BusinessentityID,
    LAST_VALUE(BusinessentityID) OVER(ORDER BY TerritoryID) AS LastValue
FROM SalesTerritoryHistory;
```

This example uses the `LAST_VALUE` function to return the last value for each rowset in the ordered values.

**Result**:

| TerritoryID | StartDate                 | BusinessentityID | LastValue |
|-------------|---------------------------|------------------|-----------|
| 1           | 2005-07-01 00:00:00.000   | 280              | 283       |
| 1           | 2006-11-01 00:00:00.000   | 284              | 283       |
| 1           | 2005-07-01 00:00:00.000   | 283              | 283       |
| 2           | 2007-01-01 00:00:00.000   | 277              | 275       |
| 2           | 2005-07-01 00:00:00.000   | 275              | 275       |
| 3           | 2007-01-01 00:00:00.000   | 275              | 277       |

### MySQL Equivalent

MySQL 8.0 and above support the `LAST_VALUE` function natively, using the same syntax as shown in the example. If you 
are using MySQL 8.0 or later, you can directly use the above command.

For versions below MySQL 8.0, you may need to emulate the `LAST_VALUE` function using subqueries or other techniques.

### Creating the SalesTerritoryHistory Table and Inserting Data

```sql
-- Creating the SalesTerritoryHistory table
CREATE TABLE SalesTerritoryHistory (
    TerritoryID INT,
    StartDate DATETIME,
    BusinessentityID INT
);

-- Inserting data into SalesTerritoryHistory table
INSERT INTO SalesTerritoryHistory (TerritoryID, StartDate, BusinessentityID) VALUES
(1, '2005-07-01 00:00:00.000', 280),
(1, '2006-11-01 00:00:00.000', 284),
(1, '2005-07-01 00:00:00.000', 283),
(2, '2007-01-01 00:00:00.000', 277),
(2, '2005-07-01 00:00:00.000', 275),
(3, '2007-01-01 00:00:00.000', 275);
```

### Key Points

- **LAST_VALUE**: Retrieves the last value in a specified ordering of rows within a partition or the entire result set.
- **MySQL 8.0+**: Directly supports the `LAST_VALUE` function, providing the same syntax as other SQL platforms.



## FIRST_VALUE vs LAST_VALUE with ORDER BY

### Key Differences

1. **FIRST_VALUE**: Always returns the same value across rows within the ordered set if only the `ORDER BY` clause is 
   used without any partition or window frame modifications.
    - This is because `FIRST_VALUE` consistently refers to the very first row in the ordered set, regardless of the 
      current row being processed.
    - As a result, the value remains unchanged across all rows.

2. **LAST_VALUE**: May return different values across rows even with the same `ORDER BY` clause if no explicit window 
   frame is defined.
    - By default, `LAST_VALUE` considers rows from the start of the partition up to the current row when calculating the 
      last value.
    - Therefore, the "last value" adjusts dynamically as the current row moves forward, reflecting the last value up to 
      that row.
    - This behavior causes `LAST_VALUE` to change depending on the row position within the ordered set.

### Example

Consider the following SQL query using `FIRST_VALUE` and `LAST_VALUE`:

```sql
SELECT TerritoryID, StartDate, BusinessentityID,
    FIRST_VALUE(BusinessentityID) OVER(ORDER BY TerritoryID) AS FirstValue,
    LAST_VALUE(BusinessentityID) OVER(ORDER BY TerritoryID) AS LastValue
FROM SalesTerritoryHistory;
```

**Possible Result**:

| TerritoryID | StartDate                 | BusinessentityID | FirstValue | LastValue |
|-------------|---------------------------|------------------|------------|-----------|
| 1           | 2005-07-01 00:00:00.000   | 280              | 280        | 280       |
| 1           | 2006-11-01 00:00:00.000   | 284              | 280        | 284       |
| 1           | 2005-07-01 00:00:00.000   | 283              | 280        | 283       |
| 2           | 2007-01-01 00:00:00.000   | 277              | 280        | 277       |
| 2           | 2005-07-01 00:00:00.000   | 275              | 280        | 275       |

### Conclusion

- **FIRST_VALUE** remains consistent because it always looks at the first row as defined by the `ORDER BY` clause.
- **LAST_VALUE** can change because it only considers rows from the start up to the current row unless an explicit 
  window frame is specified.

### Explicit Frame Control

To make `LAST_VALUE` behave like `FIRST_VALUE` in returning a consistent last value of the entire ordered set, define
the frame explicitly:

```sql
SELECT TerritoryID, StartDate, BusinessentityID,
    LAST_VALUE(BusinessentityID) 
    OVER(ORDER BY TerritoryID ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LastValue
FROM SalesTerritoryHistory;
```



## PERCENT_RANK and CUME_DIST

### Key Points

1. **PERCENT_RANK**:
    - The `PERCENT_RANK` function calculates the ranking of a row relative to the row set.
    - The percentage is based on the number of rows in the group that have a lower value than the current row.
    - The first value in the result set always has a percent rank of zero.
    - The value for the highest-ranked – or last – value in the set is always one.

2. **CUME_DIST**:
    - The `CUME_DIST` function calculates the relative position of a specified value in a group of values by determining
      the percentage of values less than or equal to that value.
    - This is called the cumulative distribution.

### SQL Example with `PERCENT_RANK` and `CUME_DIST`

```sql
SELECT BusinessEntityID, JobTitle, SickLeaveHours,
    PERCENT_RANK() OVER(PARTITION BY JobTitle ORDER BY SickLeaveHours DESC) AS "Percent Rank",
    CUME_DIST() OVER(PARTITION BY JobTitle ORDER BY SickLeaveHours DESC) AS "Cumulative Distribution"
FROM Employee;
```

### Explanation:
- **Partitioning**: The `PARTITION BY` clause groups rows by `JobTitle`.
- **Ordering**: Within each partition, rows are ordered by `SickLeaveHours` in descending order.
- **Output**:
    - `PERCENT_RANK` provides the rank of each row within the partition as a percentage of total rows minus one.
    - `CUME_DIST` provides the cumulative distribution by calculating the percentage of rows less than or equal to the 
      current row.

### Creating the Employee Table and Inserting Sample Data

```sql
-- Creating the Employee table
CREATE TABLE Employee (
    BusinessEntityID INT PRIMARY KEY,
    JobTitle VARCHAR(100),
    SickLeaveHours INT
);

-- Inserting sample data into the Employee table
INSERT INTO Employee (BusinessEntityID, JobTitle, SickLeaveHours) VALUES
(267, 'Application Specialist', 57),
(268, 'Application Specialist', 56),
(269, 'Application Specialist', 56),
(272, 'Application Specialist', 55),
(262, 'Assistant to the Chief Financial Officer', 48),
(239, 'Benefits Specialist', 45),
(252, 'Buyer', 50),
(251, 'Buyer', 49),
(256, 'Buyer', 49),
(253, 'Buyer', 48),
(254, 'Buyer', 48);
```

### Result

| BusinessEntityID | JobTitle                                 | SickLeaveHours | Percent Rank      | Cumulative Distribution |
|------------------|------------------------------------------|----------------|-------------------|-------------------------|
| 267              | Application Specialist                   | 57             | 0                 | 0.25                    |
| 268              | Application Specialist                   | 56             | 0.333333333333333 | 0.75                    |
| 269              | Application Specialist                   | 56             | 0.333333333333333 | 0.75                    |
| 272              | Application Specialist                   | 55             | 1                 | 1                       |
| 262              | Assistant to the Chief Financial Officer | 48             | 0                 | 1                       |
| 239              | Benefits Specialist                      | 45             | 0                 | 1                       |
| 252              | Buyer                                    | 50             | 0                 | 0.111111111111111       |
| 251              | Buyer                                    | 49             | 0.125             | 0.333333333333333       |
| 256              | Buyer                                    | 49             | 0.125             | 0.333333333333333       |
| 253              | Buyer                                    | 48             | 0.375             | 0.555555555555555       |
| 254              | Buyer                                    | 48             | 0.375             | 0.555555555555555       |

### Conclusion

- **PERCENT_RANK** ranks entries within each group, showing the percentage of rows that are lower.
- **CUME_DIST** shows the distribution of values, indicating how many rows have values less than or equal to the current
  row.

This allows you to see the relative standing of each row within its partition.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)