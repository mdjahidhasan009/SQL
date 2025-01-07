////TODO: 
- randomize, left-right function, length, current timestamp, min, aggregation functions(sum, min, max, avg, etc)
- md5, sha2
- When we will use HAVING or WHERE
- checksum, generated column


# Built-in Functions Overview

Built-in functions in SQL and other languages can perform tasks like data formatting, string manipulation, aggregation, 
conversion, numeric operations, comparisons, and even encryption/decryption.

## Types of Functions

### String Manipulation
- **Examples:** `CONCAT()`, `SUBSTRING()`, `LENGTH()`, `REPLACE()`, `UPPER()`, `LOWER()`

### Numeric Calculations
- **Examples:** `ROUND()`, `CEIL()`, `FLOOR()`, `ABS()`, `SQRT()`

### Date and Time
- **Examples:** `NOW()`, `CURDATE()`, `DATEDIFF()`, `DATE_ADD()`, `DATE_FORMAT()`

### Control Flow
- **Examples:** `IF()`, `CASE`, `COALESCE()`, `IFNULL()`

### Cryptography
- **Examples:** `MD5()`, `SHA1()`, `ENCRYPT()`, `AES_ENCRYPT()`, `AES_DECRYPT()`

Other function categories include aggregation, search and comparison, type conversion, regular expressions, JSON,
geospatial, system functions, advanced mathematical operations, and lock management.

---

# String Manipulation Functions

## Common String Functions

1. **CHAR_LENGTH, LENGTH**
    - Returns the length of a string in characters or bytes.
    - **Use Case:** Determine the number of characters in a user's input.

2. **CONCAT, CONCAT_WS**
    - Joins two or more strings. `CONCAT_WS` adds a separator.
    - **Use Case:** Merge first and last names.

3. **FORMAT**
    - Formats numbers for better readability (e.g., `#,###.##`).
    - **Use Case:** Display currency values.

4. **INSTR**
    - Finds the position of a substring within another string.
    - **Use Case:** Locate a domain in an email address.

5. **LOWER, UPPER**
    - Converts text to lowercase or uppercase.
    - **Use Case:** Normalize text data.

6. **SUBSTR, SUBSTRING_INDEX**
    - Extracts a substring from a string.
    - **Use Case:** Retrieve parts of a URL or email.

7. **TRIM, LTRIM, RTRIM**
    - Removes spaces from a string.
    - **Use Case:** Clean user input.

8. **RIGHT, LEFT**
    - Extracts characters from the beginning or end of a string.
    - **Use Case:** Extract area codes or file extensions.

9. **LPAD, RPAD**
    - Pads a string to a specified length.
    - **Use Case:** Format strings for uniform display.

10. **REPLACE**
    - Replaces all occurrences of a substring in a string.
    - **Use Case:** Correct misspellings.

---

### SQL Examples

**Constructing a Full Name**: This query combines the first_name and last_name columns from the users table to create a
full_name column. **CONCAT** Joins strings together.

```sql
SELECT id, CONCAT(first_name, ' ', last_name) AS full_name
FROM users;
```

**Extracting Email Domain**: This query extracts the domain part of an email address by using `SUBSTRING` and `INSTR` 
functions. It finds the position of the `"@"` character and returns the substring from that position to the end of the 
email address. `INSTR`: Finds the position of a substring within a string. `SUBSTRING`: Extracts a portion of a string.
For `emran@gmail.com` we will get `gmail.com`

`SUBSTRING`, `INSTR` start from `1`, not `0`.
```sql
SELECT id, name, SUBSTRING(email, INSTR(email, '@') + 1) AS email_domain
FROM users;
```

**Creating a Slug**: This query creates a URL slug from the `product_name` by replacing spaces with hyphens and 
converting the text to lowercase. LOWER: Converts text to lowercase. REPLACE: Replaces occurrences of a specified
substring with another substring. LEFT
```sql
SELECT id, title,
    RIGHT(code, 4) AS code_main,
    LEFT(description, 100) AS excerpt,  -- Note: Changed from 10 to 100 to match your previous note.
    LOWER(REPLACE(product_name, ' ', '-')) AS url_slug
FROM products;
```

