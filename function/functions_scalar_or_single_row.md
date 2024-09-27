SQL provides several built-in scalar functions. Each scalar function takes **one value** as input and returns one value
as output for **each row in a result set**.

You use scalar functions wherever an expression is allowed within a T-SQL statement.

## Date And Time
In SQL, you use date and time data types to store calendar information. These data types include the `time`, `date`,
`smalldatetime`, `datetime`, `datetime2`, and `datetimeoffset`. Each data type has a specific format.

| Data type         | Format                                      |
|-------------------|---------------------------------------------|
| `time`            | `hh:mm:ss[.nnnnnnn]`                        |
| `date`            | `YYYY-MM-DD`                                |
| `smalldatetime`   | `YYYY-MM-DD hh:mm:ss`                       |
| `datetime`        | `YYYY-MM-DD hh:mm:ss[.nnn]`                 |
| `datetime`        | `2YYYY-MM-DD hh:mm:ss[.nnnnnnn]`            | 
| `datetimeoffset`  | `YYYY-MM-DD hh:mm:ss[.nnnnnnn] [+/-]hh:mm`  |

### `DATENAME` and `DAYNAME`
The `DATENAME` for MS SQL Server and `DAYNAME` for MySQL functions return the name of the day of the week for a
specified date. The syntax for the function is the same in both SQL Server and MySQL.

**MS SQL Server**
```sql
SELECT DATENAME (weekday,'2017-01-14') as Datename;
```

**MySQL** doesn't have a `DATENAME` function. Instead, we can use the `DAYNAME` function.
```sql
SELECT DAYNAME('2017-01-14') as Datename;
```

**Output**

| Datename |
|----------|
| Saturday |


### `GETDATE` and `NOW`
`GETDATE` for MS SQL Server and `NOW` for MySQL functions return the current date and time of the computer running
the current SQL instance. This function doesn't include the time zone difference. 

**MS SQL Server**
```sql
SELECT GETDATE() as Systemdate;
```

| Systemdate                  |
|-----------------------------|
| 2017-01-14 11:11:47.7230728 |

**MySQL**
```sql
mysql> SELECT NOW() as Systemdate;
+---------------------+
| Systemdate          |
+---------------------+
| 2024-09-27 18:37:05 |
+---------------------+
1 row in set (0.00 sec)
```

### `DATEDIFF`
The `DATEDIFF` function returns the difference between two dates.

In the syntax, `datepart` is the parameter that specifies which part of the date you want to use to calculate the 
difference. The `datepart` can be `year`, `month`, `week`, `day`, `hour`, `minute`, `second`, or `millisecond`. You 
then specify the start date in the `startdate` parameter and the end date in the `enddate` parameter for which you want
to find the difference.

**SQL Server Example**:
```sql
-- Creating the table
CREATE TABLE SalesOrderHeader (
    SalesOrderID INT PRIMARY KEY,
    OrderDate DATE,
    ShipDate DATE
);

-- Inserting data into the table
INSERT INTO SalesOrderHeader (SalesOrderID, OrderDate, ShipDate) VALUES
(43659, '2024-09-01', '2024-09-08'),
(43660, '2024-09-02', '2024-09-09'),
(43661, '2024-09-03', '2024-09-10'),
(43662, '2024-09-04', '2024-09-11');

-- Using DATEDIFF function
SELECT SalesOrderID, DATEDIFF(day, OrderDate, ShipDate) AS 'Processing time'
FROM SalesOrderHeader;
```

**Output**:

| SalesOrderID | Processing time |
|--------------|-----------------|
| 43659        | 7               |
| 43660        | 7               |
| 43661        | 7               |
| 43662        | 7               |

### MySQL Equivalent
In MySQL, the syntax for `DATEDIFF` is simpler and does not require specifying the date part as it only calculates the 
difference in days.

```sql
-- Creating the table in MySQL
CREATE TABLE SalesOrderHeader (
    SalesOrderID INT PRIMARY KEY,
    OrderDate DATE,
    ShipDate DATE
);

-- Inserting data into the table
INSERT INTO SalesOrderHeader (SalesOrderID, OrderDate, ShipDate) VALUES
(43659, '2024-09-01', '2024-09-08'),
(43660, '2024-09-02', '2024-09-09'),
(43661, '2024-09-03', '2024-09-10'),
(43662, '2024-09-04', '2024-09-11');

-- Using DATEDIFF in MySQL
SELECT SalesOrderID, DATEDIFF(ShipDate, OrderDate) AS 'Processing time'
FROM SalesOrderHeader;
```



### `DATEADD`, `DATE_ADD`
The `DATEADD` function enables you to add an interval to part of a specific date.

