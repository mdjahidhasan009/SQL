# Auto Shop Database
In the following example - Database for an auto shop business, we have a list of departments, employees,
customers and customer cars. We are using foreign keys to create relationships between the various tables.

Relationships between tables
* Each Department may have 0 or more Employees
* Each Employee may have 0 or 1 Manager
* Each Customer may have 0 or more Cars

**Departments**

| Id | Name  |
|----|-------|
| 1  | HR    |
| 2  | Sales |
| 3  | Tech  |

SQL statements to create the table:
**SQL Server**

MS SQL Server does not support the `AUTO_INCREMENT` keyword. Instead, we use the `IDENTITY` keyword to auto-increment
the `Id` column. The `IDENTITY(1,1)` means that the `Id` column will start at 1 and increment by 1 for each new record.
In SQL Server, when a column is defined with `IDENTITY`, you cannot manually insert values into the `Id` column unless you 
use `SET IDENTITY_INSERT ON`. But in MySQL, you can insert values into the `Id` column even if it is defined with 
`AUTO_INCREMENT`.

```sql
CREATE TABLE Departments(
    Id INT NOT NULL IDENTITY(1,1),
    Name VARCHAR(25) NOT NULL,
    PRIMARY KEY(Id)
);

INSERT INTO Departments (Name)
VALUES
    ('HR'),
    ('Sales'),
    ('Tech');
```


**MySQL**

MySQL does allow manually inserting values into an `AUTO_INCREMENT` column, so we can specify or skip values for the `Id`
column.

```sql
CREATE TABLE Departments(
    Id INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(25) NOT NULL,
    PRIMARY KEY(Id)
);

INSERT INTO Departments 
    (Id, Name)
VALUES
    (1, 'HR'),
    (2, 'Sales'),
    (3, 'Tech')
;
```

**Employees**

| Id | FName     | LName    | PhoneNumber | ManagerId | DepartmentId | Salary | HireDate   | 
|----|-----------|----------|-------------|-----------|--------------|--------|------------|
| 1  | James     | Smith    | 1234567890  | NULL      | 1            | 1000   | 01-01-2002 |
| 2  | John      | Johnson  | 2468101214  | 1         | 1            | 400    | 23-03-2005 |
| 3  | Michael   | Williams | 1357911131  | 1         | 2            | 600    | 12-05-2009 |
| 4  | Johnathon | Smith    | 1212121212  | 2         | 1            | 500    | 24-07-2016 |

SQL statements to create the table:
**SQL Server**
```sql
CREATE TABLE Employee (
 Id INT NOT NULL IDENTITY(1,1), -- IDENTITY(1,1) means start at 1 and increment by 1 for each new record as it SQL Server
    FName VARCHAR(35) NOT NULL,
    LName VARCHAR(35) NOT NULL,
    PhoneNumber VARCHAR(11),
    ManagerId INT,
    DepartmentId INT NOT NULL,
    Salary INT NOT NULL,
    HireDate DATETIME NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY (ManagerId) REFERENCES Employee(Id),
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);

INSERT INTO Employee 
    (FName, LName, PhoneNumber, ManagerId, DepartmentId, Salary, HireDate)
VALUES
    ('James', 'Smith', '1234567890', NULL, 1, 1000, '2002-01-01'),
    ('John', 'Johnson', '2468101214', 1, 1, 400, '2005-03-23'),
    ('Michael', 'Williams', '1357911131', 1, 2, 600, '2009-05-12'),
    ('Johnathon', 'Smith', '1212121212', 2, 1, 500, '2016-07-24');
```

