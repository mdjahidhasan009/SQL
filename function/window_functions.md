## Setting up a flag if other rows have a common property

### Problem
You want to identify if any row shares a common property with other rows in the same table.

### Example Data
Table: `items`

| id    | name    | tag        |
|-------|---------|------------|
| 1     | example | unique_tag |
| 2     | foo     | simple     |
| 42    | bar     | simple     |
| 3     | baz     | hello      |
| 51    | quux    | world      |

### SQL to Create Table and Insert Data
```sql
-- Creating the items table
CREATE TABLE items (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    tag VARCHAR(50)
);

-- Inserting data into items table
INSERT INTO items (id, name, tag) VALUES
(1, 'example', 'unique_tag'),
(2, 'foo', 'simple'),
(42, 'bar', 'simple'),
(3, 'baz', 'hello'),
(51, 'quux', 'world');
```

### Solution
```sql
-- Query to check if tags are used by other rows
SELECT id, name, tag, COUNT(*) OVER (PARTITION BY tag) > 1 AS flag FROM items;
+----+---------+------------+------+
| id | name    | tag        | flag |
+----+---------+------------+------+
|  3 | baz     | hello      |    0 |
|  2 | foo     | simple     |    1 |
| 42 | bar     | simple     |    1 |
|  1 | example | unique_tag |    0 |
| 51 | quux    | world      |    0 |
+----+---------+------------+------+
5 rows in set (0.00 sec)
```

### Alternative for Databases Without `OVER` and `PARTITION BY`
```sql
SELECT id, name, tag, (SELECT COUNT(tag) FROM items B WHERE tag = A.tag) > 1 AS flag FROM items A;
+------+---------+------------+------+
| id   | name    | tag        | flag |
+------+---------+------------+------+
|    1 | example | unique_tag |    0 |
|    2 | foo     | simple     |    1 |
|    3 | baz     | hello      |    0 |
|   42 | bar     | simple     |    1 |
|   51 | quux    | world      |    0 |
+------+---------+------------+------+
5 rows in set (0.00 sec)
```

## Finding "Out-of-Sequence" Records Using the LAG() Function

### Problem
Items identified by ID values must move from STATUS 'ONE' to 'TWO' to 'THREE' in sequence, without skipping
statuses. The problem is to find users (STATUS_BY) values who violate the rule and move from 'ONE' immediately to
'THREE'.

### Example Data
Table: `test`

| ID | STATUS | STATUS_TIME                  | STATUS_BY |
|----|--------|------------------------------|-----------|
| 1  | ONE    | 2016-09-28-19.47.52.501398   | USER_1    |
| 3  | ONE    | 2016-09-28-19.47.52.501511   | USER_2    |
| 1  | THREE  | 2016-09-28-19.47.52.501517   | USER_3    |
| 3  | TWO    | 2016-09-28-19.47.52.501521   | USER_2    |
| 3  | THREE  | 2016-09-28-19.47.52.501524   | USER_4    |

### SQL to Create Table and Insert Data
```sql
-- Creating the test table
CREATE TABLE test (
    ID INT,
    STATUS VARCHAR(10),
    STATUS_TIME DATETIME,
    STATUS_BY VARCHAR(50)
);

-- Inserting data into test table
INSERT INTO test (ID, STATUS, STATUS_TIME, STATUS_BY) VALUES
(1, 'ONE', '2016-09-28 19:47:52.501398', 'USER_1'),
(3, 'ONE', '2016-09-28 19:47:52.501511', 'USER_2'),
(1, 'THREE', '2016-09-28 19:47:52.501517', 'USER_3'),
(3, 'TWO', '2016-09-28 19:47:52.501521', 'USER_2'),
(3, 'THREE', '2016-09-28 19:47:52.501524', 'USER_4');
```

