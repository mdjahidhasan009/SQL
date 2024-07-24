## Grant/revoke privileges
```sql
GRANT SELECT, UPDATE
ON Employees
TO User1, User2;
```
Grant User1 and User2 permission to perform SELECT and UPDATE operations on table Employees.
```sql
REVOKE SELECT, UPDATE
ON Employees
FROM User1, User2
```
Revoke from User1 and User2 the permission to perform SELECT and UPDATE operations on table Employees.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)