---

# Numeric Calculation Functions
## Common Numeric Functions

1. **ROUND, FLOOR, CEILING**
    - Description: Rounds a number to the nearest integer. FLOOR rounds down, CEILING rounds up.
    - Use Case: Adjusting numerical data for reporting or enforcing data integrity.
2. **MAX, MIN**
    - Description: Retrieves the maximum or minimum value from a given column or data set.
    - Use Case: Finding the highest or lowest value, such as price or score.
3. **SUM**
    - Description: Calculates the total sum of numerical values in a column or array.
    - Use Case: Totalling sales figures, points, or any set of numerical data.
4. **COUNT**
    - Description: Counts the total number of records in a dataset or group.
    - Use Case: Quantifying entries, such as the number of transactions or participants.
5. **RAND**
    - Description: Generates a random number between 0 (inclusive) and 1 (exclusive).
    - Use Case: Creating random samples or assigning random values for simulations.
6. **POWER, SQRT**
    - Description: POWER raises a number to a specified power. SQRT calculates the square root.
    - Use Case: Complex mathematical computations, such as physics simulations or financial projections.
7. **AVG**
    - Description: Computes the average (mean) of a set of numbers.
    - Use Case: Determining the central tendency of a dataset.
8. **DIV, MOD**
    - Description: DIV performs integer division. MOD returns the remainder of a division.
    - Use Case: Assessing divisibility, partitioning datasets, or scheduling recurring events.
9. **SIN, COS, TAN, COT**
    - Description: Calculates the trigonometric sine, cosine, tangent, and cotangent of an angle.
    - Use Case: Solving problems in trigonometry, physics, and engineering.
10. **ASIN, ATAN, ATAN2, ACOS**
    - Description: Computes the inverse trigonometric functions, returning the angle in radians.
    - Use Case: Converting from trigonometric ratios back to angles, often used in geometric computations.

---

### SQL Examples

**Calculating Total Price**

**ROUND Function**: Rounds a value to a specified number of decimal places. <br/>
**Description**: Calculates the total price for each item in an order by multiplying the **`unit_price`** by the
**`qty`** and rounding the result to two decimal places. <br/>
**Key Point to Remember**: ROUND is often used in financial calculations for precision in currency representation.

```sql
SELECT product_code, unit_price, qty, ROUND(unit_price * qty, 2) AS item_total
FROM order_items
WHERE order_id = 10105;
```

**Counting Admin Users**

**COUNT Function**: Counts the number of rows that match a specified condition.<br/>
**Description**: Counts how many users have the role 'admin'.<br/>
**Key Point to Remember**: COUNT provides summary information like total entries which is crucial for reporting and data
overviews.<br/>
```sql
SELECT COUNT(*)
FROM users
WHERE role = 'admin';
```

**Changing 1 out of 3 Users to a Teacher**

**MOD Function**: Determines the remainder of a division. <br/>
**Description**: Updates the role of every third user to 'teacher', based on their ID. <br/>
**Key Point to Remember**: MOD can categorize data or perform batch operations on subsets, useful in evenly distributing
tasks or attributes across a dataset. <br/>
```sql
UPDATE users
SET role = 'teacher'
WHERE MOD(id, 3) = 0;
```

---

# Date and Time Functions

## Overview

SQL offers robust date and time functions for operations like retrieving the current timestamp, calculating intervals, 
and formatting data.

**MySQL always saves using YYYY-MM-DD format.**

### Common Functions

**CURRENT_DATE, CURRENT_TIME**

- Retrieves the current date or time.
- Usage: Useful for timestamping transactions or records with the current date and/or time.

**DATE_ADD, DATE_SUB**

