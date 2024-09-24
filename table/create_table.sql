use learning_sql;

DROP TABLE Employees;
DROP TABLE ClonedEmployees;
DROP TABLE ModifiedEmployees;

CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    FName VARCHAR(50),
    LName VARCHAR(50),
    PhoneNumber VARCHAR(15),
    ManagerId INT NULL,
    DepartmentId INT,
    Salary DECIMAL(10 , 2 ),
    HireDate DATE
);

INSERT INTO Employees (Id, FName, LName, PhoneNumber, ManagerId, DepartmentId, Salary, HireDate) VALUES
(1, 'James', 'Smith', '1234567890', NULL, 1, 1000, '2002-01-01'),
(2, 'John', 'Johnson', '2468101214', 1, 1, 400, '2005-03-23'),
(3, 'Michael', 'Williams', '1357911131', 1, 2, 600, '2009-05-12'),
(4, 'Johnathon', 'Smith', '1212121212', 2, 1, 500, '2016-07-24');

SELECT 
    *
FROM
    Employees;




CREATE TABLE ClonedEmployees AS SELECT * FROM
    Employees;

SELECT 
    *
FROM
    ClonedEmployees;
    

CREATE TABLE ModifiedEmployees AS SELECT Id, CONCAT(FName, ' ', LName) AS FullName FROM
    Employees
WHERE
    Id > 2;

SELECT 
    *
FROM
    ModifiedEmployees;










