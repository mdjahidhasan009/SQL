## Creating a Primary Key
```sql
CREATE TABLE Employees (
    Id Int NOT NULL,
    PRIMARY KEY (Id),
    ...    
);
```
This will create the `Employees` table with `'Id'` as its primary key. The primary key can be used to uniquely identify 
the rows of a table. Only one primary key is allowed per table.

A key can also be composed by one or more fields, so-called composite key, with the following syntax:

```sql
CREATE TABLE EMPLOYEE (
    e1_id INT,
    e2_id INT,
    PRIMARY KEY (e1_id, e2_id)
);
```

## Using Auto Increment
Many databases allow to make the primary key value automatically increment when a new key is added. This ensures that
every key is different.

**MySQL**
```sql
CREATE TABLE Employees (
    Id int NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (Id)
);
```

**PostgreSQL**
```sql
CREATE TABLE Employees (
    Id SERIAL PRIMARY KEY
);
```

**SQL Server**
```sql
CREATE TABLE Employees (
    Id int NOT NULL IDENTITY,
    PRIMARY KEY (Id)
);
```

**SQLite**
```sql
CREATE TABLE Employees (
    Id INTEGER PRIMARY KEY
);
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)