### Solution
The `LAG()` analytical function helps to solve the problem by returning for each row the value in the preceding row:
```sql
SELECT * FROM (
    SELECT
        t.*,
        LAG(status) OVER (PARTITION BY id ORDER BY status_time) AS prev_status
    FROM test t
) t1 WHERE status = 'THREE' AND prev_status != 'TWO';
+------+--------+---------------------+-----------+-------------+
| ID   | STATUS | STATUS_TIME         | STATUS_BY | prev_status |
+------+--------+---------------------+-----------+-------------+
|    1 | THREE  | 2016-09-28 19:47:53 | USER_3    | ONE         |
+------+--------+---------------------+-----------+-------------+
1 row in set (0.00 sec)
```

### Alternative for Databases Without `LAG()`
```sql
SELECT A.id, A.status, B.status as prev_status, A.status_time, B.status_time as prev_status_time
FROM test A, test B
WHERE A.id = B.id
AND B.status_time = (SELECT MAX(status_time) FROM test WHERE status_time < A.status_time AND id = A.id)
AND A.status = 'THREE' AND NOT B.status = 'TWO';
Empty set (0.00 sec)
```

### Why `LAG()` and Subquery Approach Give Different Results

When working with SQL, it's common to encounter multiple ways to achieve the same goal, such as identifying "out-of-sequence" records. Two common methods include using the `LAG()` function and a subquery approach. However, even though these approaches may seem equivalent, they can produce different results due to subtle differences in how they operate.

#### Example Context

#### Data in `test` Table

| ID | STATUS | STATUS_TIME              | STATUS_BY |
|----|--------|--------------------------|-----------|
| 1  | ONE    | 2016-09-28 19:47:52.501  | USER_1    |
| 3  | ONE    | 2016-09-28 19:47:52.501  | USER_2    |
| 1  | THREE  | 2016-09-28 19:47:52.502  | USER_3    |
| 3  | TWO    | 2016-09-28 19:47:52.503  | USER_2    |
| 3  | THREE  | 2016-09-28 19:47:52.504  | USER_4    |

#### SQL Using `LAG()`

```sql
SELECT * FROM (
    SELECT
        t.*,
        LAG(status) OVER (PARTITION BY id ORDER BY status_time) AS prev_status
    FROM test t
) t1 WHERE status = 'THREE' AND prev_status != 'TWO';
```

#### Output

| ID | STATUS | STATUS_TIME              | STATUS_BY | prev_status |
|----|--------|--------------------------|-----------|-------------|
| 1  | THREE  | 2016-09-28 19:47:52.502  | USER_3    | ONE         |

#### SQL Using Subquery

```sql
SELECT A.id, A.status, B.status as prev_status, A.status_time, B.status_time as prev_status_time
FROM test A, test B
WHERE A.id = B.id
AND B.status_time = (SELECT MAX(status_time) FROM test WHERE status_time < A.status_time AND id = A.id)
AND A.status = 'THREE' AND NOT B.status = 'TWO';
```

#### Output

Empty set.

#### Explanation of Different Results

#### 1. **Timing Precision and Comparison Logic**

- **`LAG()` Function**: The `LAG()` function operates on ordered sets within partitions defined by `OVER`. It 
  effectively looks at the previous row based on the ordering criteria (`status_time` in this case), handling precise
  row-by-row evaluation.

- **Subquery Approach**: The subquery attempts to find the previous status by comparing timestamps. However, it relies 
  on `MAX(status_time)`, which may not always align perfectly with the exact row order when rows have similar or nearly 
  identical timestamps. This can result in missing matches.

#### 2. **Row Evaluation and Matching**

- **`LAG()`** evaluates each row with a clear backward-looking approach within each partition.

- **Subquery** can miss rows if `MAX(status_time)` does not find a precise match due to minute differences in 
  `status_time`.

#### 3. **NULL Handling Differences**

- `LAG()` might return `NULL` for the first row or when no prior row exists, but it still evaluates the rest correctly.
- Subqueries might fail to find matches, especially when the ordering or grouping assumptions are slightly off.

### Conclusion

