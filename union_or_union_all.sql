use learning_sql;

CREATE TABLE HR_EMPLOYEES (
    PersonID INT,
    LastName VARCHAR(30),
    FirstName VARCHAR(30),
    Position VARCHAR(30)
);

CREATE TABLE FINANCE_EMPLOYEES (
    PersonID INT,
    LastName VARCHAR(30),
    FirstName VARCHAR(30),
    Position VARCHAR(30)
);

-- Inserting some data
-- Insert data into HR_EMPLOYEES
INSERT INTO HR_EMPLOYEES (PersonID, LastName, FirstName, Position) VALUES
(1, 'Smith', 'John', 'manager'),
(2, 'Doe', 'Jane', 'assistant'),
(3, 'White', 'Alice', 'manager'),
(4, 'Smith', 'John', 'manager');  -- Duplicate on purpose for testing UNION behavior

-- Insert data into FINANCE_EMPLOYEES
INSERT INTO FINANCE_EMPLOYEES (PersonID, LastName, FirstName, Position) VALUES
(5, 'Brown', 'Emily', 'manager'),
(6, 'Smith', 'John', 'manager'),  -- Duplicate manager entry
(7, 'Miller', 'Jake', 'accountant'),
(8, 'Smith', 'John', 'manager');-- Another duplicate


SELECT 
    FirstName, LastName
FROM
    HR_EMPLOYEES
WHERE
    Position = 'manager' 
UNION SELECT 
    FirstName, LastName
FROM
    FINANCE_EMPLOYEES
WHERE
    Position = 'manager';


SELECT 
    FirstName, LastName
FROM
    HR_EMPLOYEES
WHERE
    Position = 'manager' 
UNION ALL SELECT 
    FirstName, LastName
FROM
    FINANCE_EMPLOYEES
WHERE
    Position = 'manager';