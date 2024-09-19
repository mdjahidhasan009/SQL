# Match open-ended pattern
The `%` wildcard can be appended to the beginning or end (or both) of a string will allow `0` or more of any character 
before the beginning or after the end of the pattern to match.

Using `'%'` in the middle will allow `0` or more characters between the two parts of the pattern to match.

<details>
<summary>SQL for Employees table creation and data insertion</summary>

```sql
CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    FName VARCHAR(50) NOT NULL,
    LName VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15),
    ManagerId INT,
    DepartmentId INT,
    Salary DECIMAL(10,2),
    Hire_date DATE
);

INSERT INTO Employees (Id, FName, LName, PhoneNumber, ManagerId, DepartmentId, Salary, Hire_date) VALUES
(1, 'John', 'Johnson', '2468101214', 1, 1, 400.00, '2005-03-23'),
(2, 'Sophie', 'Amudsen', '2479100211', 1, 1, 400.00, '2010-01-11'),
(3, 'Ronny', 'Smith', '2462544026', 2, 1, 6000.00, '2015-08-06'),
(4, 'Jon', 'Sanchez', '2454124602', 1, 1, 400.00, '2005-03-23'),
(5, 'Hilde', 'Knag', '2468021911', 2, 1, 800.00, '2000-01-01');
```
</details>

We are going to use this Employees Table:

| Id  | FName  | LName   | PhoneNumber | ManagerId | DepartmentId | Salary | Hire_date    |
|-----|--------|---------|-------------|-----------|--------------|--------|--------------|
| 1   | John   | Johnson | 2468101214  | 1         | 1            | 400    | 23-03-2005   |
| 2   | Sophie | Amudsen | 2479100211  | 1         | 1            | 400    | 11-01-2010   |
| 3   | Ronny  | Smith   | 2462544026  | 2         | 1            | 6000   | 6-08-2015    |
| 4   | Jon    | Sanchez | 2454124602  | 1         | 1            | 400    | 23-03-2005   |
| 5   | Hilde  | Knag    | 2468021911  | 2         | 1            | 800    | 01-01-2000   |


Following statement matches for all records having FName **containing** string `'on'` from Employees Table.
```sql
SELECT * FROM Employees WHERE FName LIKE '%on%';
```
| Id | FName     | LName   | PhoneNumber | ManagerId | DepartmentId | Salary | Hire_date  |
|----|-----------|---------|-------------|-----------|--------------|--------|------------| 
| 3  | R**on**ny | Smith   | 2462544026  | 2         | 1            | 600    | 06-08-2015 | 
| 4  | J**on**   | Sanchez | 2454124602  | 1         | 1            | 400    | 23-03-2005 | 


Following statement matches all records having PhoneNumber **starting with** string `'246'` from Employees.
```sql
SELECT * FROM Employees WHERE PhoneNumber LIKE '246%';
```
| Id | FName  | LName   | PhoneNumber    | ManagerId | DepartmentId | Salary | Hire_date   |
|----|--------|---------|----------------|-----------|--------------|--------|-------------|
| 1  | Jon    | Sanchez | **245**4124602 | 1         | 1            | 400    | 23-03-2005  |
| 3  | Ronny  | Smith   | **246**2544026 | 2         | 1            | 6000   | 6-08-2015   |
| 5  | Hilde  | Knag    | **246**8021911 | 2         | 1            | 800    | 01-01-2000  |


Following statement matches all records having PhoneNumber **ending with** string `'11'` from Employees.
```sql
SELECT * FROM Employees WHERE PhoneNumber LIKE '%11';
```
| Id  | FName  | LName   | PhoneNumber    | ManagerId | DepartmentId | Salary | Hire_date    |
|-----|--------|---------|----------------|-----------|--------------|--------|--------------|
| 2   | Sophie | Amudsen | 24791002**11** | 1         | 1            | 400    | 11-01-2010   |
| 5   | Hilde  | Knag    | 24680219**11** | 2         | 1            | 800    | 01-01-2000   |


All records where `Fname` 3rd character is `'n'` from Employees.
```sql
SELECT * FROM Employees WHERE FName LIKE '__n%';
```
(two underscores are used before `'n'` to skip first 2 characters)

| Id  | FName     | LName   | PhoneNumber | ManagerId | DepartmentId | Salary | Hire_date    |
|-----|-----------|---------|-------------|-----------|--------------|--------|--------------|
| 3   | Ro**n**ny | Smith   | 2462544026  | 2         | 1            | 6000   | 6-08-2015    |
| 4   | Jo**n**   | Sanchez | 2454124602  | 1         | 1            | 400    | 23-03-2005   |

