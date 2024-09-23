## UPDATE with data from another table
The examples below fill in a `PhoneNumber` for any `Employee` who is also a `Customer` and currently does not have a 
phone number set in the `Employees` Table.

(These examples use the `Employees` and `Customers` tables from the Example Databases.)
```sql
mysql> SELECT * FROM Employees;
+------------+-------+---------+--------------+
| EmployeeID | FName | LName   | PhoneNumber  |
+------------+-------+---------+--------------+
|          1 | John  | Doe     | NULL         |
|          2 | Jane  | Smith   | NULL         |
|          3 | Alice | Johnson | 123-456-7890 |
+------------+-------+---------+--------------+
3 rows in set (0.01 sec)

mysql> SELECT * FROM Customers;
+------------+-------+----------+--------------+
| CustomerID | FName | LName    | PhoneNumber  |
+------------+-------+----------+--------------+
|          1 | John  | Doe      | 987-654-3210 |
|          2 | Jane  | Smith    | 456-789-1234 |
|          3 | Bob   | Williams | 789-123-4567 |
+------------+-------+----------+--------------+
3 rows in set (0.00 sec)
```

<details>
<summary>Creation of the Employees and Customers tables and data insertion</summary>

```sql
use learning_sql;

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    PhoneNumber VARCHAR(15) NULL
);

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    PhoneNumber VARCHAR(15)
);

-- Insert sample data into Employees table
INSERT INTO Employees (EmployeeID, FName, LName, PhoneNumber) VALUES
(1, 'John', 'Doe', NULL),
(2, 'Jane', 'Smith', NULL),
(3, 'Alice', 'Johnson', '123-456-7890');

-- Insert sample data into Customers table
INSERT INTO Customers (CustomerID, FName, LName, PhoneNumber) VALUES
(1, 'John', 'Doe', '987-654-3210'),
(2, 'Jane', 'Smith', '456-789-1234'),
(3, 'Bob', 'Williams', '789-123-4567');
```
</details>



### Standard SQL
Update using a correlated subquery:
<details>
<summary>Details of this SQL command</summary>

This document provides a detailed explanation of how the SQL `UPDATE` statement works using a correlated subquery to
update the `PhoneNumber` column in the `Employees` table from the `Customers` table based on matching first and last
names.

## SQL Update Statement

### Original SQL Command:

```sql
UPDATE 
    Employees 
SET PhoneNumber = 
    (SELECT 
         c.PhoneNumber
     FROM
         Customers c
     WHERE 
         c.FName = Employees.FName
         AND c.LName = Employees.LName)           
WHERE Employees.PhoneNumber IS NULL;
```

## How the SQL Command Works:

1. **Objective**: The SQL `UPDATE` command is used to fill in missing phone numbers (`NULL` values) in the `Employees` table by pulling phone numbers from the `Customers` table where the `first name` and `last name` match.

   2. **Correlated Subquery**:
       - The subquery:
         ```sql
         SELECT 
            c.PhoneNumber
         FROM
            Customers c
         WHERE
            c.FName = Employees.FName
                AND c.LName = Employees.LName
         ```
         is correlated because it refers to columns from the outer `Employees` table.
         It's equvalent sql using `JOIN` as previous one will not work in MySQL as standalone query but will work as subquery.
         ```sql
         SELECT 
            c.PhoneNumber
         FROM
            Customers c, Employees e
         WHERE
            c.FName = e.FName
                AND c.LName = e.LName;
         +--------------+
         | PhoneNumber  |
         +--------------+
         | 987-654-3210 |
         | 456-789-1234 |
         +--------------+
         2 rows in set (0.00 sec)
         ```
       - This subquery returns the `PhoneNumber` from `Customers` that matches each employee's first and last name.

3. **Where Clause**:
    - The `WHERE Employees.PhoneNumber IS NULL` condition ensures that only employees who currently have no phone number will be updated.

## Key Conditions for Successful Updates:

1. **One-to-One Match**: The update works correctly only if there is exactly one matching customer for each employee. If multiple customers match, SQL will throw an error (`Subquery returns more than one row`).

2. **No Match Found**: If no customer matches the employee’s name, the `PhoneNumber` will remain `NULL`.

3. **Case Sensitivity**: Matching may be case-sensitive depending on database settings. Functions like `UPPER()` or `LOWER()` can be used to standardize comparisons.

