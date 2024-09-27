use learning_sql;

-- Creating the Payments table
CREATE TABLE Payments (
    Customer VARCHAR(50),
    Payment_type VARCHAR(10),
    Amount INT
);

-- Inserting data into the Payments table
INSERT INTO Payments (Customer, Payment_type, Amount) VALUES
('Peter', 'Credit', 100),
('Peter', 'Credit', 300),
('John', 'Credit', 1000),
('John', 'Debit', 500);

SELECT 
    customer,
    SUM(CASE
        WHEN payment_type = 'Credit' THEN amount
        ELSE 0
    END) AS credit,
    SUM(CASE
        WHEN payment_type = 'Debit' THEN amount
        ELSE 0
    END) AS debit
FROM
    payments
GROUP BY customer;


-- Create the example table
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
    Customer VARCHAR(50),
    Product VARCHAR(50)
);

-- Insert sample data into the table
INSERT INTO Orders (Customer, Product) VALUES
('Alice', 'Apples'),
('Alice', 'Bananas'),
('Alice', 'Cherries'),
('Bob', 'Dates'),
('Bob', 'Elderberries'),
('Carol', 'Figs');

SELECT 
    Customer,
    GROUP_CONCAT(Product
        ORDER BY Product
        SEPARATOR ', ') AS Products
FROM
    Orders
GROUP BY Customer
ORDER BY Customer;