## Single character match
To broaden the selections of a structured query language (SQL-SELECT) statement, wildcard characters, the percent sign 
`(%)` and the underscore `(_)`, can be used.

The `_` (underscore) character can be used as a wildcard for any single character in a pattern match.

Find all employees whose `Fname` start with `'j'` and end with `'n'` and has exactly 3 characters in `Fname`.
```sql
SELECT * FROM Employees WHERE FName LIKE 'j_n';
```
| Id | FName   | LName   | PhoneNumber | ManagerId | DepartmentId | Salary | Hire_date  |
|----|---------|---------|-------------|-----------|--------------|--------|------------|
|  4 | **Jon** | Sanchez | 2454124602  |         1 |            1 | 400.00 | 2005-03-23 |

`_` (underscore) character can also be used more than once as a wild card to match patterns.

For example, this pattern would match "jon", "jan", "jen", etc.

These names will not be shown `"jn"`,`"john"`,`"jordan"`, `"justin"`, `"jason"`, `"julian"`, `"jillian"`, `"joann"` 
because in our query one underscore is used, and it can skip exactly one character, so result must be of 3 character 
`Fname`.

For example, this pattern would match `"LaSt"`, `"LoSt"`, `"HaLt"`, etc.
```sql 
SELECT * FROM Employees WHERE FName LIKE '_A_T';
```




# Using ESCAPE Statement in LIKE-Query for Text Search

When implementing a text search in SQL, a common approach is to use the `LIKE` clause. A typical `LIKE` query looks like
this:

```sql
SELECT *
FROM T_Whatever
WHERE SomeField LIKE CONCAT('%', @in_SearchText, '%');
```

This query searches for any occurrence of the `@in_SearchText` within `SomeField`, regardless of what comes before or
after it. The `%` symbols are wildcards that represent any sequence of characters.

### Example Table

Assume the following table `T_Whatever`:

| Id | SomeField        |
|----|------------------|
| 1  | abc_def          |
| 2  | 50% Discount     |
| 3  | Affordable items |
| 4  | Sale 50% off     |
| 5  | a_b matches      |

### Example Query Execution

Input: `@in_SearchText = '50%'`

Output:

| Id | SomeField      |
|----|----------------|
| 2  | 50% Discount   |
| 4  | Sale 50% off   |

This output demonstrates that the query correctly matches any occurrence of `"50%"` within `SomeField`, as expected.

## The Problem with Special Characters

However, using `LIKE` in this way can lead to issues when the search text contains special characters used by `LIKE` for
pattern matching, such as:

- **`%`**: Represents zero, one, or multiple characters.
- **`_`**: Represents a single character.

For example, if the user inputs search strings like `"50%"` or `"a_b"`, the query may produce incorrect results because
the `%` and `_` characters are interpreted as wildcards rather than as literal characters.

### Example Problematic Scenarios

1. **Input "50%"**:
    - The `%` is treated as a wildcard, so the search will match any string that starts with `"50"` followed by any 
    sequence of characters.

2. **Input "a_b"**:
    - The `_` is treated as a wildcard for a single character, so the search will match strings like `"a1b"`, `"a2b"`, 
      etc.

## Solution: Using the ESCAPE Clause

Instead of switching to full-text search, which may be overkill in some scenarios, you can solve this issue by using the
`ESCAPE` clause with the `LIKE` statement. This allows you to define an escape character that tells SQL to treat certain
characters literally rather than as wildcards.

### Using ESCAPE in a LIKE Query

Here’s how you can implement the `ESCAPE` statement:

```sql
SELECT *
FROM T_Whatever
WHERE SomeField LIKE CONCAT('%', @in_SearchText, '%') ESCAPE '\';
```

### Example Table

| Id | SomeField        |
|----|------------------|
| 1  | abc_def          |
| 2  | 50% Discount     |
| 3  | Affordable items |
| 4  | Sale 50% off     |
| 5  | a_b matches      |

### Example Query Execution

Input: `@in_SearchText = '50%'`

Output:

| Id | SomeField      |
|----|----------------|
| 2  | 50% Discount   |
| 4  | Sale 50% off   |

In this example, `\` is set as the escape character. This means you can prepend `\` to any special character (like `%` 
or `_`) in the search text to ensure it's treated as a literal character rather than as a wildcard.

### How to Escape Special Characters Programmatically

To ensure the search text is correctly escaped, you can preprocess the input string by prepending the escape character
(`\`) to any special character:

#### Example Code

```csharp
string stringToSearch = "abc_def 50%";
string newString = "";
foreach(char c in stringToSearch)
    newString += @"\" + c; // Prepend escape character
