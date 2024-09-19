use learning_sql;

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


SELECT 
    *
FROM
    Products;
SELECT 
    *
FROM
    Customers;


SELECT 
    *
FROM
    Products
WHERE
    Id IN (1 , 8, 3);
    
    
SELECT 
    *
FROM
    Products
WHERE
    Id = 1 OR Id = 8 OR Id = 3;
    
SELECT 
    *
FROM
    Customers
WHERE
    Id IN (SELECT DISTINCT
            customer_id
        FROM
            orders);


SELECT 
    *
FROM
    Customers
WHERE
    Id IN (SELECT DISTINCT
            CustomerId
        FROM
            Orders);