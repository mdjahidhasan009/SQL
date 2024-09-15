# Data Types
Data types are used to define the type of data that a column can hold. The data type of column must be defined when a
new table is created. The data type of column defines what value the column can hold: integer, character, money, date 
and time, binary, and so on.

## Data Types in SQL
Data types in SQL are categorized into three main categories:

**Numeric:** INTEGER, FLOAT, DOUBLE, DECIMAL, BIT, BOOL etc.<br/>
**Texts:** CHAR, VARCHAR, TEXT, BLOB, BINARY, ENUM etc. <br/>
**Date/Time:** DATE, DATETIME, TIMESTAMP, TIME, YEAR etc.


# DECIMAL and NUMERIC
Fixed precision and scale decimal numbers. `DECIMAL` and `NUMERIC` are function equivalent.

Syntax
```sql
DECIMAL(precision, [ , scale ] )
NUMERIC(precision, [ , scale ] )
```
Example
```sql
SELECT CAST( 123 AS DECIMAL(5, 2) )       --return 123.00
SELECT CAST( 12345.12 AS NUMERIC(10, 5) ) --return 12345.12000
```

## Difference Between DECIMAL and NUMERIC in SQL

In SQL, both `DECIMAL` and `NUMERIC` data types are used to store exact numeric values with a fixed precision and scale.
They are functionally equivalent in most SQL implementations, meaning they behave the same way. However, there can be 
slight differences depending on the SQL dialect or implementation.

### Similarities
- Both `DECIMAL` and `NUMERIC` store exact numbers with a **fixed precision** and **scale**.
- They both accept two arguments: `precision` (total number of digits) and `scale` (number of digits after the decimal
  point).
- Both are used when you need to store exact values such as monetary amounts.

### General Syntax:
```sql
DECIMAL(precision, scale)
NUMERIC(precision, scale)
```

### Example:
```sql
-- DECIMAL example
CREATE TABLE example (
    price DECIMAL(10, 2)
);

-- NUMERIC example
CREATE TABLE example (
    price NUMERIC(10, 2)
);
```

In the above examples, both `DECIMAL(10, 2)` and `NUMERIC(10, 2)` can store values up to 8 digits before the decimal 
point and 2 digits after.

### Differences

1. **ANSI/ISO SQL Standard**:
    - According to the ANSI SQL standard, `DECIMAL` and `NUMERIC` are equivalent, but some databases may handle them 
      differently.
2. **Strictness (Slight Theoretical Difference)**:
    - The **`NUMERIC`** type is theoretically more **strict** in terms of enforcing precision and scale. It guarantees 
      that the precision and scale specified are strictly enforced.
    - **`DECIMAL`**, on the other hand, allows for some flexibility in certain database systems, although most systems 
      implement both the same way.
3. **Vendor-Specific Behavior**:
    - **Microsoft SQL Server**: Treats `DECIMAL` and `NUMERIC` exactly the same. There is no difference in behavior or
      storage.
    - **MySQL**: Also treats `DECIMAL` and `NUMERIC` as equivalent.
    - **Oracle**: Only supports `NUMBER`, which can function like `DECIMAL` or `NUMERIC` depending on how it is used.

### Conclusion
In practice, **there is no significant difference** between `DECIMAL` and `NUMERIC` in most SQL implementations. They 
are used interchangeably to store exact numeric values with defined precision and scale. The theoretical difference is
that `NUMERIC` might be stricter in enforcing precision, but this is rarely noticeable in modern databases.

# FLOAT and REAL
Approximate-number data types for use with floating point numeric data.
```sql
SELECT CAST( PI() AS FLOAT) --returns 3.14159265358979
SELECT CAST( PI() AS REAL)  --returns 3.141593
```

## FLOAT and REAL in SQL

In SQL, `FLOAT` and `REAL` are data types used for storing approximate numeric values, meaning they store numbers that 
can be rounded or approximate. They are commonly used **when precision isn't critical**, and **large ranges of values 
are necessary**.

