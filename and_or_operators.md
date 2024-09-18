## AND OR Example

<details>
<summary>Table Creation</summary>

```sql
use learning_sql;

CREATE TABLE Person (
    Name VARCHAR(25),
    Age INT,
    City VARCHAR(30)
);

INSERT INTO Person (Name, Age, City) VALUES
('Bob', 10, 'Paris'),
('Mat', 20, 'Berlin'),
('Mary', 24, 'Prague');

SELECT 
    Name
FROM
    Person
WHERE
    Age > 10 AND City = 'Prague';
    
    
SELECT
	Name
FROM 
	Person
WHERE
	Age = 10 OR City='Prague';
```
</details>

Have a table

| Name | Age | City   |
|------|-----|--------|
| Bob  | 10  | Paris  |
| Mat  | 20  | Berlin |
| Mary | 24  | Prague |

```sql
SELECT 
    Name
FROM
    Person
WHERE
    Age > 10 AND City = 'Prague';
```
Gives

| Name |
|------|
| Mary |


```sql
SELECT
	Name
FROM 
	Person
WHERE
	Age = 10 OR City='Prague';
```
Gives

| Name |
|------|
| Bob  |
| Mary |

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)