sqlCmd.Parameters.Add("@in_SearchText", newString);
// Instead of sqlCmd.Parameters.Add("@in_SearchText", stringToSearch);
```

### Important Notes:
1. **Handling Multi-Character Graphemes**:
    - The above code demonstrates a basic algorithm for escaping individual characters. However, it does not work
      correctly for graphemes composed of multiple Unicode characters, such as `"Les Mise\u0301rables"`.
    - In these cases, the escape mechanism should be applied to each grapheme cluster rather than each individual 
      character.

2. **Dealing with Non-Western Languages**:
    - If dealing with Asian, East-Asian, or South-Asian languages, the above approach is not reliable as grapheme 
      clusters in these languages may consist of several characters.
    - Proper handling would involve iterating over grapheme clusters instead of characters.

3. **Correct Usage for Different Languages**:
    - Ensure the escaping is adapted to the specific requirements of the language you are working with to avoid 
      incorrect handling of characters.

## Conclusion

Using the `ESCAPE` statement with `LIKE` queries allows you to handle special characters correctly without switching to
full-text search. This approach ensures that characters such as `%` and `_` are treated as literals, preventing 
incorrect matches in your search results. However, it's important to carefully handle multi-character graphemes,
especially when working with complex or non-Western languages.



## Search for a range of characters
***SQL Server*** and ***MySQL*** have different syntax for matching a range of characters.
* **SQL Server**: Use `LIKE` with square brackets `[]` to match a range of characters.
* **MySQL**: Use `REGEXP` with a range of characters.

Following statement matches all records having FName that starts with a letter from A to F from Employees Table.
**SQL Server**
```sql
SELECT * FROM Employees WHERE FName LIKE '[A-F]%'
```
**MySQL**
```sql
mysql> SELECT * FROM Employees WHERE FName REGEXP '^[A-F]';
Empty set (0.00 sec)

mysql> SELECT * FROM Employees WHERE FName REGEXP '^[H-J]';
+----+-------+---------+-------------+-----------+--------------+--------+------------+
| Id | FName | LName   | PhoneNumber | ManagerId | DepartmentId | Salary | Hire_date  |
+----+-------+---------+-------------+-----------+--------------+--------+------------+
|  1 | John  | Johnson | 2468101214  |         1 |            1 | 400.00 | 2005-03-23 |
|  4 | Jon   | Sanchez | 2454124602  |         1 |            1 | 400.00 | 2005-03-23 |
|  5 | Hilde | Knag    | 2468021911  |         2 |            1 | 800.00 | 2000-01-01 |
+----+-------+---------+-------------+-----------+--------------+--------+------------+
3 rows in set (0.00 sec)
```

### Match by range or set
***SQL Server*** and ***MySQL*** have different syntax for matching a range of characters.
* **SQL Server**: Use `LIKE` with square brackets `[]` to match a range of characters.
* **MySQL**: Use `REGEXP` with a range of characters.

<details>
<summary>SQL for inserting two more records in Employees table</summary>

```sql
INSERT INTO Employees (Id, FName, LName, PhoneNumber, ManagerId, DepartmentId, Salary, Hire_date) VALUES
(6, 'gary', 'Johnson', '2468101214', 3, 1, 400.00, '2005-03-23'),
(7, 'mary', 'Johnson', '2468101214', 2, 1, 400.00, '2005-03-23');
```
</details>

Current Employees Table:
```sql
mysql> SELECT * FROM Employees;
+----+--------+---------+-------------+-----------+--------------+---------+------------+
| Id | FName  | LName   | PhoneNumber | ManagerId | DepartmentId | Salary  | Hire_date  |
+----+--------+---------+-------------+-----------+--------------+---------+------------+
|  1 | John   | Johnson | 2468101214  |         1 |            1 |  400.00 | 2005-03-23 |
|  2 | Sophie | Amudsen | 2479100211  |         1 |            1 |  400.00 | 2010-01-11 |
|  3 | Ronny  | Smith   | 2462544026  |         2 |            1 | 6000.00 | 2015-08-06 |
|  4 | Jon    | Sanchez | 2454124602  |         1 |            1 |  400.00 | 2005-03-23 |
|  5 | Hilde  | Knag    | 2468021911  |         2 |            1 |  800.00 | 2000-01-01 |
|  6 | gary   | Johnson | 2468101214  |         3 |            1 |  400.00 | 2005-03-23 |
|  7 | mary   | Johnson | 2468101214  |         2 |            1 |  400.00 | 2005-03-23 |
+----+--------+---------+-------------+-----------+--------------+---------+------------+
7 rows in set (0.00 sec)
```

Match any single character within the specified range (e.g.: `[a-f]`) or set (e.g.: `[abcdef]`).

This range pattern would match "gary" but not "mary":
**SQL Server**
```sql
SELECT * FROM Employees WHERE FName LIKE '[a-g]ary'
```
**MySQL**
```sql
mysql> SELECT * FROM Employees WHERE FName REGEXP '[a-g]ary';
+----+-------+---------+-------------+-----------+--------------+--------+------------+
| Id | FName | LName   | PhoneNumber | ManagerId | DepartmentId | Salary | Hire_date  |
+----+-------+---------+-------------+-----------+--------------+--------+------------+
|  6 | gary  | Johnson | 2468101214  |         3 |            1 | 400.00 | 2005-03-23 |
+----+-------+---------+-------------+-----------+--------------+--------+------------+
1 row in set (0.00 sec)
```

This set pattern would match "mary" but not "gary":
**SQL Server**
```sql
SELECT * FROM Employees WHERE Fname LIKE '[lmnop]ary'
**MySQL**
```sql
mysql> SELECT * FROM Employees WHERE FName REGEXP '[lmnop]ary';
+----+-------+---------+-------------+-----------+--------------+--------+------------+
| Id | FName | LName   | PhoneNumber | ManagerId | DepartmentId | Salary | Hire_date  |
+----+-------+---------+-------------+-----------+--------------+--------+------------+
|  7 | mary  | Johnson | 2468101214  |         2 |            1 | 400.00 | 2005-03-23 |
+----+-------+---------+-------------+-----------+--------------+--------+------------+
1 row in set (0.00 sec)
```

