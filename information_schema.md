
## Basic Information Schema Search

One of the most useful queries for end users of large RDBMS's is a search of an information schema.

Such a query allows users to rapidly find database tables containing columns of interest, such as when attempting
to relate data from 2 tables indirectly through a third table, without existing knowledge of which tables may contain
keys or other useful columns in common with the target tables.

Using T-SQL for this example, a database's information schema may be searched as follows:

```sql
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%Institution%'
```

The result contains a list of matching columns, their tables' names, and other useful information.

### Table Creation and Data Insertion

To demonstrate, let's create an example table and insert data into it:

```sql
-- Creating a sample table
CREATE TABLE Institutions (
    InstitutionID INT PRIMARY KEY,
    InstitutionName VARCHAR(255),
    Location VARCHAR(255)
);

-- Inserting sample data
INSERT INTO Institutions (InstitutionID, InstitutionName, Location) VALUES
(1, 'Tech University', 'New York'),
(2, 'Health Institute', 'California'),
(3, 'Arts College', 'Texas');
```

### MySQL Equivalent

The command to search information schema in MySQL is similar:

```sql
SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE COLUMN_NAME LIKE '%Institution%';
```

This will also return a list of matching columns, their tables' names, and other useful metadata.

### Usage Note

Searching the information schema is a powerful tool for database exploration, particularly when dealing with large, complex databases with many tables and relationships.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)