### FLOAT
- **`FLOAT`** is used to store approximate numeric values with floating-point precision.
- **Precision**: The precision of `FLOAT` is determined by the number of bits used to store the mantissa (fractional
  part of the number).
- **Syntax**:
   - `FLOAT(p)` where `p` is the number of bits that specify the precision. The higher the value of `p`, the more 
     precision you get.
   - `FLOAT` without `p` defaults to implementation-specific precision.

### Example:
```sql
CREATE TABLE ExampleTable (
    floatColumn FLOAT(24)    -- FLOAT with 24 bits of precision
);
```

### REAL
- **`REAL`** is similar to `FLOAT`, but it has a lower level of precision.
- It is a single-precision floating-point number that typically uses 32 bits (4 bytes) to store the value.
- `REAL` is often used in place of `FLOAT(24)`.

#### Example:
```sql
CREATE TABLE ExampleTable (
    realColumn REAL           -- REAL is equivalent to FLOAT(24) in many systems
);
```

### Differences:
1. **Precision**:
   - **`FLOAT`** can have a varying degree of precision based on the `p` value (number of bits used for storage).
   - **`REAL`** is a fixed-precision type, often equivalent to `FLOAT(24)` (single precision).

2. **Storage**:
   - **`FLOAT`** allows variable precision, which may take up more or less space depending on the precision specified.
   - **`REAL`** is typically stored as a 32-bit floating-point number.

3. **Usage**:
   - Use `FLOAT` when you need to specify the precision explicitly.
   - Use `REAL` when you need single-precision floating-point numbers and don't require specific precision control.

### Vendor-Specific Behavior:
- **Microsoft SQL Server**:
   - `REAL` is the same as `FLOAT(24)` (single precision).
   - `FLOAT` without a precision argument defaults to `FLOAT(53)` (double precision).
- **MySQL**:
   - `FLOAT` and `REAL` are used as single-precision floating-point types, while `DOUBLE` provides double precision.
- **PostgreSQL**:
   - `REAL` is a 4-byte floating-point number, while `DOUBLE PRECISION` is an 8-byte floating-point number.

### Conclusion:
- `FLOAT` is flexible and allows you to specify the precision, but it may not always store exact values.
- `REAL` is generally equivalent to single-precision `FLOAT(24)` and is useful for less precise numerical values.

# Integer 

In SQL, integers are **exact-number data types** used for storing whole numbers (without any fractional component). 
These data types vary in terms of the range of values they can hold and the amount of storage they require.

## Common Integer Data Types

| Data Type | Range                                                                    | Storage  |
|-----------|--------------------------------------------------------------------------|----------|
| bigint    | -2^63 (-9,223,372,036,854,775,808) to 2^63-1 (9,223,372,036,854,775,807) | 8 Bytes  |
| int       | -2^31 (-2,147,483,648) to 2^31-1 (2,147,483,647)                         | 4 Bytes  |
| smallint  | -2^15 (-32,768) to 2^15-1 (32,767)                                       | 2 Bytes  |
| tinyint   | 0 to 255                                                                 | 1 Byte   |

### Summary of Data Types:
- **`bigint`**: Stores large integer values up to 64-bit.
- **`int`**: The most common integer type, used to store 32-bit whole numbers.
- **`smallint`**: Stores smaller integers up to 16-bit.
- **`tinyint`**: Stores very small integers, typically used when the value range is small (e.g., 0-255).

### Use Cases:
- Use `bigint` for very large numbers, typically required in situations where values might exceed billions.
- Use `int` as a general-purpose integer for most cases, which is the default integer type.
- Use `smallint` and `tinyint` when storage space is important, and the range of values is small.

## Conclusion:
In SQL, choosing the correct integer type is important for both storage efficiency and ensuring the range of values matches your application's needs.

