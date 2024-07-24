## Students with same name and date of birth
```sql
WITH CTE (StudentId, Fname, LName, DOB, RowCnt)
as (
    SELECT StudentId, FirstName, LastName, DateOfBirth as DOB, SUM(1) OVER (Partition By FirstName,
        LastName, DateOfBirth) as RowCnt
    FROM tblStudent
)
SELECT * from CTE where RowCnt > 1
ORDER BY DOB, LName
```
This example uses a Common Table Expression and a Window Function to show all duplicate rows (on a subset of
columns) side by side.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)