## Scenarios:

1. **Exact Match**:
    - Employees with names matching exactly to a customer will get the corresponding phone number.

2. **Multiple Matches**:
    - If multiple customers have the same `FName` and `LName`, the subquery will fail. Consider ensuring uniqueness or modifying the query to handle duplicates.

3. **No Matches**:
    - Employees without a matching customer in `Customers` will not have their phone number updated.

## Preventing Multiple Row Errors:

To avoid errors when there are multiple matches, you can modify the subquery with `LIMIT 1`:

```sql
UPDATE 
    Employees 
SET PhoneNumber = 
    (SELECT 
         c.PhoneNumber
     FROM
         Customers c
     WHERE 
         c.FName = Employees.FName
         AND c.LName = Employees.LName
     LIMIT 1)            
WHERE Employees.PhoneNumber IS NULL;
```

### Note:
- Using `LIMIT 1` arbitrarily selects the first row if multiple matches exist, which may not be the desired behavior.
- It's recommended to ensure that the data is unique or select the most appropriate match based on additional conditions.

## Summary:
- This `UPDATE` command effectively updates `PhoneNumber` for employees with missing values based on corresponding data in the `Customers` table.
- Proper data management and unique constraints are essential to avoid subquery errors and ensure accurate updates.
</details>

```sql
UPDATE 
      Employees 
SET PhoneNumber = 
      (SELECT 
           c.PhoneNumber
       FROM
           Customers c
       WHERE 
           c.FName = Employees.FName
           AND c.LName = Employees.LName)           
WHERE Employees.PhoneNumber IS NULL;
```

SQL:2003
```sql
MERGE INTO
    Employees e
USING
    Customers c
ON
    e.FName = c.Fname
    AND e.LName = c.LName
    AND e.PhoneNumber IS NULL
WHEN MATCHED THEN
    UPDATE
        SET PhoneNumber = c.PhoneNumber
```
SQL Server

Update using INNER JOIN:
```sql
UPDATE
    Employees
SET
    PhoneNumber = c.PhoneNumber
FROM
    Employees e
INNER JOIN Customers c
    ON e.FName = c.FName
    AND e.LName = c.LName
WHERE
    PhoneNumber IS NULL
```

After running the above SQL command, the `Employees` table will be updated as follows:
```sql
mysql> SELECT * FROM Employees;
+------------+-------+---------+--------------+
| EmployeeID | FName | LName   | PhoneNumber  |
+------------+-------+---------+--------------+
|          1 | John  | Doe     | 987-654-3210 |
|          2 | Jane  | Smith   | 456-789-1234 |
|          3 | Alice | Johnson | 123-456-7890 |
+------------+-------+---------+--------------+
3 rows in set (0.00 sec)
```


## Modifying existing values
This example uses the Cars Table from the Example Databases.
```sql
UPDATE Cars
SET TotalCost = TotalCost + 100
WHERE Id = 3 or Id = 4
```
Update operations can include current values in the updated row. In this simple example the TotalCost is
incremented by 100 for two rows:
* The TotalCost of Car #3 is increased from 100 to 200
* The TotalCost of Car #4 is increased from 1254 to 1354

A column's new value may be derived from its previous value or from any other column's value in the same table or a 
joined table.

## Updating Specified Rows
This example uses the Cars Table from the Example Databases.

```sql
UPDATE
    Cars
SET
    Status = 'READY'
WHERE
    Id = 4
```
This statement will set the status of the row of 'Cars' with id 4 to "READY".

WHERE clause contains a logical expression which is evaluated for each row. If a row fulfills the criteria, its value is
updated. Otherwise, a row remains unchanged.

## Updating All Rows
This example uses the Cars Table from the Example Databases.
```sql
UPDATE Cars
    SET Status = 'READY'
```
This statement will set the 'status' column of all rows of the 'Cars' table to "READY" because it does not have a WHERE
clause to filter the set of rows.

////TODO: have to modified Capturing Updated records
## Capturing Updated records
Sometimes one wants to capture the records that have just been updated.]
```sql
CREATE TABLE #TempUpdated(ID INT)

Update TableName SET Col1 = 42
    OUTPUT inserted.ID INTO #TempUpdated
    WHERE Id > 50
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)