- Adds or subtracts a datetime interval from a date value.
- Usage: Calculating future or past dates by adding or subtracting time intervals.

**DATEDIFF, TIMEDIFF**

- Finds the difference between two dates or times.
- Usage: Determining the number of days between two dates or the time between two timestamps.

**DATE_FORMAT, TIME_FORMAT**

- Formats a date or time value according to a specified format.
- Usage: Presenting dates and times in various human-readable formats.

**MAKEDATE, MAKETIME**

- Creates a date or a time value from individual components.
- Usage: Assembling a date or time from separate values, such as year, month, and day.

**NOW**

- Returns the current date and time.
- Usage: Capturing the exact moment a record is created or modified.

**STR_TO_DATE**

- Converts a string to a date based on a specified format.
- Usage: Parsing date information from text data for storage in a date-type column.

**TO_DAYS, TIME_TO_SEC, SEC_TO_TIME, ...**

- Converts dates and times to various units.
- Usage: Transforming date and time values for calculations or comparisons.

**EXTRACT, HOUR, MONTH, MINUTE, MICROSECOND, ...**

- Extracts specific parts from a date or time value.
- Usage: Retrieving particular components of a date/time, such as the hour or day.

---

### SQL Examples

**Identifying Delayed Orders**: Retrieves orders where the shipment was delayed by more than 3 days.
```sql
SELECT id, order_date, shipped_date, DATEDIFF(shipped_date, order_date) AS delay
FROM orders
HAVING delay > 3;
```

**Fetching Future Payments**: Select payments scheduled with a future check date
```sql
SELECT check_number, amount
FROM payments
WHERE payment_date > CURDATE();
```


# Control Flow Functions
### **IF()**
- Constructs an if/else logic within SQL statements.
- **Usage Tip:** Use **`IF()`** for quick conditional checks within queries, especially for simple true/false
  evaluations.

### **CASE**
- A flexible case operator for multiple `WHEN-THEN-ELSE` conditions.
- **Usage Tip:** Use **`CASE`** for complex conditional logic, akin to a switch statement in programming.

### **IFNULL()**
- Evaluates if an expression is `NULL` and returns an alternative value.
- **Usage Tip:** Use **`IFNULL()`** to handle potential `NULL` values by providing a default, ensuring uninterrupted 
  calculations or data presentation.

### **NULLIF()**
- Compares two expressions and returns `NULL` if they are equal; otherwise, returns the first expression.
- **Usage Tip:** Use **`NULLIF()`** to avoid errors, such as division by zero, by converting problematic values to 
  `NULL`.

---

### Example: Display Customer Type Based on Credit Limit
To dynamically categorize customers based on their credit limit, this SQL query uses a `CASE` statement to differentiate
between 'Premium', 'Standard', and 'New' customers.

```sql
SELECT id, name,
  CASE
    WHEN credit_limit > 1000 THEN 'Premium'
    WHEN credit_limit > 500 THEN 'Standard'
    ELSE 'New'
  END AS customer_type
FROM customers;
```
- **Details:**
  - 'Premium' for credit limits over 1000.
  - 'Standard' for credit limits between 500 and 1000.
  - 'New' for all others.

---

### Example: Get Discount Eligibility Based on Current Stock
This query uses the **`IF`** function to determine discount eligibility based on stock quantity.

```sql
SELECT product_id, IF(stock_qty > 50, 'Eligible', 'Not Eligible') AS discount
FROM products;
```
- **Details:**
    - 'Eligible' if stock quantity > 50.
    - 'Not Eligible' if stock quantity ≤ 50.

---

# Cryptography / Hashing Functions

## **Overview**
Cryptography and hashing functions ensure data integrity, security, and privacy. These functions transform data into a
fixed-size hash or allow secure data encryption and decryption.

### Common Cryptography and Hashing Functions

1. **MD5()**
    - Creates a 128-bit hash value (32-character hex number).
    - **Use Case:** Verifying data integrity (not recommended for security due to vulnerabilities).

