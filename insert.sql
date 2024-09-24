use learning_sql;

DROP TABLE IF EXISTS Employees; 
DROP TABLE IF EXISTS Customers;

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    PhoneNumber VARCHAR(15)
);

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    PhoneNumber VARCHAR(15)
);


-- Insert sample data into Employees
INSERT INTO Employees (FName, LName, PhoneNumber) VALUES
('John', 'Doe', '123-456-7890'),
('Jane', 'Smith', '234-567-8901'),
('Alice', 'Johnson', '345-678-9012'),
('Bob', 'Brown', '456-789-0123'),
('John', 'Doe', '123-456-7890');-- Duplicate on purpose to test behavior

SELECT 
    *
FROM
    Employees;
SELECT 
    *
FROM
    Customers;

INSERT INTO Customers (FName, LName, PhoneNumber)
SELECT FName, LName, PhoneNumber FROM Employees;