**MySQL**
```sql
CREATE TABLE Employee (
    Id INT NOT NULL AUTO_INCREMENT, -- AUTO_INCREMENT instead of IDENTITY
    FName VARCHAR(35) NOT NULL,
    LName VARCHAR(35) NOT NULL,
    PhoneNumber VARCHAR(11),
    ManagerId INT,
    DepartmentId INT NOT NULL,
    Salary INT NOT NULL,
    HireDate DATETIME NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY (ManagerId) REFERENCES Employee(Id),
    FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
);


INSERT INTO Employee 
    (FName, LName, PhoneNumber, ManagerId, DepartmentId, Salary, HireDate)
VALUES
    ('James', 'Smith', '1234567890', NULL, 1, 1000, '2002-01-01'),
    ('John', 'Johnson', '2468101214', 1, 1, 400, '2005-03-23'),
    ('Michael', 'Williams', '1357911131', 1, 2, 600, '2009-05-12'),
    ('Johnathon', 'Smith', '1212121212', 2, 1, 500, '2016-07-24');
```
**Customers**

| Id | FName    | LName   | Email                     | PhoneNumber | PreferredContact |
|----|----------|---------|---------------------------|-------------|------------------|
| 1  | William  | Jones   | william.jones@example.com | 3347927472  | PHONE            |
| 2  | David    | Miller  | dmiller@example.net       | 2137921892  | EMAIL            |
| 3  | Richard  | Davis   | richard0123@example.com   | NULL        | EMAIL            |


SQL statements to create the table:
**SQL Server**
```sql
CREATE TABLE Customers (
    Id INT NOT NULL IDENTITY(1,1),
    FName VARCHAR(35) NOT NULL,
    LName VARCHAR(35) NOT NULL,  
    Email VARCHAR(100) NOT NULL,  
    PhoneNumber VARCHAR(11),
    PreferredContact VARCHAR(5) NOT NULL,
    PRIMARY KEY(Id)
);

-- Insert data into the Customers table
INSERT INTO Customers 
    (FName, LName, Email, PhoneNumber, PreferredContact)
VALUES 
    ('William', 'Jones', 'william.jones@example.com', '3347927472', 'PHONE'),
    ('David', 'Miller', 'dmiller@example.net', '2137921892', 'EMAIL'),
    ('Richard', 'Davis', 'richard0123@example.com', NULL, 'EMAIL');
```

**MySQL**
```sql
CREATE TABLE Customers (
    Id INT NOT NULL AUTO_INCREMENT,  -- AUTO_INCREMENT for MySQL
    FName VARCHAR(35) NOT NULL,
    LName VARCHAR(35) NOT NULL, 
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(11),
    PreferredContact VARCHAR(5) NOT NULL,
    PRIMARY KEY(Id)
);

-- Insert data into the Customers table
INSERT INTO Customers 
    (FName, LName, Email, PhoneNumber, PreferredContact)
VALUES 
    ('William', 'Jones', 'william.jones@example.com', '3347927472', 'PHONE'),
    ('David', 'Miller', 'dmiller@example.net', '2137921892', 'EMAIL'),
    ('Richard', 'Davis', 'richard0123@example.com', NULL, 'EMAIL');
```

**Cars**

| Id | CustomerId | EmployeeId | Model        | Status  | Cost  |
|----|------------|------------|--------------|---------|-------|
| 1  | 1          | 2          | Ford F-150   | READY   | 230   |
| 2  | 1          | 2          | Ford F-150   | READY   | 200   |
| 3  | 2          | 1          | Ford Mustang | WAITING | 100   |
| 4  | 3          | 3          | Toyota Prius | WORKING | 1254  |

**SQL Server**
```sql
CREATE TABLE Cars (
    Id INT NOT NULL IDENTITY(1,1),  -- IDENTITY instead of AUTO_INCREMENT
    CustomerId INT NOT NULL,
    EmployeeId INT NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Status VARCHAR(25) NOT NULL,
    TotalCost INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY(CustomerId) REFERENCES Customers(Id), -- Fixed typo
    FOREIGN KEY(EmployeeId) REFERENCES Employee(Id)  -- Fixed typo
);

-- Insert data into the Cars table
INSERT INTO Cars 
    (CustomerId, EmployeeId, Model, Status, TotalCost)
VALUES
    (1, 2, 'Ford F-150', 'READY', 230),
    (1, 2, 'Ford F-150', 'READY', 200),
    (2, 1, 'Ford Mustang', 'WAITING', 100),
    (3, 3, 'Toyota Prius', 'WORKING', 1254);
```