2. **SHA0, SHA1, SHA2**
    - Generate hash values of various lengths (SHA0 is obsolete, SHA1 produces a 160-bit hash, and SHA2 supports longer
      hashes).
    - **Use Case:** Secure data transmission, password storage, and digital signatures. SHA2 is preferred over SHA1 for
      stronger security.

3. **AES_ENCRYPT(), AES_DECRYPT()**
    - Encrypt and decrypt data using Advanced Encryption Standard (AES).
    - **Use Case:** Secure encryption for messaging or data storage.

4. **CRC32()**
    - Calculates a checksum to detect errors in data storage or transmission.
    - **Use Case:** Used in network communications and file storage to ensure data integrity.


### Security Notes

- MD5 and SHA1 are considered weak for secure hashing and should be avoided in favor of stronger algorithms like SHA256
  or SHA3.
- When using AES encryption, it's important to manage keys securely and use a strong key derivation function.
- CRC32 is not suitable for cryptographic security but is useful for error-checking purposes.

---

### Example: Saving User Password with MD5 Encryption
```sql
INSERT INTO users (username, password)
VALUES ('goodboy', MD5('the-secret-password'));
```
- **Explanation:** Encrypts the password using MD5 before storage. However, MD5 is not secure for modern applications.

---

### Example: Signing Document Updates with SHA1 Encryption
This example creates a hash of a document's content, username, and salt for integrity checks.

```sql
UPDATE documents
SET content_hash = SHA1(CONCAT(content, username, salt));
```
- **Explanation:** Generates a SHA1 hash to uniquely identify document changes. SHA1 is more secure than MD5 but less 
  secure than SHA2.

---

### Example: Encrypt and Decrypt with AES Encryption
#### Encryption:
```sql
UPDATE customers
SET credit_card_info = AES_ENCRYPT('the-card-number', 'encryptionkey');
```
#### Decryption:
```sql
SELECT customer_id, AES_DECRYPT(credit_card_info, 'encryptionkey') AS card_info
FROM customers;
```
- **Explanation:** Encrypts credit card information using AES before storing it. Decrypts data securely for use when needed.


### Checksum
Sometimes a table can be used by multiple applications and we need to know if any row data is changed. Then we can 
create a column with the content of all or some columns by hashing them. If the hash do not match then data is get
changed.

```sql
SELECT id, name, CRC32(name) AS checksum
FROM users;
```
- **Explanation:** Calculates a checksum for each user's name to detect any changes or errors in the data.
- **Note:** CRC32 is useful for error-checking but not suitable for cryptographic security.
- **Note:** The checksum value can be used to verify data integrity during transmission or storage.

---

## **Security Best Practices**
- **MD5:** Avoid for security-sensitive applications.
- **SHA1:** Deprecated; use SHA256 or SHA512 (part of SHA2) instead.
- **AES Encryption:** Secure for sensitive data but requires robust key management.
- **CRC32:** Useful for error-checking but not suitable for cryptographic security.



# Grouping | Aggregating | Analytical Functions

## Aggregation

Performs a function/calculation on a column (across multiple records) and returns a single value.

**Common Aggregation Functions:**

- **COUNT**
- **GROUP_CONCAT**
- **SUM**
- **AVG**
- **MIN**
- **MAX**

```sql
FUNC_NAME(expression)
SELECT COUNT(*) FROM PRODUCTS;
SELECT SUM(qty_in_stock) FROM PRODUCTS;
SELECT
    MAX(buy_price) max_price,
    MIN(buy_price) min_price,
    ROUND(AVG(buy_price), 2) average_price
FROM products;
```

### Aggregation with Filtering

#### Original Table

