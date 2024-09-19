use learning_sql;

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

INSERT INTO Employees (Id, FName, LName, PhoneNumber, ManagerId, DepartmentId, Salary, Hire_date) VALUES
(6, 'gary', 'Johnson', '2468101214', 3, 1, 400.00, '2005-03-23'),
(7, 'mary', 'Johnson', '2468101214', 2, 1, 400.00, '2005-03-23');