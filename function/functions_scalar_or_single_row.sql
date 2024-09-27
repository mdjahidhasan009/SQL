use learning_sql;

-- Creating the table in MySQL
DROP TABLE IF EXISTS SalesOrderHeader;
CREATE TABLE SalesOrderHeader (
    SalesOrderID INT PRIMARY KEY,
    OrderDate DATE,
    ShipDate DATE
);

-- Inserting data into the table
INSERT INTO SalesOrderHeader (SalesOrderID, OrderDate, ShipDate) VALUES
(43659, '2024-09-01', '2024-09-08'),
(43660, '2024-09-02', '2024-09-09'),
(43661, '2024-09-03', '2024-09-10'),
(43662, '2024-09-04', '2024-09-11');

-- Using DATEDIFF in MySQL
SELECT SalesOrderID, DATEDIFF(ShipDate, OrderDate) AS 'Processing time'
FROM SalesOrderHeader;