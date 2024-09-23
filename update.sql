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

SELECT 
    c.PhoneNumber
FROM
    Customers c, Employees e
WHERE 
    c.FName = e.FName
    AND c.LName = e.LName;

             
             
             
             
             
             
