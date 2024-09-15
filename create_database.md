## CREATE Database
A database is created with the following SQL command:
```sql
CREATE DATABASE myDatabase;
```
This would create an empty database named myDatabase where you can create tables.

## Optional Parameters
The following optional parameters can be added to the CREATE DATABASE command:
* CHARACTER SET
* COLLATE
* ENCRYPTION
* IF NOT EXISTS
* DBPROPERTIES
* LOCATION
* COMMENT

## Example
```sql
CREATE DATABASE myDatabase
CHARACTER SET utf8
COLLATE utf8_general_ci;
```

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)