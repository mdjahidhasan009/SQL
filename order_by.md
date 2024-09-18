# ORDER BY
## Sorting by column number (instead of name)
You can use a column's number (where the leftmost column is '1') to indicate which column to base the sort on, instead 
of describing the column by its name

**Pro:** If you think it's likely you might change column names later, doing so won't break this code.

**Con:** This will generally reduce readability of the query (It's instantly clear what `ORDER BY Reputation` means, 
while `ORDER BY 14` requires some counting, probably with a finger on the screen.)

This query sorts result by the info in relative column position 3 from select statement instead of column name
Reputation.

<details>
<summary>Make ready the database</summary>

```sql
CREATE DATABASE learning_sql;
use learning_sql;

CREATE TABLE Users (
    DisplayName VARCHAR(100) NOT NULL,
    JoinData DATE NOT NULL,
    Reputation INT NOT NULL
);

ALTER TABLE Users
RENAME COLUMN JoinData TO JoinDate;

INSERT INTO Users (DisplayName, JoinDate, Reputation) VALUES
('Community', '2008-09-15', 1),
('Jarrod Dixon', '2008-10-03', 11739),
('Geoff Dalgas', '2008-10-03', 12567),
('Joel Spolsky', '2008-09-16', 25784),
('Jeff Atwood', '2008-09-16', 37628);

SELECT * FROM Users;
SELECT DisplayName, JoinDate, Reputation FROM Users ORDER BY 3;
+--------------+------------+------------+
| DisplayName  | JoinDate   | Reputation |
+--------------+------------+------------+
| Community    | 2008-09-15 |          1 |
| Jarrod Dixon | 2008-10-03 |      11739 |
| Geoff Dalgas | 2008-10-03 |      12567 |
| Joel Spolsky | 2008-09-16 |      25784 |
| Jeff Atwood  | 2008-09-16 |      37628 |
+--------------+------------+------------+
5 rows in set (0.00 sec)
```
</details>

```sql
SELECT DisplayName, JoinDate, Reputation FROM Users ORDER BY 3;
```

| DisplayName  | JoinDate   | Reputation |
|--------------|------------|------------|
| Community    | 2008-09-15 | 1          | 
| Jarrod Dixon | 2008-10-03 | 11739      | 
| Geoff Dalgas | 2008-10-03 | 12567      | 
| Joel Spolsky | 2008-09-16 | 25784      | 
| Jeff Atwood  | 2008-09-16 | 37628      | 

## Use ORDER BY with TOP to return the top x rows based on a column's value
In this example, we can use `ORDER BY` not only to determine the sort order of the rows returned but also which rows are
returned, since we're using `TOP` to limit the result set.

Let's say we want to return the top 5 highest reputation users from an unnamed popular Q&A site.

### Without ORDER BY