| order_id | product_code | quantity_ordered | price_each |
|----------|--------------|------------------|------------|
| 10100    | S18_1749     | 30               | 136.00     |
| 10100    | S18_2248     | 50               | 55.09      |
| 10100    | S18_4409     | 22               | 75.46      |
| 10100    | S24_3969     | 49               | 35.29      |
| 10101    | S18_2325     | 25               | 108.06     |
| 10101    | S18_2795     | 26               | 167.06     |
| 10101    | S24_1937     | 20               | 32.53      |
| 10101    | S24_2022     | 45               | 44.35      |
| 10102    | S18_1342     | 46               | 95.55      |
| 10102    | S18_1367     | 39               | 44.35      |
| 10103    | S10_1949     | 26               | 214.30     |
| 10103    | S10_4962     | 42               | 119.67     |


#### Applying Aggregation with Conditions

```sql
SELECT order_id, quantity_ordered * price_each AS row_total 
FROM orderd_items 
WHERE order_id = 10100;
```

| order_id | product_code | quantity_ordered | price_each | row_total |
|----------|--------------|------------------|------------|-----------|
| 10100    | S18_1749     | 30               | 136.00     | 4080.00   |
| 10100    | S18_2248     | 50               | 55.09      | 2754.50   |
| 10100    | S18_4409     | 22               | 75.46      | 1660.12   |
| 10100    | S24_3969     | 49               | 35.29      | 1729.21   |


#### Using `SUM`

```sql
SELECT order_id, SUM(quantity_ordered * price_each) AS row_total 
FROM orderd_items 
WHERE order_id = 10100;
```

| order_id | total     |
|----------|-----------|
| 10100    | 10223.83  |


---

### Aggregation with Grouping

#### Grouping Example

If we run `SUM` on `qty_in_stock` then we will get summation of all data on this column.

| code      | title                           | product_line     | vendor                    | qty_in_stock | buy_price | MSRP   |
|-----------|---------------------------------|------------------|---------------------------|--------------|-----------|--------|
| S10_1678  | 1969 Harley Davidson Ultim      | Motorcycles      | Min Lin Diecast           | 7933         | 48.81     | 95.70  |
| S10_1949  | 1952 Alpine Renault 1300        | Classic Cars     | Classic Metal Creations   | 7305         | 98.58     | 214.30 |
| S10_2016  | 1996 Moto Guzzi 1100i           | Motorcycles      | Highway 66 Mini Classics  | 6625         | 68.99     | 118.94 |
| S10_4698  | 2003 Harley-Davidson Eagle      | Motorcycles      | Red Start Diecast         | 5582         | 91.02     | 193.66 |
| S10_4757  | 1972 Alfa Romeo GTA             | Classic Cars     | Motor City Art Classics   | 3252         | 85.68     | 136.00 |
| S10_4962  | 1962 LanciaA Delta 16V          | Classic Cars     | Second Gear Diecast       | 6791         | 103.42    | 147.74 |
| S12_1099  | 1968 Ford Mustang               | Classic Cars     | Autoart Studio Design     | 68           | 95.34     | 194.57 |
| S12_1108  | 2001 Ferrari Enzo               | Classic Cars     | Second Gear Diecast       | 3619         | 95.59     | 207.80 |
| S12_1666  | 1958 Setra Bus                  | Trucks and Buses | Welly Diecast Productions | 1579         | 77.90     | 136.67 |
| S12_2823  | 2002 Suzuki XREO                | Motorcycles      | Unimax Art Galleries      | 9997         | 66.27     | 150.62 |
| S12_3148  | 1969 Corvair Monza              | Classic Cars     | Welly Diecast Productions | 6906         | 89.14     | 151.08 |
| S12_3380  | 1968 Dodge Charger              | Classic Cars     | Welly Diecast Productions | 9123         | 75.16     | 117.44 |

If we use GROUP BY then MySQL will make groups of the same value column and we can apply sum on those individual group.

