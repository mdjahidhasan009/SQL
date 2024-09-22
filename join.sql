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
    



CREATE TABLE A (
    X varchar(255) PRIMARY KEY
);

CREATE TABLE B (
    Y varchar(255) PRIMARY KEY
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

SELECT * FROM A JOIN B ON X = Y;
SELECT * FROM A LEFT JOIN B ON X = Y;
SELECT * FROM A RIGHT JOIN B ON X = Y;
-- Use LEFT JOIN to get all rows from A with matching rows from B
SELECT A.X, B.Y 
FROM A 
LEFT JOIN B ON A.X = B.Y

UNION

-- Use RIGHT JOIN to get all rows from B with matching rows from A
SELECT A.X, B.Y 
FROM A 
RIGHT JOIN B ON A.X = B.Y;

SELECT * FROM A WHERE X IN (SELECT Y FROM B);
SELECT * FROM B WHERE Y IN (SELECT X FROM A);

SELECT * FROM A WHERE X NOT IN (SELECT Y FROM B);
SELECT * FROM B WHERE Y NOT IN (SELECT X FROM A);

SELECT * FROM A CROSS JOIN B;
SELECT * FROM A JOIN B ON 1 = 1;

SELECT * FROM A A1 JOIN A A2 ON LEN(A1.X) < LEN(A2.X);