This query returns the Top 5 rows ordered by the default, which in this case is "Id", the first column in the table (even 
though it's not a column shown in the results).

**SQL Server**
```sql
SELECT TOP 5 DisplayName, Reputation
FROM Users;
```
**MySQL**
```sql
SELECT DisplayName, Reputation
FROM Users
LIMIT 5;
```

returns...

| DisplayName  | Reputation |
|--------------|------------|
| Community    | 1          |
| Geoff Dalgas | 12567      |
| Jarrod Dixon | 11739      |
| Jeff Atwood  | 37628      |
| Joel Spolsky | 25784      |

### With ORDER BY
**SQL Server**
```sql
SELECT TOP 5 DisplayName, Reputation
FROM Users
ORDER BY Reputation desc
```
**MySQL**
```sql
SELECT DisplayName, Reputation
FROM Users
ORDER BY Reputation DESC
LIMIT 5
```
returns...

| DisplayName    | Reputation |
|----------------|------------|
| JonSkeet       | 865023     |
| Darin Dimitrov | 661741     |
| BalusC         | 650237     |
| Hans Passant   | 625870     |
| Marc Gravell   | 601636     |

**Remarks**

Some versions of SQL (such as MySQL) use a `LIMIT` clause at the end of a `SELECT`, instead of `TOP` at the beginning, 
for example:
```sql
SELECT DisplayName, Reputation
FROM Users
ORDER BY Reputation DESC
LIMIT 5
```

## Customized sorting order

To sort this table `Employee` by department, you would use `ORDER BY` Department. However, if you want a different
sort order that is not alphabetical, you have to map the Department values into different values that sort correctly;
this can be done with a CASE expression:

| Name    | Department  |
|---------|-------------|
| Hasan   | IT          |
| Yusuf   | HR          |
| Hillary | HR          |
| Joe     | IT          |
| Merry   | HR          |
| Ken     | Accountant  | 

```sql
SELECT *
FROM Employee
ORDER BY CASE Department
        WHEN 'HR'          THEN 1
        WHEN 'Accountant'  THEN 2
        ELSE                    3
END;
```
| Name    | Department | 
|---------|------------|
| Yusuf   | HR         |
| Hillary | HR         |
| Merry   | HR         |
| Ken     | Accountant |
| Hasan   | IT         |
| Joe     | IT         |

```sql
CREATE TABLE Employee(
	Name VARCHAR(100),
    Department VARCHAR(100)
);

INSERT INTO Employee (Name, Department) VALUES
('Hasan', 'IT'),
('Yusuf', 'HR'),
('Hillary', 'HR'),
('Joe', 'IT'),
('Merry', 'HR'),
('Ken', 'Accountant');

SELECT *
FROM Employee
ORDER BY CASE Department
        WHEN 'HR'          THEN 1
        WHEN 'Accountant'  THEN 2
        ELSE                    3
END;
+---------+------------+
| Name    | Department |
+---------+------------+
| Yusuf   | HR         |
| Hillary | HR         |
| Merry   | HR         |
| Ken     | Accountant |
| Hasan   | IT         |
| Joe     | IT         |
+---------+------------+
6 rows in set (0.01 sec)

-- With DESC
SELECT *
FROM Employee
ORDER BY CASE Department
        WHEN 'HR'          THEN 1
        WHEN 'Accountant'  THEN 2
        ELSE                    3
END DESC;
+---------+------------+
| Name    | Department |
+---------+------------+
| Hasan   | IT         |
| Joe     | IT         |
| Ken     | Accountant |
| Yusuf   | HR         |
| Hillary | HR         |
| Merry   | HR         |
+---------+------------+
6 rows in set (0.00 sec)

-- With ASC
SELECT *
FROM Employee
ORDER BY CASE Department
        WHEN 'HR'          THEN 1
        WHEN 'Accountant'  THEN 2
        ELSE                    3
END ASC;
+---------+------------+
| Name    | Department |
+---------+------------+
| Yusuf   | HR         |
| Hillary | HR         |
| Merry   | HR         |
| Ken     | Accountant |
| Hasan   | IT         |
| Joe     | IT         |
+---------+------------+
6 rows in set (0.00 sec)

```
## Order by Alias
Due to logical query processing order, alias can be used in `ORDER BY`.
```sql
SELECT DisplayName, JoinDate as jd, Reputation as rep
FROM Users
ORDER BY jd, rep;
+----------------+------------+--------+
| DisplayName    | jd         | rep    |
+----------------+------------+--------+
| Community      | 2008-09-15 |      1 |
| Joel Spolsky   | 2008-09-16 |  25784 |
| Jeff Atwood    | 2008-09-16 |  37628 |
| Jarrod Dixon   | 2008-10-03 |  11739 |
| Geoff Dalgas   | 2008-10-03 |  12567 |
| Jon Skeet      | 2008-10-19 | 865023 |
| Marc Gravell   | 2008-11-14 | 601636 |
| Hans Passant   | 2008-12-03 | 625870 |
| Darin Dimitrov | 2009-01-07 | 661741 |
| BalusC         | 2009-05-22 | 650237 |
+----------------+------------+--------+
10 rows in set (0.00 sec)
```
And can use relative order of the columns in the `SELECT` statement .Consider the same example as above and instead of 
using alias use the relative order like for display name it is 1 , for Jd it is 2 and so on
```sql
SELECT DisplayName, JoinDate as jd, Reputation as rep
FROM Users
ORDER BY 2, 3;
+----------------+------------+--------+
| DisplayName    | jd         | rep    |
+----------------+------------+--------+
| Community      | 2008-09-15 |      1 |
| Joel Spolsky   | 2008-09-16 |  25784 |
| Jeff Atwood    | 2008-09-16 |  37628 |
| Jarrod Dixon   | 2008-10-03 |  11739 |
| Geoff Dalgas   | 2008-10-03 |  12567 |
| Jon Skeet      | 2008-10-19 | 865023 |
| Marc Gravell   | 2008-11-14 | 601636 |
| Hans Passant   | 2008-12-03 | 625870 |
| Darin Dimitrov | 2009-01-07 | 661741 |
| BalusC         | 2009-05-22 | 650237 |
+----------------+------------+--------+
10 rows in set (0.00 sec)
```

## Sorting by multiple columns
```sql
SELECT DisplayName, JoinDate, Reputation 
    FROM Users 
    ORDER BY JoinDate, Reputation;
+----------------+------------+------------+
| DisplayName    | JoinDate   | Reputation |
+----------------+------------+------------+
| Community      | 2008-09-15 |          1 |
| Joel Spolsky   | 2008-09-16 |      25784 |
| Jeff Atwood    | 2008-09-16 |      37628 |
| Jarrod Dixon   | 2008-10-03 |      11739 |
| Geoff Dalgas   | 2008-10-03 |      12567 |
| Jon Skeet      | 2008-10-19 |     865023 |
| Marc Gravell   | 2008-11-14 |     601636 |
| Hans Passant   | 2008-12-03 |     625870 |
| Darin Dimitrov | 2009-01-07 |     661741 |
| BalusC         | 2009-05-22 |     650237 |
+----------------+------------+------------+
10 rows in set (0.00 sec)
```

| DisplayName  | JoinDate    | Reputation |
|--------------|-------------|------------|
| Community    | 2008-09-15  | 1          |
| Jeﬀ Atwood   | 2008-09-16  | 25784      |
| Joel Spolsky | 2008-09-16  | 37628      | 
| Jarrod Dixon | 2008-10-03  | 11739      |
| Geoﬀ Dalgas  | 2008-10-03  | 12567      |     


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)