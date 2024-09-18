# GROUP BY
Results of a `SELECT` query can be **grouped by one or more columns** using the `GROUP BY` statement: all results with
the same value in the grouped columns are aggregated together. This generates a table of partial results, instead of
one result. `GROUP BY` can be used in conjunction with aggregation functions using the `HAVING` statement to define
how non-grouped columns are aggregated.

## Basic GROUP BY example
It might be easier if you think of GROUP BY as "for each" for the sake of explanation. The query below:
```sql
SELECT EmpID, SUM(MonthlySalary)
  FROM Employee
GROUP BY EmpID
```
is saying:<br/>
"Give me the sum of MonthlySalary's for each EmpID"

So if your table looked like this:<br/>


| EmpID | MonthlySalary |
|-------|---------------|
| 1     | 200           |
| 2     | 300           |

Result:
```sql
use learning_sql;

CREATE TABLE Employee (
    Id INT NOT NULL AUTO_INCREMENT,
    MounthlySalary INT NOT NULL,
    PRIMARY KEY (Id)
);

ALTER TABLE Employee
RENAME COLUMN Id TO EmpID;

INSERT INTO Employee
(EmpID, MounthlySalary)
VALUES
(1,200),
(2,300);

-- As only value two value so it will just retrun those.
SELECT EmpID, SUM(MounthlySalary)
FROM Employee
GROUP BY EmpId;
```
|   |     |
|---|-----|
| 1 | 200 |
| 2 | 300 |

Sum wouldn't appear to do anything because the sum of one number is that number. On the other hand if it looked like 
this:

| EmpID | MonthlySalary |
|-------|---------------|
| 1     | 200           |
| 1     | 300           |
| 2     | 300           |

Result:
```sql
-- Frist we need to remove AUTO_INCREMENT
ALTER TABLE Employee
MODIFY EmpID INT NOT NULL;

-- Then remove primary key constraint as we need same employee id in this table
ALTER TABLE Employee
DROP PRIMARY KEY;

INSERT INTO Employee 
(EmpID, MounthlySalary)
VALUES
(1,300);

SELECT EmpId, SUM(MounthlySalary)
FROM Employee
GROUP BY EmpId;
```
|   |     |
|---|-----|
| 1 | 500 |
| 2 | 300 |

Then it would because there are two EmpID 1's to sum together.

## Filter GROUP BY results using a HAVING clause
A `HAVING` clause filters the results of a `GROUP BY` expression. Note: The following examples are using the Library
example database.
  
<details>

<summary>Create and insert data into the tables</summary>

```sql
-- Create the Authors table
CREATE TABLE Authors (
	Id INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    PRIMARY KEY(Id)
);

-- Create the Books table
CREATE TABLE Books(
	Id INT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(200) NOT NULL,
    PRIMARY KEY(Id)
);

-- Create the table BooksAuthors 
CREATE TABLE BooksAuthors(
	BookId INT NOT NULL,
    AuthorId INT NOT NULL,
    PRIMARY KEY (BookId, AuthorId),
    FOREIGN KEY (BookId) REFERENCES Books(Id),
    FOREIGN KEY (AuthorId) REFERENCES Authors(Id)
);

-- Inserting Sample Data
INSERT INTO Authors (Name) VALUES
('Author A'),
('Author B'),
('Author C'),
('Author D'),
('Author E'),
('Author F'),
('Author G'),
('Author H'),
('Author I'),
('Author J');

INSERT INTO Books (Title) VALUES
('Book 1'),
('Book 2'),
('Book 3'),
('Book 4'),
('Book 5'),
('Book 6'),
('Book 7'),
('Book 8'),
('Book 9'),
('Book 10');

INSERT INTO BooksAuthors (BookId, AuthorId) VALUES
-- Book 1 has 5 authors
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
-- Book 2 has 2 authors
(2, 1),
(2, 2),
-- Book 3 has 2 authors
(3, 2),
(3, 3),
-- Book 4 has 2 authors
(4, 3),
(4, 4),
-- Book 5 has 4 authors
(5, 2),
(5, 3),
(5, 4),
(5, 5),
-- Book 6 has 4 authors
(6, 2),
(6, 3),
(6, 5),
(6, 6),
-- Book 7 has 2 authors
(7, 6),
(7, 7),
-- Book 8 has 2 authors
(8, 7),
(8, 8),
-- Book 9 has 2 authors
(9, 8),
(9, 9),
-- Book 10 has 2 authors
(10, 9),
(10, 10);
```
</details>

Examples:
#### Return all authors that wrote more than one book.
```sql
SELECT 
    a.Id,
    a.Name
    COUNT(*) BooksWritten
FROM BooksAuthors ba
    INNER JOIN Books b ON b.id = ba.bookid
GROUP BY 
    a.Id,
    a.Name
HAVING COUNT(*) > 1 -- equals to HAVING BooksWritten > 1
```
Output
```shell
+----+----------+--------------+
| Id | Name     | BooksWritten |
+----+----------+--------------+
|  1 | Author A |            2 |
|  2 | Author B |            5 |
|  3 | Author C |            5 |
|  4 | Author D |            3 |
|  5 | Author E |            3 |
|  6 | Author F |            2 |
|  7 | Author G |            2 |
|  8 | Author H |            2 |
|  9 | Author I |            2 |
+----+----------+--------------+
9 rows in set (0.00 sec)
```

