## `stuff()` function
The stuff function deletes a part of the string and then inserts another part into the string starting at a specified 
position.

`STUFF(String1, Position, Length, String2)`

## Union
The Union operator is used to combine the result set of two or more select statements. For example, the first select 
statement returns the fish shown in Image A, and the second returns the fish shown in Image B. Then, the Union operator 
will return the result of the two select statements as shown in Image A U B. Also, if there is a record present in both 
tables, then we will get only one of them in the final result.

## Union All
The Union All operator is used to combine the result set of two or more select statements. The difference between Union
and Union All is that Union All will not remove duplicate records from the result set. So, if we apply the Union All
operator on the result of the two select statements, then we will get all the records from both the tables.




## UNION vs. UNION ALL in MySQL

Both `UNION` and `UNION ALL` are used in MySQL to combine the results of two or more `SELECT` statements into a single result set. However, they differ in how they handle duplicate rows.

**`UNION`:**

*   Removes duplicate rows from the combined result set.
*   Sorts the final result set (unless `ORDER BY` is specified).

**`UNION ALL`:**

*   Includes all rows from the combined result set, including duplicates.
*   Does *not* sort the final result set (unless `ORDER BY` is specified).  This makes it faster than `UNION`.

**Example:**

Let's say we have two tables, `customers_us` and `customers_eu`, containing customer information from the US and Europe, respectively.

**Table: `customers_us`**

| customer_id | customer_name | city       |
|-------------|---------------|------------|
| 1           | John Doe      | New York   |
| 2           | Jane Smith    | Los Angeles|
| 3           | Peter Jones   | Chicago    |
| 4           | John Doe      | New York   |  <- Duplicate

**Table: `customers_eu`**

| customer_id | customer_name | city        |
|-------------|---------------|-------------|
| 5           | Marie Curie   | Paris       |
| 6           | Hans Muller   | Berlin      |
| 7           | John Doe      | London      |
| 7           | John Doe      | London      |  <- Duplicate


**1. Using `UNION`:**

```sql
SELECT customer_id, customer_name, city FROM customers_us
UNION
SELECT customer_id, customer_name, city FROM customers_eu;
```

**Output:**

| customer_id | customer_name | city        |
|-------------|---------------|-------------|
| 1           | John Doe      | New York    |
| 2           | Jane Smith    | Los Angeles |
| 3           | Peter Jones   | Chicago     |
| 5           | Marie Curie   | Paris       |
| 6           | Hans Muller   | Berlin      |
| 7           | John Doe      | London      |

**Explanation:**

*   The `UNION` combined the results from both tables.
*   The duplicate row `(1, 'John Doe', 'New York')` from `customers_us` was removed.
*   The duplicate row `(7, 'John Doe', 'London')` from `customers_eu` was removed.
*   The result set was sorted by default (you can't see the sort order explicitly in this example but it's implicitly performed).

**2. Using `UNION ALL`:**

```sql
SELECT customer_id, customer_name, city FROM customers_us
UNION ALL
SELECT customer_id, customer_name, city FROM customers_eu;
```

**Output:**

| customer_id | customer_name | city        |
|-------------|---------------|-------------|
| 1           | John Doe      | New York    |
| 2           | Jane Smith    | Los Angeles |
| 3           | Peter Jones   | Chicago     |
| 4           | John Doe      | New York    |
| 5           | Marie Curie   | Paris       |
| 6           | Hans Muller   | Berlin      |
| 7           | John Doe      | London      |
| 7           | John Doe      | London      |

**Explanation:**

*   The `UNION ALL` combined the results from both tables.
*   The duplicate row `(4, 'John Doe', 'New York')` from `customers_us` was *included* in the result set.
*   The duplicate row `(7, 'John Doe', 'London')` from `customers_eu` was *included* in the result set.
*   The result set was *not* sorted (the order reflects the order of the `SELECT` statements and the order within each table).

**When to Use `UNION` vs. `UNION ALL`:**

*   **`UNION`:** Use when you need to ensure that the final result set contains only unique rows and sorting is required.
*   **`UNION ALL`:** Use when you want to include all rows, including duplicates, and sorting isn't important.  `UNION ALL` is generally faster, especially for large datasets, because it avoids the overhead of removing duplicates and sorting.  Only use `UNION ALL` if it is acceptable to have duplicate results in the output.

**Important Considerations:**

*   The `SELECT` statements in a `UNION` or `UNION ALL` must have the same number of columns.
*   The corresponding columns in each `SELECT` statement must have compatible data types.  MySQL will attempt to perform implicit conversions, but it's best to ensure the data types are aligned.
*   Column names in the final result set are usually derived from the first `SELECT` statement. If you want different column names, you can use aliases in the first `SELECT` statement.

```sql
SELECT customer_id AS id, customer_name AS name, city AS location FROM customers_us
UNION ALL
SELECT customer_id, customer_name, city FROM customers_eu;
```

In this case, the combined result set would have columns named `id`, `name`, and `location`.




## Intersect
The Intersect operator helps combine two select statements and returns only those records that are common to both the 
select statements. So, after we get Table A and Table B over here and if we apply the Intersect operator on these two 
tables, then we will get only those records that are common to the result of the select statements of these two.