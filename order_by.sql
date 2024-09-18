CREATE DATABASE learning_sql;
use learning_sql;

CREATE TABLE Users (
    DisplayName VARCHAR(100) NOT NULL,
    JoinData DATE NOT NULL,
    Reputation INT NOT NULL
);

ALTER TABLE Users
RENAME COLUMN JoinData TO JoinDate;

INSERT INTO Users (DisplayName, JoinDate, Reputation) VALUES
('Community', '2008-09-15', 1),
('Jarrod Dixon', '2008-10-03', 11739),
('Geoff Dalgas', '2008-10-03', 12567),
('Joel Spolsky', '2008-09-16', 25784),
('Jeff Atwood', '2008-09-16', 37628);

SELECT * FROM Users;
SELECT DisplayName, JoinDate, Reputation FROM Users ORDER BY 3;

INSERT INTO Users (DisplayName, JoinDate, Reputation) VALUES
('Jon Skeet', '2008-10-19', 865023),
('Darin Dimitrov', '2009-01-07', 661741),
('BalusC', '2009-05-22', 650237),
('Hans Passant', '2008-12-03', 625870),
('Marc Gravell', '2008-11-14', 601636);

SELECT DisplayName, Reputation
FROM Users LIMIT 5;



CREATE TABLE Employee(
	Name VARCHAR(100),
    Department VARCHAR(100)
);

INSERT INTO Employee (Name, Department) VALUES
('Hasan', 'IT'),
('Yusuf', 'HR'),
('Hillary', 'HR'),
('Joe', 'IT'),
('Merry', 'HR'),
('Ken', 'Accountant');

SELECT *
FROM Employee
ORDER BY CASE Department
        WHEN 'HR'          THEN 1
        WHEN 'Accountant'  THEN 2
        ELSE                    3
END;