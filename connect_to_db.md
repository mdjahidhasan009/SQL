
### MySQL vs PostgreSQL while connecting to a database

In MySQL, we can connect to database without specifying the database name in the connection string also terminal command.
For example, in MySQL terminal command:
```bash
mysql -u username -p
```

In PostgreSQL, we need to specify the database name while connecting to the database. For example, in PostgreSQL 
terminal command:
```bash
psql -U username -d dbname
```