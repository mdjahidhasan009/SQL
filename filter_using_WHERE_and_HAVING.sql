use learning_sql;

CREATE TABLE ItemSales(
    Id INT PRIMARY KEY,
    SaleDate DATE NOT NULL,
    ItemId INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

INSERT INTO ItemSales (Id, SaleDate, ItemId, Quantity, Price) VALUES
(3, '2013-07-11', 100, 20, 34.50),
(4, '2013-07-23', 100, 15, 34.50),
(5, '2013-07-24', 145, 10, 34.50);

SELECT * From ItemSales
WHERE SaleDate BETWEEN '2013-05-24' AND '2013-07-11';