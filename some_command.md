### Get all the users of mysql
First you need to log in to mysql `mysql -u root -p`

Then we can get all the users using `SELECT User from mysql.user;`
```sql
mysql> SELECT User from mysql.user;
+------------------+
| User             |
+------------------+
| debian-sys-maint |
| mysql.infoschema |
| mysql.session    |
| mysql.sys        |
| root             |
+------------------+
5 rows in set (0.00 sec)
```

### Create a new user
We can create an user using `CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';`
```sql
mysql> CREATE USER 'newuser'@'localhost' IDENTIFIED BY 'password';
Query OK, 0 rows affected (0.04 sec)
mysql> 
```