<details>
<summary>If we group by only author id then will get the same result</summary>

```sql
mysql> SELECT 
    ->     a.Id,
    ->     a.Name,
    ->     COUNT(*) AS BooksWritten
    -> FROM BooksAuthors ba
    ->     INNER JOIN Authors a ON a.Id = ba.AuthorId
    -> GROUP BY 
    ->     a.Id
    ->     -- a.Name
    -> HAVING COUNT(*) > 1;
+----+----------+--------------+
| Id | Name     | BooksWritten |
+----+----------+--------------+
|  1 | Author A |            2 |
|  2 | Author B |            5 |
|  3 | Author C |            5 |
|  4 | Author D |            3 |
|  5 | Author E |            3 |
|  6 | Author F |            2 |
|  7 | Author G |            2 |
|  8 | Author H |            2 |
|  9 | Author I |            2 |
+----+----------+--------------+
9 rows in set (0.00 sec)
```
</details>

Return all books that have more than three authors


## USE GROUP BY to COUNT the number of rows for each unique entry in a given column
Let's say you want to generate counts or subtotals for a given value in a column.

<details>
<summary>SQL of creating and insertion data on table Westerosians</summary>

```sql
CREATE TABLE Westerosians (
    Name VARCHAR(100),
    GreatHouseAllegience VARCHAR(100)
);

INSERT INTO Westerosians (Name, GreatHouseAllegience) VALUES
('Arya', 'Stark'),
('Cercei', 'Lannister'),
('Myrcella', 'Lannister'),
('Yara', 'Greyjoy'),
('Catelyn', 'Stark'),
('Sansa', 'Stark');
```
</details>

Given this table, "Westerosians":

| Name     | GreatHouseAllegience |
|----------|----------------------|
| Arya     | Stark                | 
| Cercei   | Lannister            |
| Myrcella | Lannister            |
| Yara     | Greyjoy              |
| Catelyn  | Stark                |
| Sansa    | Stark                |

Without `GROUP BY`, `COUNT` will simply return a total number of rows:
```sql
SELECT 
    COUNT(*) Number_of_Westerosians
FROM
    Westerosians;
```
returns...

| Number_of_Westerosians |
|------------------------|
| 6                      |

But by adding `GROUP BY`, we can `COUNT` the users for each value in a given column, to return the number of
people in a given Great House, say:
```sql
SELECT 
    GreatHouseAllegience House
FROM
    Westerosians
GROUP BY GreatHouseAllegience;
+-----------+
| House     |
+-----------+
| Stark     |
| Lannister |
| Greyjoy   |
+-----------+
3 rows in set (0.00 sec)
```
Now, we can use `COUNT` to return the number of people in each house:
```sql
SELECT 
    GreatHouseAllegience House, COUNT(*) Number_of_Westerosians
FROM
    Westerosians
GROUP BY GreatHouseAllegience;
```
returns...

| House     | Number_of_Westerosians |
|-----------|------------------------|
| Stark     | 3                      |
| Greyjoy   | 1                      |
| Lannister | 2                      |

It's common to combine GROUP BY with `ORDER BY` to sort results by largest or smallest category:

```sql
SELECT 
    GreatHouseAllegience House, COUNT(*) Number_of_Westerosians
FROM
    Westerosians
GROUP BY GreatHouseAllegience
ORDER BY Number_of_Westerosians DESC;
```
returns...

| House     | Number_of_Westerosians |
|-----------|------------------------|
| Stark     | 3                      |
| Lannister | 2                      |
| Greyjoy   | 1                      |


## ROLAP aggregation (Data Mining)
The SQL standard provides two additional aggregate operators. These use the polymorphic value "ALL" to denote the set of
all values that an attribute can take. The two operators are:
* `with data cube` that it provides all possible combinations than the argument attributes of the clause.
* `with` roll up that it provides the aggregates obtained by considering the attributes in order from left to
  right compared how they are listed in the argument of the clause.

SQL standard versions that support these features: 1999,2003,2006,2008,2011.

| Food  | Brand  | Total_amount |
|-------|--------|--------------|
| Pasta | Brand1 | 100          |
| Pasta | Brand2 | 250          |  
| Pizza | Brand2 | 300          | 


**With cube**
```sql
select Food,Brand,Total_amount
from Table
group by Food,Brand,Total_amount with cube
```

| Food  | Brand  | Total_amount |
|-------|--------|--------------| 
| Pasta | Brand1 | 100          |
| Pasta | Brand2 | 250          | 
| Pasta | ALL    | 350          | 
| Pizza | Brand2 | 300          | 
| Pizza | ALL    | 300          | 
| ALL   | Brand1 | 100          |
| ALL   | Brand2 | 550          | 
| ALL   | ALL    | 650          | 

**With roll up**
```sql
select Food,Brand,Total_amount
from Table
group by Food,Brand,Total_amount with roll up
```

| Food  | Brand  | Total_amount |
|-------|--------|--------------|
| Pasta | Brand1 | 100          | 
| Pasta | Brand2 | 250          | 
| Pizza | Brand2 | 300          |
| Pasta | ALL    | 350          | 
| Pizza | ALL    | 300          | 
| ALL   | ALL    | 650          | 

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)