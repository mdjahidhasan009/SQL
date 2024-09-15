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

## Granting Access to a MySQL Database for a Specific User

When a database is created by the `root` user in MySQL, other users do not get access to that database by default. You 
need to explicitly grant them permission as the `root` user to allow them to view or work with that database.

### Log in as root user
First, log in as the `root` user or any user with administrative privileges:
```bash
mysql -u root -p
```

### Grant Privileges to the Specific User
Use the `GRANT` command to provide the necessary privileges to the user for the `lerning_sql` database:
```sql
GRANT ALL PRIVILEGES ON database_name.* TO 'username'@'localhost';
```
- **`ALL PRIVILEGES`**: Grants all privileges (you can restrict this, e.g., `SELECT`, `INSERT`).
- **`lerning_sql.*`**: Refers to the `lerning_sql` database and all its tables.
- **`'username'@'localhost'`**: Replace `username` with the actual user. If connecting from another host, change 
  `localhost` accordingly (e.g., `'%` for any host).

### Flush Privileges
After granting the privileges, reload the privilege tables with:
```sql
FLUSH PRIVILEGES;
```

### Verify Access
Log in as the user you just granted access to and check if they can now see the `lerning_sql` database:
```bash
mysql -u username -p
```
Then use the `SHOW DATABASES;` command to verify:
```sql
SHOW DATABASES;
```

### Important Note:
- When a database is created by the `root` user, other users do not automatically have access to that database. You must
  grant them access manually using the `GRANT` command.

### Example
```sql
GRANT ALL PRIVILEGES ON database_name.* TO 'john'@'localhost';
FLUSH PRIVILEGES;
```
This command gives the user `john` access to the `lerning_sql` database from `localhost`.

### Limiting Privileges
If you want to grant limited privileges (e.g., only allow `SELECT`, `INSERT`, `UPDATE`):
```sql
GRANT SELECT, INSERT, UPDATE ON database_name.* TO 'username'@'localhost';
```
This allows the user to `SELECT`, `INSERT`, and `UPDATE` on the `lerning_sql` database.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)