**MySQL**
```sql
CREATE TABLE Cars (
    Id INT NOT NULL AUTO_INCREMENT,  -- AUTO_INCREMENT for MySQL
    CustomerId INT NOT NULL,
    EmployeeId INT NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Status VARCHAR(25) NOT NULL,
    TotalCost INT NOT NULL,
    PRIMARY KEY(Id),
    FOREIGN KEY(CustomerId) REFERENCES Customers(Id),  -- Fixed typo
    FOREIGN KEY(EmployeeId) REFERENCES Employee(Id)   -- Fixed typo
);

INSERT INTO Cars 
    (CustomerId, EmployeeId, Model, Status, TotalCost)  -- Removed Id since it's AUTO_INCREMENT
VALUES
    (1, 2, 'Ford F-150', 'READY', 230),
    (1, 2, 'Ford F-150', 'READY', 200),
    (2, 1, 'Ford Mustang', 'WAITING', 100),
    (3, 3, 'Toyota Prius', 'WORKING', 1254);
```

# Library Database
In this example database for a library, we have Authors, Books and BooksAuthors tables.

Authors and Books are known as **base tables**, since they contain column definition and data for the actual entities in
the relational model. BooksAuthors is known as the **relationship table**, since this table defines the relationship
between the Books and Authors table.

Relationships between tables
* Each author can have 1 or more books
* Each book can have 1 or more authors

**Authors**

| Id | Name                  | Country |
|----|-----------------------|---------|
| 1  | J.D. Salinger         | USA     |
| 2  | F. Scott. Fitzgerald  | USA     |
| 3  | Jane Austen           | UK      |
| 4  | Scott Hanselman       | USA     |
| 5  | Jason N. Gaylord      | USA     |
| 6  | Pranav Rastogi        | India   |
| 7  | Todd Miranda          | USA     |
| 8  | Christian Wenz        | USA     |

**MySQL**
SQL to create the table:
```sql
CREATE TABLE Authors (
    Id INT NOT NULL AUTO_INCREMENT,
    Name varchar(70) NOT NULL,
    Country varchar(100) NOT NULL,
    PRIMARY KEY(Id)
);

INSERT INTO Authors
    (Name, Country)
VALUES 
    ('J.D. Salinger', 'USA'),
    ('F. Scott. Fitzgerald', 'USA'),
    ('Jane Austen', 'UK'),
    ('Scott Hanselman', 'USA'),
    ('Jason N. Gaylord', 'USA'),
    ('Pranav Rastogi', 'India'),
    ('Todd Miranda', 'USA'),
    ('Christian Wenz', 'USA')
;
```

**Books**

| Id | Title                                 |
|----|---------------------------------------|
| 1  | The Catcher in the Rye                |
| 2  | Nine Stories                          |
| 3  | Franny and Zooey                      |
| 4  | The Great Gatsby                      |
| 5  | Tender id the Night                   |
| 6  | Pride and Prejudice                   |
| 7  | Professional ASP.NET 4.5 in C# and VB |

**MYSQL**
SQL to create the table:
```sql
CREATE TABLE Books(
    Id INT NOT NULL AUTO_INCREMENT,
    Title varchar(50) NOT NULL,
    PRIMARY KEY(Id)
);

INSERT INTO Books
    (Id, Title)
VALUES
    (1, 'The Catcher in the Rye'),
    (2, 'Nine Stories'),
    (3, 'Franny and Zooey'),
    (4, 'The Great Gatsby'),
    (5, 'Tender id the Night'),
    (6, 'Pride and Prejudice'),
    (7, 'Professional ASP.NET 4.5 in C# and VB')
;
```

**BooksAuthors**

| BookId | AuthorId |
|--------|----------|
| 1      | 1        |
| 2      | 1        |
| 3      | 1        |
| 4      | 2        |
| 5      | 2        |
| 6      | 3        |
| 7      | 4        |
| 7      | 5        |
| 7      | 6        |
| 7      | 7        |
| 7      | 8        |

