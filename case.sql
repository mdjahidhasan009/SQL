use learning_sql;

CREATE TABLE ItemSales (
    Id INT,
    ItemId INT,
    Price FLOAT,
    PriceRating VARCHAR(30)
);

-- Insert the data
INSERT INTO ItemSales (Id, ItemId, Price, PriceRating) VALUES
(1, 100, 34.5, 'EXPENSIVE'),
(2, 145, 2.3, 'CHEAP'),
(3, 100, 34.5, 'EXPENSIVE'),
(4, 100, 34.5, 'EXPENSIVE'),
(5, 145, 10, 'AFFORDABLE');


CREATE TABLE DEPT (
    ID INT,
    REGION VARCHAR(50),
    CITY VARCHAR(50),
    DEPARTMENT VARCHAR(50),
    EMPLOYEES_NUMBER INT
);

INSERT INTO DEPT (ID, REGION, CITY, DEPARTMENT, EMPLOYEES_NUMBER) VALUES
(12, 'New England', 'Boston', 'MARKETING', 9),
(15, 'West', 'San Francisco', 'MARKETING', 12),
(9, 'Midwest', 'Chicago', 'SALES', 8),
(14, 'Mid-Atlantic', 'New York', 'SALES', 12),
(5, 'West', 'Los Angeles', 'RESEARCH', 11),
(10, 'Mid-Atlantic', 'Philadelphia', 'RESEARCH', 13),
(4, 'Midwest', 'Chicago', 'INNOVATION', 11),
(2, 'Midwest', 'Detroit', 'HUMAN RESOURCES', 9);

SELECT 
    *
FROM
    DEPT
ORDER BY CASE DEPARTMENT
    WHEN 'MARKETING' THEN 1
    WHEN 'SALES' THEN 2
    WHEN 'RESEARCH' THEN 3
    WHEN 'INNOVATION' THEN 4
    ELSE 5
END , CITY;

-- delete all data of DEPT table to insert some row with `NULL` for future use
TRUNCATE TABLE DEPT;
SELECT * FROM DEPT;

-- Insert data into DEPT table
INSERT INTO DEPT (ID, REGION, CITY, DEPARTMENT, EMPLOYEES_NUMBER) VALUES
(10, 'Mid-Atlantic', 'Philadelphia', 'RESEARCH', 13),
(14, 'Mid-Atlantic', 'New York', 'SALES', 12),
(9, 'Midwest', 'Chicago', 'SALES', 8),
(12, 'New England', 'Boston', 'MARKETING', 9),
(5, 'West', 'Los Angeles', 'RESEARCH', 11),
(15, NULL, 'San Francisco', 'MARKETING', 12),
(4, NULL, 'Chicago', 'INNOVATION', 11),
(2, NULL, 'Detroit', 'HUMAN RESOURCES', 9);


SELECT 
    ID, REGION, CITY, DEPARTMENT, EMPLOYEES_NUMBER
FROM
    DEPT
ORDER BY CASE
    WHEN REGION IS NULL THEN 1
    ELSE 0
END , REGION;
