use learning_sql;

CREATE TABLE Employee (
    Id INT NOT NULL AUTO_INCREMENT,
    MounthlySalary INT NOT NULL,
    PRIMARY KEY (Id)
);

ALTER TABLE Employee
RENAME COLUMN Id TO EmpID;

INSERT INTO Employee
(EmpID, MounthlySalary)
VALUES
(1,200),
(2,300);

-- As only value two value so it will just retrun those.
SELECT 
    EmpID, SUM(MounthlySalary)
FROM
    Employee
GROUP BY EmpId;

-- Frist we need to remove AUTO_INCREMENT
ALTER TABLE Employee
MODIFY EmpID INT NOT NULL;

-- Then remove primary key constraint as we need same employee id in this table
ALTER TABLE Employee
DROP PRIMARY KEY;

INSERT INTO Employee 
(EmpID, MounthlySalary)
VALUES
(1,300);

SELECT 
    EmpId, SUM(MounthlySalary)
FROM
    Employee
GROUP BY EmpId;








-- Create the Authors table
CREATE TABLE Authors (
    Id INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    PRIMARY KEY (Id)
);

-- Create the Books table
CREATE TABLE Books (
    Id INT NOT NULL AUTO_INCREMENT,
    Title VARCHAR(200) NOT NULL,
    PRIMARY KEY (Id)
);

-- Create the table BooksAuthors 
CREATE TABLE BooksAuthors (
    BookId INT NOT NULL,
    AuthorId INT NOT NULL,
    PRIMARY KEY (BookId , AuthorId),
    FOREIGN KEY (BookId)
        REFERENCES Books (Id),
    FOREIGN KEY (AuthorId)
        REFERENCES Authors (Id)
);

-- Inserting Sample Data
INSERT INTO Authors (Name) VALUES
('Author A'),
('Author B'),
('Author C'),
('Author D'),
('Author E'),
('Author F'),
('Author G'),
('Author H'),
('Author I'),
('Author J');

INSERT INTO Books (Title) VALUES
('Book 1'),
('Book 2'),
('Book 3'),
('Book 4'),
('Book 5'),
('Book 6'),
('Book 7'),
('Book 8'),
('Book 9'),
('Book 10');

INSERT INTO BooksAuthors (BookId, AuthorId) VALUES
-- Book 1 has 5 authors
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
-- Book 2 has 2 authors
(2, 1),
(2, 2),
-- Book 3 has 2 authors
(3, 2),
(3, 3),
-- Book 4 has 2 authors
(4, 3),
(4, 4),
-- Book 5 has 4 authors
(5, 2),
(5, 3),
(5, 4),
(5, 5),
-- Book 6 has 4 authors
(6, 2),
(6, 3),
(6, 5),
(6, 6),
-- Book 7 has 2 authors
(7, 6),
(7, 7),
-- Book 8 has 2 authors
(8, 7),
(8, 8),
-- Book 9 has 2 authors
(9, 8),
(9, 9),
-- Book 10 has 2 authors
(10, 9),
(10, 10);


SELECT 
    a.Id, a.Name, COUNT(*) AS BooksWritten
FROM
    BooksAuthors ba
        INNER JOIN
    Authors a ON a.Id = ba.AuthorId
GROUP BY a.Id
HAVING COUNT(*) > 1;







CREATE TABLE Westerosians (
    Name VARCHAR(100),
    GreatHouseAllegience VARCHAR(100)
);

INSERT INTO Westerosians (Name, GreatHouseAllegience) VALUES
('Arya', 'Stark'),
('Cercei', 'Lannister'),
('Myrcella', 'Lannister'),
('Yara', 'Greyjoy'),
('Catelyn', 'Stark'),
('Sansa', 'Stark');

SELECT 
    COUNT(*) Number_of_Westerosians
FROM
    Westerosians;
    
SELECT 
    GreatHouseAllegience House, COUNT(*) Number_of_Westerosians
FROM
    Westerosians
GROUP BY GreatHouseAllegience;


SELECT 
    GreatHouseAllegience House, COUNT(*) Number_of_Westerosians
FROM
    Westerosians
GROUP BY GreatHouseAllegience
ORDER BY Number_of_Westerosians DESC;