**SQL Server Example**:
```sql
SELECT DATEADD(day, 20, '2017-01-14') AS Added20MoreDays;
```

**Output**:

| Added20MoreDays         |
|-------------------------|
| 2017-02-03 00:00:00.000 |

#### MySQL Equivalent
In MySQL, you can achieve similar results using the `DATE_ADD` function.

```sql
-- Using DATE_ADD in MySQL
SELECT DATE_ADD('2017-01-14', INTERVAL 20 DAY) AS Added20MoreDays;
```

**Output**:

| Added20MoreDays |
|-----------------|
| 2017-02-03      |



## Character Modifications
Character modifying functions are used for various text manipulations such as converting characters to upper or lower
case, formatting numbers, and other character-based operations.

### Converting Characters to Lowercase (`LOWER()`)
The `LOWER()` function converts the given character parameter to lowercase characters. This function is available in all 
major SQL databases, including SQL Server, MySQL, Oracle, and PostgreSQL.

**SQL Server / MySQL / Oracle / PostgreSQL**:
```sql
-- Example table creation
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_last_name VARCHAR(50)
);

-- Inserting data into the Customer table
INSERT INTO Customer (customer_id, customer_last_name) VALUES
(1, 'Smith'),
(2, 'JOHNSON'),
(3, 'WILLIAMS');

-- Using the LOWER function
SELECT customer_id, LOWER(customer_last_name) AS lower_last_name FROM Customer;
```

### Explanation:
- **LOWER() Function**: Converts the specified text to all lowercase characters.
- **Usage**: The function can be used directly in the `SELECT` statement on any text column.

### Result:
| customer_id | lower_last_name |
|-------------|-----------------|
| 1           | smith           |
| 2           | johnson         |
| 3           | williams        |

## Other Character Modifications

### Uppercase Conversion (`UPPER()`)
Converts all characters in a string to uppercase.
```sql
SELECT customer_id, UPPER(customer_last_name) AS upper_last_name FROM Customer;
```

### Character Length (`LENGTH()` / `LEN()`)
Returns the length of a string.

```sql
-- MySQL and Oracle use LENGTH, SQL Server uses LEN
SELECT customer_id, LENGTH(customer_last_name) AS name_length FROM Customer;
```

### Trimming Spaces (`TRIM()`, `LTRIM()`, `RTRIM()`)
Removes leading, trailing, or both leading and trailing spaces from a string.

```sql
SELECT TRIM('   Hello   ') AS trimmed_text; -- returns 'Hello'
```

### Substring Extraction (`SUBSTRING()` / `SUBSTR()`)
Extracts a portion of a string.

```sql
SELECT SUBSTRING(customer_last_name, 1, 3) AS short_name FROM Customer; -- returns the first 3 characters
```

### Key Points:
- These character modification functions enhance data readability and formatting in SQL queries.
- They are commonly used in data cleaning, reporting, and formatting outputs for user interfaces.



## Configuration and Conversion Functions

### Configuration Functions

An example of a configuration function in SQL Server is the `@@SERVERNAME` function. This function provides the name of 
the local server that's running SQL.

```sql
-- SQL Server: Get the server name
SELECT @@SERVERNAME AS 'Server';
```

**Output**:

| Server |
|--------|
| SQL064 |

### Conversion Functions

In SQL, most data conversions occur implicitly, without any user intervention. However, explicit conversion may be 
necessary, especially when the desired format is not the default.

### CAST and CONVERT Functions

To perform explicit conversions, you can use the `CAST` or `CONVERT` functions. The `CAST` function syntax is simpler
but limited compared to `CONVERT`.

- **CAST Function**: Converts expressions from one data type to another using default formatting (e.g., `YYYY-MM-DD` for
  dates).
- **CONVERT Function**: Converts expressions from one data type to another with optional formatting options specified by 
  style codes.

**Example**:
```sql
-- SQL Server Example
USE AdventureWorks2012;
GO
SELECT FirstName + ' ' + LastName + ' was hired on ' +
    CAST(HireDate AS varchar(20)) AS 'Cast',
    FirstName + ' ' + LastName + ' was hired on ' +
    CONVERT(varchar, HireDate, 3) AS 'Convert'
FROM Person.Person AS p
JOIN HumanResources.Employee AS e
ON p.BusinessEntityID = e.BusinessEntityID;
GO
```

**Output**:

| Cast                                     | Convert                               |
|------------------------------------------|---------------------------------------|
| David Hamilton was hired on 2003-02-04   | David Hamilton was hired on 04/02/03  |

### MySQL Equivalent

MySQL uses `CAST` similarly but does not have a direct equivalent of SQL Server's `CONVERT` with formatting codes. For
date formatting, you can use the `DATE_FORMAT()` function.

