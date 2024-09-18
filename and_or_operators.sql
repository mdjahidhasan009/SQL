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