| code      | title                           | product_line     | vendor                    | qty_in_stock | buy_price | MSRP   |
|-----------|---------------------------------|------------------|---------------------------|--------------|-----------|--------|
| S10_1678  | 1969 Harley Davidson Ultimate   | Motorcycles      | Min Lin Diecast           | 7933         | 48.81     | 95.70  |
| S10_2016  | 1996 Moto Guzzi 1100i           | Motorcycles      | Highway 66 Mini Classics  | 6625         | 68.99     | 118.94 |
| S12_2823  | 2002 Suzuki XREO                | Motorcycles      | Unimax Art Galleries      | 9997         | 66.27     | 150.62 |
| S10_4698  | 2003 Harley-Davidson Eagle D    | Motorcycles      | Red Start Diecast         | 5582         | 91.02     | 193.66 |
| S10_1949  | 1952 Alpine Renault 1300        | Classic Cars     | Classic Metal Creations   | 7305         | 98.58     | 214.30 |
| S10_4757  | 1972 Alfa Romeo GTA             | Classic Cars     | Motor City Art Classics   | 3252         | 85.68     | 136.00 |
| S10_4962  | 1962 LanciaA Delta 16V          | Classic Cars     | Second Gear Diecast       | 6791         | 103.42    | 147.74 |
| S12_1099  | 1968 Ford Mustang               | Classic Cars     | Autoart Studio Design     | 68           | 95.34     | 194.57 |
| S12_1108  | 2001 Ferrari Enzo               | Classic Cars     | Second Gear Diecast       | 3619         | 95.59     | 207.80 |
| S12_3148  | 1969 Corvair Monza              | Classic Cars     | Welly Diecast Productions | 6906         | 89.14     | 151.08 |
| S12_3380  | 1968 Dodge Charger              | Classic Cars     | Welly Diecast Productions | 9123         | 75.16     | 117.44 |
| S12_1666  | 1958 Setra Bus                  | Trucks and Buses | Welly Diecast Productions | 1579         | 77.90     | 136.67 |

If we run this SQL then

```sql
SELECT product_line, SUM(qty_in_stock)
FROM products
GROUP BY product_line;
```
Then sum will be operated on the virtual groups(Motorcycles, Classic Cars, Trucks and Buses)

| product_line   | qty_in_stock |
|----------------|--------------|
| Motorcycles    | 219183       |
| Classic Cars   | 69401        |
| Trucks and Buses| 35851       |

Get total payments per customer within a specific year

| customer_id | check_number | payment_date | amount    |
|-------------|--------------|--------------|-----------|
| 103         | HQ336336     | 2004-10-19   | 6066.78   |
| 103         | JM555205     | 2003-06-05   | 14571.44  |
| 103         | OM314933     | 2004-12-18   | 1676.14   |
| 112         | BO864823     | 2004-12-17   | 14191.12  |
| 112         | HD550220     | 2003-06-06   | 32641.98  |
| 112         | ND748579     | 2004-08-20   | 33347.88  |
| 114         | GG31455      | 2003-05-20   | 45864.03  |
| 114         | MA765515     | 2004-12-15   | 82261.22  |
| 114         | NP603840     | 2004-01-13   | 7565.08   |
| 114         | NR27552      | 2023-12-28   | 44894.74  |


```sql
SELECT customer_id, SUM(amount) AS total
FROM payments
WHERE payment_date
	BETWEEN '2004-01-01' AND '2004-12-31'
GROUP BY customer_id;
```

Result will be

| customer_id | total     |
|-------------|-----------|
| 103         | 7742.92   |
| 112         | 47539.00  |
| 114         | 82261.22  |

#### Use of `DISTINCT`
If we want to get the count of distinct vendors of a group then we can use DISTINCT, as there are multiple bikes for the
same vendor.
```sql
SELECT product_line, SUM(qty_in_stock), COUNT(DISTINCT vendor)
FROM products
GROUP BY product_line;
```

