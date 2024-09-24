use learning_sql;

-- Creating the Source table
CREATE TABLE Source (
    ID INT PRIMARY KEY,
    Data VARCHAR(50),
    Date DATE
);

-- Creating the Target table
CREATE TABLE Target (
    ID INT PRIMARY KEY,
    Data VARCHAR(50),
    Date DATE
);

-- Creating the Aggregate table
CREATE TABLE Aggregate (
    AggID INT PRIMARY KEY AUTO_INCREMENT,
    AggData VARCHAR(50),
    AggDate DATE
);

-- Insert data into Source table
INSERT INTO Source (ID, Data, Date) VALUES
(1, 'Source Data 1', '2024-09-20'),
(2, 'Source Data 2', '2024-09-21'),
(3, 'Source Data 3', '2024-09-22');

-- Insert data into Target table
INSERT INTO Target (ID, Data, Date) VALUES
(1, 'Target Data 1', '2024-09-20'),
(4, 'Target Data 4', '2024-09-21');

-- Insert data into Aggregate table
INSERT INTO Aggregate (AggData, AggDate) VALUES
('Aggregate Data 1', '2024-09-20'),
('Aggregate Data 2', '2024-09-21');


SELECT Source.*
FROM Source
JOIN Target ON Source.ID = Target.ID
JOIN Aggregate ON Target.Date = Aggregate.AggDate;

DELETE Source
FROM Source
JOIN Target ON Source.ID = Target.ID
JOIN Aggregate ON Target.Date = Aggregate.AggDate;