The range or set can also be negated(like not in range or set) by appending the `^` caret before the range or set:
This range pattern would not match "gary" but will match "mary":
**SQL Server**
```sql
SELECT * FROM Employees WHERE FName LIKE '[^a-g]ary'
```
**MySQL**
```sql
mysql> SELECT * FROM Employees WHERE FName REGEXP '^[^a-g]ary';
+----+-------+---------+-------------+-----------+--------------+--------+------------+
| Id | FName | LName   | PhoneNumber | ManagerId | DepartmentId | Salary | Hire_date  |
+----+-------+---------+-------------+-----------+--------------+--------+------------+
|  7 | mary  | Johnson | 2468101214  |         2 |            1 | 400.00 | 2005-03-23 |
+----+-------+---------+-------------+-----------+--------------+--------+------------+
1 row in set (0.00 sec)
```

This set pattern would not match "mary" but will match"gary":
**SQL Server**
```sql
SELECT * FROM Employees WHERE Fname LIKE '[^lmnop]ary'
```
**MySQL**
```sql
mysql> SELECT * FROM Employees WHERE FName REGEXP '^[^lmnop]ary';
+----+-------+---------+-------------+-----------+--------------+--------+------------+
| Id | FName | LName   | PhoneNumber | ManagerId | DepartmentId | Salary | Hire_date  |
+----+-------+---------+-------------+-----------+--------------+--------+------------+
|  6 | gary  | Johnson | 2468101214  |         3 |            1 | 400.00 | 2005-03-23 |
+----+-------+---------+-------------+-----------+--------------+--------+------------+
1 row in set (0.00 sec)
```

## Wildcard characters
wildcard characters are used with the SQL `LIKE` operator. SQL wildcards are used to search for data within a table.

Wildcards in SQL are:`%`, `_`, `[charlist]`, `[^charlist]`

**%** - A substitute for zero or more characters
Eg:
```sql
//selects all customers with a City starting with "Lo"
SELECT * FROM Customers
WHERE City LIKE 'Lo%';

//selects all customers with a City containing the pattern "es"
SELECT * FROM Customers
WHERE City LIKE '%es%';
```
**_** - A substitute for a single character
```sql
Eg://selects all customers with a City starting with any character, followed by "erlin"
SELECT * FROM Customers
WHERE City LIKE '_erlin';
```
**[charlist]** - Sets and ranges of characters to match
```sql
Eg://selects all customers with a City starting with "a", "d", or "l"
SELECT * FROM Customers
WHERE City LIKE '[adl]%';

//selects all customers with a City starting with "a", "d", or "l"
SELECT * FROM Customers
WHERE City LIKE '[a-c]%';
```

**[^charlist]** - Matches only a character NOT specified within the brackets
```sql
Eg://selects all customers with a City starting with a character that is not "a", "p", or "l"
SELECT * FROM Customers
WHERE City LIKE '[^apl]%';
```
or
```sql
SELECT * FROM Customers
WHERE City NOT LIKE '[apl]%' and city like '_%';    
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)