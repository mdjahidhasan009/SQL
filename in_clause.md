<details>
<summary>SQL </summary>

```sql
CREATE TABLE Products (
    Id INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10 , 1 ) NOT NULL
);

INSERT INTO Products (Id, Name, Price) VALUES
(1, 'Product A', 10.00),
(3, 'Product B', 20.00),
(8, 'Product C', 15.50),
(2, 'Product D', 25.75),
(5, 'Product E', 5.99);

CREATE TABLE Customers (
    Id INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL
);

INSERT INTO Customers (Id, FirstName, LastName, Email) VALUES
(1, 'John', 'Doe', 'john.doe@example.com'),
(2, 'Jane', 'Smith', 'jane.smith@example.com'),
(3, 'Alice', 'Johnson', 'alice.johnson@example.com'),
(4, 'Bob', 'Brown', 'bob.brown@example.com'),
(5, 'Charlie', 'Davis', 'charlie.davis@example.com');


CREATE TABLE Orders (
    OrderId INT PRIMARY KEY,
    CustomerId INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (CustomerId)
        REFERENCES Customers (Id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

INSERT INTO Orders (OrderId, CustomerId, OrderDate, TotalAmount) VALUES
(1001, 1, '2023-01-15', 150.75),
(1002, 2, '2023-02-20', 200.50),
(1003, 1, '2023-03-05', 99.99),
(1004, 3, '2023-04-10', 250.00),
(1005, 4, '2023-05-22', 300.20);
```
</details>

## Simple IN clause
To get records having any of the given ids
```sql
mysql> SELECT 
    *
FROM
    Products
WHERE
    Id IN (1 , 8, 3);
+----+-----------+-------+
| Id | Name      | Price |
+----+-----------+-------+
|  1 | Product A |  10.0 |
|  3 | Product B |  20.0 |
|  8 | Product C |  15.5 |
+----+-----------+-------+
3 rows in set (0.00 sec)
```
The query above is equal to 
```sql
SELECT 
    *
FROM
    Products
WHERE
    Id = 1 OR Id = 8 OR Id = 3;
```

## Using IN clause with a subquery
```sql
mysql> SELECT DISTINCT CustomerId FROM Orders;
+------------+
| CustomerId |
+------------+
|          1 |
|          2 |
|          3 |
|          4 |
+------------+
4 rows in set (0.00 sec)
```

```sql
SELECT 
    *
FROM
    Customers
WHERE
    Id IN (SELECT DISTINCT
            CustomerId
        FROM
            Orders);
+----+-----------+----------+---------------------------+
| Id | FirstName | LastName | Email                     |
+----+-----------+----------+---------------------------+
|  1 | John      | Doe      | john.doe@example.com      |
|  2 | Jane      | Smith    | jane.smith@example.com    |
|  3 | Alice     | Johnson  | alice.johnson@example.com |
|  4 | Bob       | Brown    | bob.brown@example.com     |
+----+-----------+----------+---------------------------+
4 rows in set (0.00 sec)
```
The above will give you all the customers that have orders in the system.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)