Even though both approaches aim to achieve the same task, subtle differences in how they handle row ordering, matching,
and precision lead to different results. The `LAG()` function tends to be more reliable for ordered sequence tasks, 
while subqueries need careful handling of order and matching criteria to work equivalently.





## Getting a Running Total

### Problem
Calculate a running total of amounts over time.

### Example Data
Table: `operations`

| date         | amount |
|--------------|--------|
| 2016-03-12   | 200    |
| 2016-03-11   | -50    |
| 2016-03-14   | 100    |
| 2016-03-15   | 100    |
| 2016-03-10   | -250   |

### SQL to Create Table and Insert Data
```sql
-- Creating the operations table
CREATE TABLE operations (
    date DATE,
    amount INT
);

-- Inserting data into operations table
INSERT INTO operations (date, amount) VALUES
('2016-03-12', 200),
('2016-03-11', -50),
('2016-03-14', 100),
('2016-03-15', 100),
('2016-03-10', -250);
```

### Solution
```sql
SELECT date, amount, SUM(amount) OVER (ORDER BY date ASC) AS running
FROM operations
ORDER BY date ASC;
+------------+--------+---------+
| date       | amount | running |
+------------+--------+---------+
| 2016-03-10 |   -250 |    -250 |
| 2016-03-11 |    -50 |    -300 |
| 2016-03-12 |    200 |    -100 |
| 2016-03-14 |    100 |       0 |
| 2016-03-15 |    100 |     100 |
+------------+--------+---------+
5 rows in set (0.00 sec)
```



## Adding the Total Rows Selected to Every Row

### Problem
You want to include the total number of rows in your result set as an additional column for each row.

### Solution
Using a window function, you can add a count of the total rows selected to each row in the result set.

```sql
SELECT your_columns, COUNT(*) OVER() as Ttl_Rows FROM your_data_set;
```

### Example
Given this data in a table `items`:

| id  | name    | Ttl_Rows |
|-----|---------|----------|
| 1   | example | 5        |
| 2   | foo     | 5        |
| 3   | bar     | 5        |
| 4   | baz     | 5        |
| 5   | quux    | 5        |

Instead of using two queries to get a count and then fetching the rows, you can use an aggregate as a window function and apply it across the full result set as the window. This approach simplifies calculations without needing additional self-joins.

### SQL to Create Table and Insert Data
```sql
-- Creating the items table
CREATE TABLE items (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Inserting data into items table
INSERT INTO items (id, name) VALUES
(1, 'example'),
(2, 'foo'),
(3, 'bar'),
(4, 'baz'),
(5, 'quux');
```

## Getting the N Most Recent Rows Over Multiple Grouping

### Problem
Retrieve the N most recent rows within each group based on a specific column, such as a date.

### Example Data
Table: `Data`

| User_ID | Completion_Date |
|---------|-----------------|
| 1       | 2016-07-20      |
| 1       | 2016-07-21      |
| 2       | 2016-07-20      |
| 2       | 2016-07-21      |
| 2       | 2016-07-22      |

### Solution
You can use a Common Table Expression (CTE) with the `ROW_NUMBER()` function to assign a unique row number within each group, ordered by the desired date or column.

```sql
WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY User_ID ORDER BY Completion_Date DESC) AS Row_Num
    FROM Data
)
SELECT * FROM CTE WHERE Row_Num <= n;
```

Using `n=1`, you get the most recent row per `User_ID`:

| User_ID | Completion_Date | Row_Num |
|---------|-----------------|---------|
| 1       | 2016-07-21      | 1       |
| 2       | 2016-07-22      | 1       |

### SQL to Create Table and Insert Data
```sql
-- Creating the Data table
CREATE TABLE Data (
    User_ID INT,
    Completion_Date DATE
);

-- Inserting data into Data table
INSERT INTO Data (User_ID, Completion_Date) VALUES
(1, '2016-07-20'),
(1, '2016-07-21'),
(2, '2016-07-20'),
(2, '2016-07-21'),
(2, '2016-07-22');


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)