## MONEY and SMALLMONEY
Data types that represent monetary or currency values.

| Data Type   | Range                                                 | Storage |
|-------------|-------------------------------------------------------|---------|
| money       | -922,337,203,685,477.5808 to 922,337,203,685,477.5807 | 8 Bytes |
| smallmoney  | -214,748.3648 to 214,748.3647                         | 4 Bytes |

## BINARY and VARBINARY
Binary data types of either ﬁxed length or variable length.

Syntax:
```sql
BINARY [ ( n_bytes ) ]
VARBINARY [ ( n_bytes | max ) ]
```

`n_bytes` can be any number from 1 to 8000 bytes. `max` indicates that the maximum storage space is 2^31-1.

Examples:
```sql
SELECT CAST(12345 AS BINARY(10)) -- 0x00000000000000003039
SELECT CAST(12345 AS VARBINARY(10)) -- 0x00003039
```

# CHAR and VARCHAR in SQL

In SQL, `CHAR` and `VARCHAR` are string data types used to store text. The key difference between them is whether the 
length is fixed or variable.

## Syntax
```sql
CHAR [ ( n_chars ) ]
VARCHAR [ ( n_chars ) ]
```

- **`CHAR(n)`**: A fixed-length string with a length of `n` characters. If the string is shorter than `n`, it is padded 
  with spaces.
- **`VARCHAR(n)`**: A variable-length string with a maximum length of `n` characters. It does not pad the string with 
  spaces if it is shorter than `n`.

## Examples

### Example 1: CHAR Padding with Spaces
```sql
SELECT CAST('ABC' AS CHAR(10)); 
-- Result: 'ABC' (padded with spaces on the right to make 10 characters)
```

### Example 2: VARCHAR without Padding
```sql
SELECT CAST('ABC' AS VARCHAR(10)); 
-- Result: 'ABC' (no padding, as VARCHAR is a variable-length type)
```

### Example 3: CHAR Truncation
```sql
SELECT CAST('ABCDEFGHIJKLMNOPQRSTUVWXYZ' AS CHAR(10));
-- Result: 'ABCDEFGHIJ' (truncated to 10 characters)
```

## Key Differences:

1. **Storage**:
   - `CHAR(n)` always uses `n` bytes of storage, regardless of the actual string length (padded with spaces if needed).
   - `VARCHAR(n)` uses only the amount of space necessary to store the actual string, plus a small amount of overhead 
     for storing the string length.

2. **Use Case**:
   - Use `CHAR` when all the values in the column have a consistent, fixed length (e.g., country codes or postal codes).
   - Use `VARCHAR` when the length of the values varies widely, and storage efficiency is important (e.g., names or 
     email addresses).

## Conclusion:
- Use `CHAR` for fixed-length strings and `VARCHAR` for variable-length strings. The choice depends on the use case and 
  the specific behavior you need, such as padding or truncation.

## NCHAR and NVARCHAR
UNICODE string data types of either ﬁxed length or variable length.

Syntax:
```sql
NCHAR [ ( n_chars ) ]
NVARCHAR [ ( n_chars | MAX ) ]
```
Use `MAX` for very long strings that may exceed 8000 characters.

## UNIQUEIDENTIFIER
A 16-byte GUID / UUID.
```sql
DECLARE @GUID UNIQUEIDENTIFIER = NEWID();
SELECT @GUID -- 'E28B3BD9-9174-41A9-8508-899A78A33540'
DECLARE @bad_GUID_string VARCHAR(100) = 'E28B3BD9-9174-41A9-8508-899A78A33540_foobarbaz'
SELECT
     @bad_GUID_string,  -- 'E28B3BD9-9174-41A9-8508-899A78A33540_foobarbaz'
     CONVERT(UNIQUEIDENTIFIER, @bad_GUID_string) -- 'E28B3BD9-9174-41A9-8508-899A78A33540'
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)