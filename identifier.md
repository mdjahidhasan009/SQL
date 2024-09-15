# Identifier
**Identifiers** are **names** used for **tables**, **columns**, and **other database objects** in SQL. Identifiers must follow certain 
syntax rules, which may vary across different SQL implementations. Identifiers can either be **unquoted** or **quoted**.

### Variations by SQL Implementations:
- **MS SQL**: Allows `@`, `$`, `#`, and other Unicode letters.
- **MySQL**: Allows `$`.
- **Oracle**: Allows `$`, `#`, and other letters from the database character set.
- **PostgreSQL**: Allows `$` and other Unicode letters.

### Case Sensitivity:
- **MS SQL**: Case-preserving; case sensitivity is defined by the database character set, meaning it can be 
  case-sensitive.
- **MySQL**: Case-preserving; case sensitivity depends on the database setting and underlying file system.
- **Oracle**: Converts unquoted identifiers to **uppercase**, treating them like quoted identifiers.
- **PostgreSQL**: Converts unquoted identifiers to **lowercase**, treating them like quoted identifiers.
- **SQLite**: Case-preserving, but case-insensitive for ASCII characters.

```sql
-- Example with special characters in identifiers
CREATE TABLE #EmployeesWith$Salary (   -- '#' and '$' used in table name
    @emp_id INT PRIMARY KEY,           -- '@' used in column name
    $name VARCHAR(100) NOT NULL,       -- '$' used in column name
    salary$ INT NOT NULL,              -- '$' used in column name
    department_# INT                   -- '#' used in column name
);
```

## Quoted Identifier
Quoted identifiers allow more flexibility and can include:
- Spaces
- Special characters (like `-`, `!`, etc.)
- Reserved SQL keywords

### Quoting Methods by SQL Implementations:
- **MS SQL**: Uses square brackets `[]` or double quotes `""` to quote identifiers.
- **MySQL, PostgreSQL, Oracle**: Uses double quotes `""`.

### Case Sensitivity with Quoted Identifiers:
Quoted identifiers preserve the case exactly as written and are case-sensitive in most implementations.

## Unquoted Identifier
Unquoted identifiers can consist of:
- **Letters** (a-z, A-Z)
- **Digits** (0-9)
- **Underscore** (_)

### Rules:
1. **Must start with a letter**.
2. **Special characters** may be allowed depending on the SQL implementation.

### Example:
```sql
-- Unquoted identifiers
CREATE TABLE Employees (
emp_id INT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(255) UNIQUE
);

-- Quoted identifiers
CREATE TABLE "Employees" (
"emp_id" INT PRIMARY KEY,
"Name" VARCHAR(100) NOT NULL,
"Email Address" VARCHAR(255) UNIQUE
);
```

## Sources:
- [SQL Notes for Professionals](https://goalkicker.com/SQLBook)