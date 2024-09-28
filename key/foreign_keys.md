
## Foreign Keys Explained

Foreign Key constraints ensure data integrity by enforcing that values in one table must match values in another table.

### Example Scenario
In a university, a course must belong to a department. Here is the code for this scenario:

```sql
-- Creating the Department table
CREATE TABLE Department (
    Dept_Code CHAR(5) PRIMARY KEY,
    Dept_Name VARCHAR(20) UNIQUE
);

-- Inserting values into the Department table
INSERT INTO Department VALUES ('CS205', 'Computer Science');
```

The following table will contain the information of the subjects offered by the Computer Science branch:

```sql
-- Creating the Programming_Courses table with a Foreign Key constraint
CREATE TABLE Programming_Courses (
    Dept_Code CHAR(5),
    Prg_Code CHAR(9) PRIMARY KEY,
    Prg_Name VARCHAR(50) UNIQUE,
    FOREIGN KEY (Dept_Code) REFERENCES Department(Dept_Code)
);
```

The Foreign Key constraint on the column `Dept_Code` allows values only if they already exist in the referenced table, `Department`.

If you try to insert the following values:

```sql
-- Attempt to insert invalid foreign key value
INSERT INTO Programming_Courses VALUES ('CS300', 'FDB-DB001', 'Database Systems');
```

The database will raise a Foreign Key violation error, because `CS300` does not exist in the Department table.

However, if you use a key value that exists:

```sql
-- Inserting valid foreign key values
INSERT INTO Programming_Courses VALUES ('CS205', 'FDB-DB001', 'Database Systems');
INSERT INTO Programming_Courses VALUES ('CS205', 'DB2-DB002', 'Database Systems II');
```

The database allows these values.

### Tips for Using Foreign Keys
- A Foreign Key must reference a UNIQUE (or PRIMARY) key in the parent table.
- Entering a NULL value in a Foreign Key column does not raise an error.
- Foreign Key constraints can reference tables within the same database.
- Foreign Key constraints can refer to another column in the same table (self-reference).

## Creating a Table with a Foreign Key
In this example, we have an existing table, `SuperHeros`. This table contains a primary key `ID`.

We will add a new table to store the powers of each superhero:

```sql
-- Creating the SuperHeros table (if not already created)
CREATE TABLE SuperHeros (
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

-- Inserting data into the SuperHeros table
INSERT INTO SuperHeros (ID, Name) VALUES (1, 'Superman'), (2, 'Batman');

-- Creating the HeroPowers table with a Foreign Key constraint
CREATE TABLE HeroPowers (
    ID INT NOT NULL PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    HeroId INT,
    FOREIGN KEY (HeroId) REFERENCES SuperHeros(ID)
);

-- Inserting data into the HeroPowers table
INSERT INTO HeroPowers (ID, Name, HeroId) VALUES (1, 'Flight', 1), (2, 'Strength', 1), (3, 'Detective Skills', 2);
```

### MySQL Considerations
MySQL supports Foreign Keys similarly. However, note that Foreign Keys work only with the `InnoDB` storage engine in MySQL.

Ensure that both tables are using `InnoDB`:

```sql
-- Ensure MySQL tables are using the InnoDB engine
CREATE TABLE Department (
    Dept_Code CHAR(5) PRIMARY KEY,
    Dept_Name VARCHAR(20) UNIQUE
) ENGINE=InnoDB;

CREATE TABLE Programming_Courses (
    Dept_Code CHAR(5),
    Prg_Code CHAR(9) PRIMARY KEY,
    Prg_Name VARCHAR(50) UNIQUE,
    FOREIGN KEY (Dept_Code) REFERENCES Department(Dept_Code)
) ENGINE=InnoDB;
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)