```sql
-- MySQL Example: CAST
SELECT CONCAT(FirstName, ' ', LastName, ' was hired on ', 
    CAST(HireDate AS CHAR)) AS 'Cast'
FROM Employees;

-- MySQL Example: DATE_FORMAT equivalent to CONVERT
SELECT CONCAT(FirstName, ' ', LastName, ' was hired on ', 
    DATE_FORMAT(HireDate, '%d/%m/%y')) AS 'Convert'
FROM Employees;
```

### PARSE Function

The `PARSE` function converts a string to a specified data type. It is primarily used in SQL Server for converting 
strings formatted according to specific cultures.

**SQL Server Example**:
```sql
SELECT PARSE('Monday, 13 August 2012' AS datetime2 USING 'en-US') AS 'Date in English';
```

**Output**:

| Date in English             |
|-----------------------------|
| 2012-08-13 00:00:00.0000000 |

### MySQL Equivalent

MySQL does not directly support `PARSE`. For parsing and converting strings, you would typically use `STR_TO_DATE()` or 
`DATE_FORMAT()` functions.

```sql
-- MySQL Equivalent for parsing date strings
SELECT STR_TO_DATE('Monday, 13 August 2012', '%W, %d %M %Y') AS 'Date in English';
```

### Key Points
- **CAST vs. CONVERT**: `CAST` is simpler but limited to default formats. `CONVERT` allows formatting options but is 
  primarily SQL Server specific.
- **PARSE Function**: SQL Server’s `PARSE` is useful for cultural date and time formatting, but equivalent functionality
  in MySQL can be achieved using `STR_TO_DATE()`.

These functions provide powerful ways to handle data conversions and configurations in SQL queries.




## Logical and Mathematical Functions

SQL includes logical functions like `CHOOSE` and `IIF`, as well as several mathematical functions for performing 
calculations on input values and returning numeric results.

### Logical Functions

#### CHOOSE Function
The `CHOOSE` function returns an item from a list of values, based on its position in the list. This position is 
specified by the index.

- **Syntax**: `CHOOSE(index, val_1, val_2, ..., val_n)`
- **Parameters**:
    - `index`: Specifies the position of the item (integer).
    - `val_1 … val_n`: Identifies the list of values.

**Example**:
```sql
SELECT CHOOSE(2, 'Human Resources', 'Sales', 'Admin', 'Marketing') AS Result;
```

**Output**:

| Result  |
|---------|
| Sales   |

**Explanation**: This example uses the `CHOOSE` function to return the second entry in a list of departments.

#### IIF Function
The `IIF` function returns one of two values, based on a particular condition. If the condition is true, it returns the
true value; otherwise, it returns the false value.

- **Syntax**: `IIF(boolean_expression, true_value, false_value)`
- **Parameters**:
    - `boolean_expression`: Specifies the condition to evaluate.
    - `true_value`: Returned if the condition is true.
    - `false_value`: Returned if the condition is false.

**Example**:
```sql
SELECT BusinessEntityID, SalesYTD,
    IIF(SalesYTD > 200000, 'Bonus', 'No Bonus') AS 'Bonus?'
FROM Sales.SalesPerson;
```

**Output**:

| BusinessEntityID | SalesYTD      | Bonus?   |
|------------------|---------------|----------|
| 274              | 559697.5639   | Bonus    |
| 275              | 3763178.1787  | Bonus    |
| 285              | 172524.4512   | No Bonus |

**Explanation**: This example uses the `IIF` function to determine whether a salesperson's year-to-date sales qualify
them for a bonus based on a threshold of 200,000.

### Mathematical Functions

#### SIGN Function
The `SIGN` function returns a value indicating the sign of an expression. The result is -1 for negative values, +1 for 
positive values, and 0 for zero.

- **Syntax**: `SIGN(expression)`

**Example**:
```sql
SELECT SIGN(-20) AS 'Sign';
```

**Output**:

| Sign |
|------|
| -1   |

**Explanation**: In this example, the input is a negative number, so the result is -1.

#### POWER Function
The `POWER` function raises a number to a specified power.

- **Syntax**: `POWER(float_expression, y)`
- **Parameters**:
    - `float_expression`: The base number.
    - `y`: The exponent.

**Example**:
```sql
SELECT POWER(50, 3) AS Result;
```

**Output**:

| Result   |
|----------|
| 125000   |

**Explanation**: This example calculates 50 raised to the power of 3, resulting in 125000.

### Key Points
- Logical functions like `CHOOSE` and `IIF` are used for making decisions within queries.
- Mathematical functions such as `SIGN` and `POWER` are used to perform calculations and assess the properties of 
  numerical data.

These functions add powerful capabilities for data manipulation and decision-making in SQL.


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)