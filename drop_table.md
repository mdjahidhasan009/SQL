## Check for existence before dropping
MySQL Version ≥ 3.19
```sql
DROP TABLE IF EXITS MyTable
```

PostgreSQL Version ≥ 8.x
```sql
DROP TABLE IF EXITS MyTable
```

SQL Server Version ≥ 2005
```sql
If Exists(Select * From Information_Schema.Tables
        Where Table_Schema = 'dbo'
        And Table_Name = 'MyTable')
    Drop Table dbo.MyTable
```

SQLite Version ≥ 3.0
```sql
DROP TABLE IF EXISTS MyTable;
```

## Simple drop
```sql
Drop Table MyTable;
```


Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)