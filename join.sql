use learning_sql;

CREATE TABLE a (
    a INT
);

INSERT INTO a (a) VALUES (1), (2), (3), (4);

CREATE TABLE b (
    b INT
);

INSERT INTO b (b) VALUES (3), (4), (5), (6);

SELECT 
    *
FROM
    a
        INNER JOIN
    b ON a.a = b.b;
    
SELECT 
    a.*, b.*
FROM
    a,
    b
WHERE
    a.a = b.b;
    
SELECT 
    *
FROM
    a
        LEFT OUTER JOIN
    b ON a.a = b.b;
    
SELECT 
    *
FROM
    a
        RIGHT OUTER JOIN
    b ON a.a = b.b;
    
SELECT 
    *
FROM
    a
        LEFT JOIN
    b ON a.a = b.b 
UNION SELECT 
    *
FROM
    a
        RIGHT JOIN
    b ON a.a = b.b;
    

DROP TABLE a;
DROP TABLE b;

CREATE TABLE A (
    X VARCHAR(255) PRIMARY KEY
);

CREATE TABLE B (
    Y VARCHAR(255) PRIMARY KEY
);

INSERT INTO A VALUES
    ('Amy'),
    ('John'),
    ('Lisa'),
    ('Marco'),
    ('Phil')
;

INSERT INTO B VALUES
    ('Lisa'),
    ('Marco'),
    ('Phil'),
    ('Tim'),
    ('Vincent')
;

SELECT 
    *
FROM
    A
        JOIN
    B ON X = Y;
SELECT 
    *
FROM
    A
        LEFT JOIN
    B ON X = Y;
SELECT 
    *
FROM
    A
        RIGHT JOIN
    B ON X = Y;
-- Use LEFT JOIN to get all rows from A with matching rows from B
SELECT 
    A.X, B.Y
FROM
    A
        LEFT JOIN
    B ON A.X = B.Y 
UNION SELECT 
    A.X, B.Y
FROM
    A
        RIGHT JOIN
    B ON A.X = B.Y;

SELECT 
    *
FROM
    A
WHERE
    X IN (SELECT 
            Y
        FROM
            B);
SELECT 
    *
FROM
    B
WHERE
    Y IN (SELECT 
            X
        FROM
            A);

SELECT 
    *
FROM
    A
WHERE
    X NOT IN (SELECT 
            Y
        FROM
            B);
SELECT 
    *
FROM
    B
WHERE
    Y NOT IN (SELECT 
            X
        FROM
            A);

SELECT 
    *
FROM
    A
        CROSS JOIN
    B;
SELECT 
    *
FROM
    A
        JOIN
    B ON 1 = 1;

SELECT 
    *
FROM
    A A1
        JOIN
    A A2 ON LENGTH(A1.X) < LENGTH(A2.X);


CREATE TABLE Departments (
    Id INT PRIMARY KEY,
    Name VARCHAR(50)
);

INSERT INTO Departments (Id, Name) VALUES
(1, 'HR'),
(2, 'Sales'),
(3, 'Tech');

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
    Departments.Name, Employees.FName
FROM
    Departments
        LEFT OUTER JOIN
    Employees ON Departments.Id = Employees.DepartmentId;


SELECT 
    e.FName, d.Name
FROM
    Employees e,
    Departments d
WHERE
    e.DepartmentId = d.Id;
    
SELECT 
    d.Name, e.FName
FROM
    Departments d
        CROSS JOIN
    Employees e;    