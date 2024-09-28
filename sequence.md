
## Create Sequence

### Creating a Sequence in SQL
The `CREATE SEQUENCE` statement creates a sequence object that generates a sequence of numeric values.
Sequences are often used to generate unique identifiers for rows in a table.

```sql
CREATE SEQUENCE orders_seq
START WITH 1000
INCREMENT BY 1;
```
This creates a sequence with a starting value of 1000, which is incremented by 1 each time it is used.

### Using Sequences

#### 1. Using NEXTVAL in INSERT Statements
You can use `NEXTVAL` to get the next value in a sequence. It is commonly used when inserting new rows into a table:

```sql
-- Example: Creating an Orders table
CREATE TABLE Orders (
    Order_UID INT PRIMARY KEY,
    Customer INT
);

-- Inserting data using the sequence
INSERT INTO Orders (Order_UID, Customer)
VALUES (orders_seq.NEXTVAL, 1032);
```

#### 2. Using NEXTVAL in UPDATE Statements
You can also use sequences in UPDATE statements to update existing rows:

```sql
UPDATE Orders
SET Order_UID = orders_seq.NEXTVAL
WHERE Customer = 581;
```

#### 3. Using NEXTVAL in SELECT Statements
You can generate the next sequence number directly using a SELECT statement, though this is less common in production use:

```sql
SELECT orders_seq.NEXTVAL FROM dual;
```

### MySQL Equivalent
MySQL does not support the `CREATE SEQUENCE` syntax directly. Instead, you can achieve similar functionality using `AUTO_INCREMENT` or defining a table with an auto-incrementing column.

#### Creating an Auto-Incrementing Column in MySQL
```sql
-- MySQL version of Orders table with auto-increment
CREATE TABLE Orders (
    Order_UID INT AUTO_INCREMENT PRIMARY KEY,
    Customer INT
);

-- Inserting data (Order_UID will auto-increment)
INSERT INTO Orders (Customer) VALUES (1032);
```

### Key Points
- A sequence generates unique numbers, often used as surrogate keys.
- Sequences can be incremented by a specific value and can start from a specified number.
- `NEXTVAL` can be used in various SQL statements like INSERT, UPDATE, and SELECT.
- MySQL uses `AUTO_INCREMENT` instead of sequences.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)