| code      | title                           | product_line     | vendor                        | qty_in_stock | buy_price | MSRP   |
|-----------|---------------------------------|------------------|-------------------------------|--------------|-----------|--------|
| S10_1678  | 1969 Harley Davidson Ultimate   | Motorcycles      | Min Lin Diecast               | 7933         | 48.81     | 95.70  |
| S10_2016  | 1996 Moto Guzzi 1100i           | Motorcycles      | Highway 66 Mini Classics      | 6625         | 68.99     | 118.94 |
| S12_2823  | 2002 Suzuki XREO                | Motorcycles      | Unimax Art Galleries          | 9997         | 66.27     | 150.62 |
| S10_4698  | 2003 Harley-Davidson Eagle D    | Motorcycles      | Red Start Diecast             | 5582         | 91.02     | 193.66 |
| S10_1949  | 1952 Alpine Renault 1300        | Classic Cars     | Classic Metal Creations       | 7305         | 98.58     | 214.30 |
| S10_4757  | 1972 Alfa Romeo GTA             | Classic Cars     | Motor City Art Classics       | 3252         | 85.68     | 136.00 |
| S10_4962  | 1962 LanciaA Delta 16V          | Classic Cars     | **Second Gear Diecast**       | 6791         | 103.42    | 147.74 |
| S12_1099  | 1968 Ford Mustang               | Classic Cars     | Autoart Studio Design         | 68           | 95.34     | 194.57 |
| S12_1108  | 2001 Ferrari Enzo               | Classic Cars     | **Second Gear Diecast**       | 3619         | 95.59     | 207.80 |
| S12_3148  | 1969 Corvair Monza              | Classic Cars     | **Welly Diecast Productions** | 6906         | 89.14     | 151.08 |
| S12_3380  | 1968 Dodge Charger              | Classic Cars     | **Welly Diecast Productions** | 9123         | 75.16     | 117.44 |
| S12_1666  | 1958 Setra Bus                  | Trucks and Buses | Welly Diecast Productions     | 1579         | 77.90     | 136.67 |



### Aggregation with Conditional Values

#### Example: Gifts Shipping
The company wants to send gifts to all employees. We will use DHL for non-USA employees and USMail for USA employees.

How many DHL bookings do we need?
```sql
SELECT 
    SUM(IF(o.country = 'USA', 0, 1)) AS DHL,
    SUM(IF(o.country = 'USA', 1, 0)) AS USMail
FROM employees e
JOIN offices o ON o.code = e.office_code;
```

#### Example: Shipment Costs
Shipment cost is $100 within the USA and $300 outside the USA.

How can we get total orders and their shipment costs by the salesperson (i.e. employee)?
```sql
SELECT 
    c.sales_rep_id,
    CONCAT(e.first_name, ' ', e.last_name) AS sales_person,
    COUNT(DISTINCT o.id) AS total_orders,
    SUM(IF(c.country = 'USA', 100, 300)) AS total_shipment_cost
FROM orders o
JOIN customers c ON c.id = o.customer_id
JOIN employees e ON e.id = c.sales_rep_id
GROUP BY c.sales_rep_id;
```

---

### Aggregation with `GROUP_CONCAT`

#### Example: Total Payments Per Customer with Check Numbers
If we want to get total payments per customer within a specified year. And also want to see list of check numbers with 
it.

| customer_id | check_number | payment_date | amount    |
|-------------|--------------|--------------|-----------|
| 103         | HQ336336     | 2004-10-19   | 6066.78   |
| 103         | JM555205     | 2003-06-05   | 14571.44  |
| 103         | OM314933     | 2004-12-18   | 1676.14   |
| 112         | BO864823     | 2004-12-17   | 14191.12  |
| 112         | HQ55022      | 2003-06-06   | 32641.98  |
| 112         | ND748579     | 2004-08-20   | 33347.88  |
| 114         | GG31455      | 2003-05-20   | 45864.03  |
| 114         | MA765515     | 2004-12-15   | 82261.22  |
| 114         | NP603840     | 2004-01-13   | 7565.08   |
| 114         | NR27552      | 2023-12-28   | 44894.74  |


```sql
SELECT customer_id, GROUP_CONCAT(check_number), SUM(amount) AS total
FROM payments
WHERE YEAR(payment_date) = '2004'
GROUP BY customer_id;
```

