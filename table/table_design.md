
## Properties of a Well-Designed Table

A true relational database must go beyond throwing data into a few tables and writing some SQL statements to pull that data out.
At best, a badly designed table structure will slow the execution of queries and could make it impossible for the database to function as intended.

A database table should not be considered just another table; it must follow a set of rules to be considered truly relational. Academically, it is referred to as a 'relation' to make the distinction.

### The Five Rules of a Relational Table:

1. **Each value is atomic**: The value in each field in each row must be a single value.
2. **Each field contains values of the same data type**: Ensures consistency within each column.
3. **Each field heading has a unique name**: Prevents ambiguity in data retrieval.
4. **Each row must have a unique value**: At least one value in the row must be unique to distinguish it from other records.
5. **The order of rows and columns has no significance**: The physical arrangement does not impact the data's meaning.

### Example of a Well-Designed Table:

```sql
-- Creating the Employees table
CREATE TABLE Employees (
    Id INT PRIMARY KEY,
    Name VARCHAR(50),
    DOB DATE,
    Manager INT
);

-- Inserting data into Employees table
INSERT INTO Employees (Id, Name, DOB, Manager) VALUES
(1, 'Fred', '1971-02-11', 3),
(2, 'Fred', '1971-02-11', 3),
(3, 'Sue', '1975-07-08', 2);
```

| Id  | Name  | DOB          | Manager |
|-----|-------|--------------|---------|
| 1   | Fred  | 1971-02-11   | 3       |
| 2   | Fred  | 1971-02-11   | 3       |
| 3   | Sue   | 1975-07-08   | 2       |

- **Rule 1**: Each value is atomic. Id, Name, DOB, and Manager only contain a single value.
- **Rule 2**: Fields contain consistent data types: Id (integers), Name (text), DOB (dates), and Manager (integers).
- **Rule 3**: Field names are unique within the table.
- **Rule 4**: The Id field ensures each record is distinct.

### Example of a Poorly Designed Table:

```sql
-- Creating a poorly designed table example
CREATE TABLE BadTable (
    Id INT,
    Name VARCHAR(50),
    DOB VARCHAR(50),
    Manager VARCHAR(50)
);

-- Inserting problematic data
INSERT INTO BadTable (Id, Name, DOB, Manager) VALUES
(1, 'Fred', '11/02/1971', '3'),
(1, 'Fred', '11/02/1971', '3'),
(3, 'Sue', 'Friday the 18th July 1975', '2, 1');
```

| Id | Name | DOB                        | Manager |
|----|------|----------------------------|---------|
| 1  | Fred | 11/02/1971                 | 3       |
| 1  | Fred | 11/02/1971                 | 3       |
| 3  | Sue  | Friday the 18th July 1975  | 2, 1    |

- **Rule 1 Violated**: Manager contains multiple values (2, 1).
- **Rule 2 Violated**: DOB contains inconsistent data types (dates and text).
- **Rule 3 Violated**: The table structure is ambiguous due to naming conflicts.
- **Rule 4 Violated**: Duplicate records exist.
- **Rule 5 Not Violated**: The order of rows and columns is inconsequential.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)