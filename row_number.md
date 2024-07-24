## Delete All But Last Record (1 to Many Table)
```sql
WITH cte AS (
    SELECT ProjectID,
        ROW_NUMBER() OVER (PARTITION BY ProjectID ORDER BY InsertDate DESC) AS rn
    FROM ProjectNotes
)
DELETE FROM cte WHERE rn > 1;    
```
## Row numbers without partitions
Include a row number according to the order speciﬁed.
```sql
SELECT
    ROW_NUMBER() OVER(ORDER BY Fname ASC) AS RowNumber,
    Fname,
    LName
FROM Employees
```
## Row numbers with partitions
Uses a partition criteria to group the row numbering according to it.
```sql
SELECT
    ROW_NUMBER() OVER(PARTITION BY DepartmentId ORDER BY DepartmentId ASC) AS RowNumber,
    DepartmentId, Fname, LName
FROM Employees
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)