SQL to create the table 
```sql
CREATE TABLE BookAuthors (
    BookId INT NOT NULL,
    AuthorId INT NOT NULL,
    FOREIGN KEY (AuthorId) REFERENCES Authors(Id),
    FOREIGN KEY (BookId) REFERENCES Books(Id)
);

INSERT INTO BookAuthors
    (BookId, AuthorId)
VALUES
    (1, 1),
    (2, 1),
    (3, 1),
    (4, 2),
    (5, 2),
    (6, 3),
    (7, 4),
    (7, 5),
    (7, 6),
    (7, 7),
    (7, 8)
;
```
**EXAMPLE**

View all authors: `SELECT * FROM Authors;`<br/>
View all book titles: `SELECT * FROM Books;`<br/>
View all books and their authors:
```sql
SELECT
    ba.AuthorId,
    a.Name AS AuthorName,                   -- Alias 'AuthorName' is assigned to the 'Name' column from the 'Authors' table
    ba.BookId,
    b.Title AS BookTitle                    -- Alias 'BookTitle' is assigned to the 'Title' column from the 'Books' table
FROM BookAuthors ba                         -- Alias 'ba' is assigned to the 'BookAuthors' table
INNER JOIN Authors a ON a.Id = ba.AuthorId  -- Alias 'a' is assigned to the 'Authors' table
INNER JOIN Books b ON b.Id = ba.BookId;     -- Alias 'b' is assigned to the 'Books' table
```

# Countries Table
In this example, we have a Countries table. A table for countries has many uses, especially in Financial applications
involving currencies and exchange rates.

Some Market data software applications like Bloomberg and Reuters require you to give their API either a 2 or 3
character country code along with the currency code. Hence, this example table has both the 2-character ISO code
column and the 3 character ISO3 code columns.

**Countries**

| Id | ISO | ISO3 | ISONumeric | CountryName   | Capital      | ContinentCode | CurrencyCode |
|----|-----|------|------------|---------------|--------------|---------------|--------------|
| 1  | AU  | AUS  | 36         | Australia     | Canberra     | OC            | AUD          |
| 2  | DE  | DEU  | 276        | Germany       | Berlin       | EU            | EUR          |
| 2  | IN  | IND  | 356        | India         | New Delhi    | AS            | INR          |
| 3  | LA  | LAO  | 418        | Laos          | Vientiane    | AS            | LAK          |
| 4  | US  | USA  | 840        | United States | Washington   | NA            | USD          |
| 5  | ZW  | ZWE  | 716        | Zimbabwe      | Harare       | AF            | ZWL          |

SQL to create the table:
```sql
CREATE TABLE Countries (
    Id INT NOT NULL AUTO_INCREMENT,
    ISO VARCHAR(2) NOT NULL,
    ISO3 VARCHAR(3) NOT NULL,
    ISONumeric INT NOT NULL,
    CountryName VARCHAR(64) NOT NULL,
    Capital VARCHAR(64) NOT NULL,
    ContinentCode VARCHAR(2) NOT NULL,
    CurrencyCode VARCHAR(3) NOT NULL,
    PRIMARY KEY(Id)
);

INSERT INTO Countries
    (ISO, ISO3, ISONumeric, CountryName, Capital, ContinentCode, CurrencyCode)
VALUES
    ('AU', 'AUS', 36, 'Australia', 'Canberra', 'OC', 'AUD'),
    ('DE', 'DEU', 276, 'Germany', 'Berlin', 'EU', 'EUR'),
    ('IN', 'IND', 356, 'India', 'New Delhi', 'AS', 'INR'),
    ('LA', 'LAO', 418, 'Laos', 'Vientiane', 'AS', 'LAK'),
    ('US', 'USA', 840, 'United States', 'Washington', 'NA', 'USD'),
    ('ZW', 'ZWE', 716, 'Zimbabwe', 'Harare', 'AF', 'ZWL')
;
```


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)