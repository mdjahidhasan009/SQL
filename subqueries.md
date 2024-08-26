## Subquery in FROM clause
A subquery in a FROM clause acts similarly to a temporary table that is generated during the execution of a query
and lost afterwards.
```sql
SELECT Managers.Id, Employees.Salary
FROM (
    SELECT Id
    FROM Employees
    WHERE ManagerId IS NULL
) AS Managers
JOIN Employees ON Managers.Id = Employees.Id
```

## Subquery in SELECT clause
```sql
SELECT
    Id,
    FName,
    LName,
    (SELECT COUNT(*) FROM Cars WHERE Cars.CustomerId = Customers.Id) AS NumberOfCars
FROM Customers  
```

## Subquery in WHERE clause
Use a subquery to ﬁlter the result set. For example this will return all employees with a salary equal to the highest
paid employee.
```sql
SELECT *
FROM Employees
WHERE Salary = (SELECT MAX(Salary) FROM Employees)
```

## Correlated Subqueries
Correlated (also known as Synchronized or Coordinated) Subqueries are nested queries that make references to
the current row of their outer query:
```sql
SELECT EmployeeId
    FROM Employee AS eOuter
    WHERE Salary > (
        SELECT AVG(Salary)
        FROM Employee eInner
        WHERE eInner.DepartmentId = eOuter.DepartmentId
    )
```
Subquery SELECT AVG(Salary) ... is correlated because it refers to Employee row eOuter from its outer query.

## Filter query results using query on different table
This query selects all employees not on the Supervisors table.
```sql
SELECT *
FROM Employees
WHERE EmployeeID not in (SELECT EmployeeID
                            FROM Supervisors)
```
The same results can be achieved using a LEFT JOIN.
```sql
SELECT *
FROM Employees AS e
LEFT JOIN Supervisors AS s ON s.EmployeeID=e.EmployeeID
WHERE s.EmployeeID is NULL
```

## Subqueries in FROM clause
You can use subqueries to deﬁne a temporary table and use it in the FROM clause of an "outer" query.
```sql
SELECT * FROM (SELECT city, temp_hi - temp_lo AS temp_var FROM weather) AS w
WHERE temp_var > 20;
```
The above ﬁnds cities from the weather table whose daily temperature variation is greater than 20. The result is:

| city          | temp_var |
|---------------|----------|
| ST LOUIS      | 21       |
| LOS ANGELES   | 31       |
| LOS ANGELES   | 23       |
| LOS ANGELES   | 31       |
| LOS ANGELES   | 27       |
| LOS ANGELES   | 28       |
| LOS ANGELES   | 28       |
| LOS ANGELES   | 32       |

## Subqueries in WHERE clause
The following example ﬁnds cities (from the cities example) whose population is below the average temperature
(obtained via a sub-qquery):
```sql
SELECT name, pop2000 FROM cities
WHERE pop2000 < (SELECT avg(pop2000)
FROM cities);
```
Here: the subquery (SELECT avg(pop2000) FROM cities) is used to specify conditions in the WHERE clause. The result
is:

| name          | pop2000  |
|---------------|----------|
| San Francisco | 776733   |
| ST LOUIS      | 348189   |
| Kansas City   | 146866   |


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)