| customer_id | check_number             | total    |
|-------------|--------------------------|----------|
| 103         | HQ336336,OM314933        | 7742.92  |
| 112         | BO864823,ND748579        | 47539.00 |
| 114         | MA765515                 | 82261.22 |


#### Multiple GROUP BY
We have total payments per customer, per year

Now we want to see the list of check numbers with it
```sql
SELECT customer_id,
	YEAR(payment_date) payment_year,
	GROUP_CONCAT(check_number),
	SUM(amount) total
FROM payments
GROUP BY customer_id, payment_year;
```

| customer_id | payment_year | check_number          | total     |
|-------------|--------------|-----------------------|-----------|
| 103         | 2003         | JM555205             | 14571.44  |
| 103         | 2004         | HQ336336,OM314933    | 7742.92   |
| 112         | 2003         | HQ55022              | 32641.98  |
| 112         | 2004         | BO864823,ND748579    | 47539.00  |
| 114         | 2003         | GG31455              | 45864.03  |


---

### Handling `ONLY_FULL_GROUP_BY`
As we use `GROUP BY` product_line in a group there could be many distinct vendors but we will get one record/row per group. So MySql will throw an error `…incompatible with sql_mode=ONLY_FULL_GROUP_BY` as it does not know which vendor should return in a group after MySql 5 strict mode by default is on.

We can resolve this by

- Disable ONLY_FULL_GROUP_BY ⇒ not recommanded
- Adding an aggregate function
- Use ANY_VALUE()
- Add a column in GROUP BY

| code      | title                           | product_line     | vendor                        | qty_in_stock | buy_price | MSRP   |
|-----------|---------------------------------|------------------|-------------------------------|--------------|-----------|--------|
| S10_1678  | 1969 Harley Davidson Ultimate   | Motorcycles      | Min Lin Diecast               | 7933         | 48.81     | 95.70  |
| S10_2016  | 1996 Moto Guzzi 1100i           | Motorcycles      | Highway 66 Mini Classics      | 6625         | 68.99     | 118.94 |
| S12_2823  | 2002 Suzuki XREO                | Motorcycles      | Unimax Art Galleries          | 9997         | 66.27     | 150.62 |
| S10_4698  | 2003 Harley-Davidson Eagle D    | Motorcycles      | Red Start Diecast             | 5582         | 91.02     | 193.66 |
| S10_1949  | 1952 Alpine Renault 1300        | Classic Cars     | Classic Metal Creations       | 7305         | 98.58     | 214.30 |
| S10_4757  | 1972 Alfa Romeo GTA             | Classic Cars     | Motor City Art Classics       | 3252         | 85.68     | 136.00 |
| S10_4962  | 1962 LanciaA Delta 16V          | Classic Cars     | **Second Gear Diecast**       | 6791         | 103.42    | 147.74 |
| S12_1099  | 1968 Ford Mustang               | Classic Cars     | Autoart Studio Design         | 68           | 95.34     | 194.57 |
| S12_1108  | 2001 Ferrari Enzo               | Classic Cars     | **Second Gear Diecast**       | 3619         | 95.59     | 207.80 |
| S12_3148  | 1969 Corvair Monza              | Classic Cars     | **Welly Diecast Productions** | 6906         | 89.14     | 151.08 |
| S12_3380  | 1968 Dodge Charger              | Classic Cars     | **Welly Diecast Productions** | 9123         | 75.16     | 117.44 |
| S12_1666  | 1958 Setra Bus                  | Trucks and Buses | Welly Diecast Productions     | 1579         | 77.90     | 136.67 |


```sql
SELECT product_line, vendor, SUM(qty_in_stock)
FROM products
GROUP BY product_line;
```

Will give any value from the group

```sql
SELECT product_line, ANY_VALUE(vendor), SUM(qty_in_stock)
FROM products
GROUP BY product_line;
```




