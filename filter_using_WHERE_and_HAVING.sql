SHOW DATABASES;
use learning_sql;

CREATE TABLE ItemSales (
    Id INT PRIMARY KEY,
    SaleDate DATE NOT NULL,
    ItemId INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10 , 2 ) NOT NULL
);

INSERT INTO ItemSales (Id, SaleDate, ItemId, Quantity, Price) VALUES
(1, '2013-07-11', 100, 20, 34.50),
(4, '2013-07-23', 100, 15, 34.50),
(5, '2013-07-24', 145, 10, 34.50),
(3, '2013-07-11', 100, 20, 34.50),
(6, '2013-05-24', 100, 20, 34.50),
(7, '2013-05-23', 100, 20, 34.50);

truncate table ItemSales;

SELECT 
    *
FROM
    ItemSales
WHERE
    SaleDate BETWEEN '2013-05-24' AND '2013-07-11';

SELECT 
    *
FROM
    ItemSales
WHERE
    SaleDate BETWEEN '2013-05-24' AND '2013-07-11';


CREATE TABLE Cars (
    Id INT PRIMARY KEY,
    CustomerId INT,
    Model VARCHAR(50),
    TotalCost INT
);

INSERT INTO Cars (Id, CustomerId, Model, TotalCost) VALUES
(1, 1, 'Toyota Camry', 200),     -- Customer #1, Car costs 200
(2, 1, 'Honda Accord', 100),     -- Customer #1, Car costs 100
(3, 2, 'Ford Focus', 300),       -- Customer #2, Car costs 300
(4, 3, 'Chevrolet Malibu', 150);-- Customer #3, Car costs 150

SELECT 
    CustomerId, COUNT(Id) AS `Number of Cars`
FROM
    Cars
GROUP BY CustomerId
HAVING COUNT(Id) > 1;


CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    PhoneNumber VARCHAR(15),
    ManagerId INT NULL,
    DepartmentId INT,
    Salary DECIMAL(10 , 2 ),
    Hire_Date DATE,
    CreatedDate DATE,
    ModifiedDate DATE NULL
);

INSERT INTO Employees (Id, FName, LName, PhoneNumber, ManagerId, DepartmentId, Salary, Hire_date, CreatedDate, ModifiedDate) VALUES
(1, 'James', 'Smith', '1234567890', NULL, 1, 1000, '2002-01-01', '2002-01-01', '2002-01-01'),
(2, 'John', 'Johnson', '2468101214', 1, 1, 400, '2005-03-23', '2005-03-23', '2002-01-01'),
(3, 'Michael', 'Williams', '1357911131', 1, 2, 600, '2009-05-12', '2009-05-12', NULL),
(4, 'Johnathon', 'Smith', '1212121212', 2, 1, 500, '2016-07-24', '2016-07-24', '2002-01-01');


SELECT 
    *
FROM
    Employees
WHERE
    ManagerId IS NOT NULL;
    
    
CREATE TABLE Orders (
    CustomerId INT,          -- ID of the customer who placed the order
    ProductId INT,           -- ID of the product ordered
    Quantity INT,            -- Quantity of the product ordered
    Price DECIMAL(10, 2)     -- Price of the product
);


INSERT INTO Orders (CustomerId, ProductId, Quantity, Price) VALUES
(1, 2, 5, 100),  -- Customer #1 ordered Product #2
(1, 3, 2, 200),  -- Customer #1 ordered Product #3
(1, 4, 1, 500),  -- Customer #1 ordered Product #4
(2, 1, 4, 50),   -- Customer #2 ordered Product #1
(3, 5, 6, 700);  -- Customer #3 ordered Product #5
    
SELECT 
    CustomerID
FROM
    Orders
WHERE
    ProductId IN (2 , 3)
GROUP BY CustomerId
HAVING COUNT(DISTINCT ProductId) = 2;


SELECT CustomerId
FROM Orders
GROUP BY CustomerId
HAVING SUM(CASE WHEN ProductId = 2 THEN 1 ELSE 0 END) > 0
   AND SUM(CASE WHEN ProductId = 3 THEN 1 ELSE 0 END) > 0;
   
   