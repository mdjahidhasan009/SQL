# CAST Function in SQL

The `CAST` function in SQL is used to convert an expression from one data type to another. It is a standard SQL function
and is supported by most relational databases, including MySQL, MS SQL, PostgreSQL, and Oracle.

## Syntax
```sql
CAST(expression AS target_data_type)
```

- **`expression`**: The value or column you want to convert.
- **`target_data_type`**: The data type to which you want to convert the expression.

## Example
### Converting an Integer to a Decimal:
```sql
SELECT CAST(123 AS DECIMAL(5, 2));
```
This example converts the integer `123` into a `DECIMAL` with a precision of 5 and a scale of 2, resulting in `123.00`.

### Converting a String to a Date:
```sql
SELECT CAST('2023-01-01' AS DATE);
```
This converts the string `'2023-01-01'` into a `DATE` data type.

## Use Cases
- **Type Conversion**: The `CAST` function is primarily used for **explicit type conversion**, ensuring that the data is
  in the desired format for further operations.
- **Examples**: Converting integers to decimals, strings to dates, or one numeric type to another.

## Summary
- `CAST` is used for converting data from one type to another.
- It supports converting between common SQL data types like `INTEGER`, `DECIMAL`, `DATE`, `VARCHAR`, etc.
- It helps ensure the right data type is used in operations, especially when working with mixed types.