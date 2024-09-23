| Version  | Short Name | Standard                            | Release Date |
|----------|------------|-------------------------------------|--------------|
| 1986     | SQL-86     | ANSI X3.135-1986, ISO 9075:1987     | 1986-01-01   |
| 1989     | SQL-89     | ANSI X3.135-1989, ISO/IEC 9075:1989 | 1989-01-01   |
| 1992     | SQL-92     | ISO/IEC 9075:1992                   | 1992-01-01   |
| 1999     | SQL:1999   | ISO/IEC 9075:1999                   | 1999-12-16   |
| 2003     | SQL:2003   | ISO/IEC 9075:2003                   | 2003-12-15   |
| 2006     | SQL:2006   | ISO/IEC 9075:2006                   | 2006-06-01   |
| 2008     | SQL:2008   | ISO/IEC 9075:2008                   | 2008-07-15   |
| 2011     | SQL:2011   | ISO/IEC 9075:2011                   | 2011-12-15   |
| 2016     | SQL:2016   | ISO/IEC 9075:2016                   | 2016-12-01   |

# SQL
Structured Query Language (SQL) is a special-purpose programming language designed for managing data held in a Relational 
Database Management System (RDBMS). SQL-like languages can also be used in Relational Data Stream Management Systems
(RDBMS), or in "not-only SQL" (NoSQL) databases.

# Statements in SQL
### DDL(Data Definition Language)
It is used to **define the database structure such as tables**. It includes three statements such as **Create**, **Alter** 
and **Drop**.

#### CREATE
```sql
CREATE TABLE table_name
column_name1 data_type(size),
column_name2 data_type(size),
column_name3 data_type(size), 
```

#### ALTER
```sql
ALTER TABLE table_name
ADD column_name datatype
```
or
```sql
ALTER TABLE table_name
DROP COLUMN column_name
```
### DML(Data Manipulation Language)
These statements are used to **manipulate the data in records**. Commonly used DML statements are `insert`, `update` and 
`delete`.

The `SELECT` statement is used as partial DML statement that is used to select all or relevant records in the table.

There is also a (recently added) `MERGE` statement which can perform all 3 write operations (`INSERT`, `UPDATE`,`DELETE`).

### DCL(Data Control Language)
These statements are used to set privileges such as Grant and Revoke database access permission to the specific user.

# Data Integrity
Data Integrity defines the accuracy as well as the consistency of the data stored in a database. It also defines 
integrity constraints to enforce business rules on the data when it is entered into an application or a database.

# Collation
Collation is defined as a set of rules that determine how data can be sorted as well as compared. Character data is sorted
using the rules that define the correct character sequence along with options for specifying case-sensitivity, character
width etc.

# Datawarehouse
Datawarehouse refers to a central repository of data where the data is assembled from multiple sources of information. 
Those data are consolidated, transformed and made available for the mining as well as online processing. Warehouse data 
also have a subset of data called Data Marts.

# User Defined Datatypes
User defined datatypes let you extend the base SQL Server datatypes by providing a descriptive name, and format to the 
database. Take for example, in your database, there is a column called `Flight_Num` which appears in many tables. In all 
these tables it should be `varchar(8)`. In this case you could create a user defined datatype called `Flight_num_type` of
`varchar(8)` and use it across all your tables.

## Isolation levels
An isolation level determines the degree of isolation of data between concurrent transactions. The default SQL Server 
isolation level is Read Committed. Here are the other isolation levels (in the ascending order of isolation): Read 
Uncommitted, Read Committed, Repeatable Read, Serializable. See SQL Server books online for an explanation of the 
isolation levels. Be sure to read about SET TRANSACTION ISOLATION LEVEL, which lets you customize the isolation level at 
the connection level.

## Active/Active and Active/Passive cluster configurations
Hopefully you have experience setting up cluster servers. But if you don't, at least be familiar with the way clustering 
works and the two clustering configurations Active/Active and Active/Passive. SQL Server books online has enough information
on this topic and there is a good white paper available on Microsoft site.

## What is a table called, if it has neither Cluster nor Non-cluster Index? What is it used for?
Unindexed table or Heap. Microsoft Press Books and Book on Line(BOL) refers it as Heap. A heap is a table that does not 
have a clustered index and, therefore, the pages are not linked by pointers. The IAM pages are the only structures that 
link the pages in a table together.

Unindexed tables are good for fast storing of data. Many times it is better to drop all indexes from table and then do 
bulk of inserts and to restore those indexes after that

## What is a Scheduled Jobs or What is a Scheduled Tasks?
Scheduled tasks let user automate processes that run on regular or predictable cycles. User can schedule administrative 
tasks, such as cube processing, to run during times of slow business activity. User can also determine the order in which
tasks run by creating job steps within a SQL Server Agent job. E.g. back up database, Update Stats of Tables. Job steps 
give user control over flow of execution. If one job fails, user can configure SQL Server Agent to continue to run the 
remaining tasks or to stop execution.

## How to get @@ERROR and @@ROWCOUNT at the same time?
If @@Rowcount is checked after Error checking statement then it will have 0 as the value of @@Recordcount as it would 
have been reset. And if @@Recordcount is checked before the error-checking statement then @@Error would get reset. To 
get @@error and @@rowcount at the same time do both in same statement and store them in local variable. SELECT 
@RC = @@ROWCOUNT, @ER = @@ERROR

## Alias in SQL
An alias is a feature of SQL that is supported by most, if not all, RDBMSs. It is a temporary name assigned to the table 
or table column for the purpose of a particular SQL query. In addition, aliasing can be employed as an obfuscation 
technique to secure the real names of database fields. A table alias is also called a correlation name .

An alias is represented explicitly by the AS keyword but in some cases the same can be performed without it as well. 
Nevertheless, using the AS keyword is always a good practice.

```sql
SELECT a.emp_name AS "Employee" /* Alias using AS keyword */
B.emp_name AS "Supervisor"
FROM employee A, employee B     /* Alias without AS keyword */
WHERE A.emp_sup = B.emp_id;
```

### Referential Integrity
Referential integrity refers to the consistency that must be maintained between primary and foreign keys, i.e. every 
foreign key value must have a corresponding primary value.

# ACID
The full form of ACID is **Atomicity**, **Consistency**, **Isolation**, and **Durability**. To check the reliability of 
the transactions, ACID properties are used.
* **Atomicity:** Atomicity refers to completed or failed transactions, where transaction refers to a single logical 
  operation on data. This implies that if any aspect of a transaction fails, the whole transaction fails and the database 
  state remains unchanged.
* **Consistency:** Consistency means that the data meets all of the validity guidelines. The transaction never leaves the
  database without finishing its state.
* **Isolation:** Concurrency management is the primary objective of isolation.
* **Durability:** Durability ensures that once a transaction is committed, it will occur regardless of what happens in 
  between, such as a power outage, a fire, or some other kind of disturbance

## Database white box testing 
Database white box testing involves database consistency and ACID properties Database triggers and logical views decision
coverage, condition coverage and statement coverage database tables, data model and database schema referential integrity
rules.

## Entities
Entity can be a person, place, thing, or any identifiable object for which data can be stored in a database

## Relationships
Relationships between entities can be referred to as the connection between two tables or entities.

## Cursor
A database cursor is a control which enables traversal over the rows or records in the table. This can be viewed as a
pointer to one row in a set of rows. Cursor is very useful of traversing such as retrieval, addition and removal of
database records.
* After any variable declaration, DECLARE a cursor. A SELECT Statement must always be aligned with the cursor declaration.
* To initialize the result set, OPEN statements must be called before fetching the rows from the result table.
* To grab and switch to the next row in the result set, use the FETCH statement.
* To deactivate the cursor, use the CLOSE expression.
* Finally, use the DEALLOCATE clause to uninstall the cursor description and clear all the resources associated with it.

## OLTP
It stands for Online Transaction Processing, and we can consider it to be a category of software applications that is 
efficient for supporting transaction-oriented programs. One of the important attributes of the OLTP system is its 
potential to keep up the consistency. The OLTP system often follows decentralized planning to keep away from single 
points of failure. This system is generally designed for a large audience of end-users to perform short transactions. 
Also, queries involved in such databases are generally simple, need fast response time, and in comparison, return only 
a few records. So, the number of transactions per second acts as an effective measure for those systems.

## OLAP
OLAP stands for Online Analytical Processing, and it is a category of software programs that are identified by a 
comparatively lower frequency of online transactions. For OLAP systems, the efficiency of computing depends highly on 
the response time. Hence, such systems are generally used for data mining or maintaining aggregated historical data, and
they are usually used in multi-dimensional schemas.

### `ISNULL` operator
`ISNULL` function is used to check whether value given is NULL or not in SQL Server. This function also provides to 
replace a value with the NULL.

### Magic Tables in SQL Server
Insert and Delete tables are created when the trigger is fired for any DML command. Those tables are called Magic Tables
in SQL Server. Those magic tables are used inside the triggers for data transaction.

### Identity
Identity (or AutoNumber) is a column that automatically generates numeric values. A start and increment value can be set, 
but most DBA leave these at 1. A GUID column also generates numbers; the value of this cannot be controlled. Identity/GUID
columns do not need to be indexed.

#### Change name in SQL server
Supported in SQL Server 2000 and 2005
`Exec sp_renamedb "test", "test1"`
Supported in SQL server 2005 and later version
`ALTER Database "test1" Modify Name="test"`

#### Exceptions handled in SQL Server Programming
Exceptions are handled using TRY—-CATCH constructs and it is handles by writing scripts inside the TRY block and error
handling in the CATCH block.

#### Execution Plan
An execution plan is basically a roadmap that graphically or textually shows the data retrieval methods chosen by the SQL
Server query optimizer for a stored procedure or ad-hoc query and is a very useful tool for a developer to understand the
performance characteristics of a query or stored procedure since the plan is the one that SQL Server will place in its 
cache and use to execute the stored procedure or query. From within query analyzer is an option called "Show Execution
plan"(located on the query drop-down menu). If this option is turned on it will display query execution plan in separate 
window when query is ran again.


* [Identifier](./identifier.md)
* [Data Types](./data_types.md)
* [null](./null.md)
* [Some SQL Queries](./example_databases_and_tables.md)
* [SELECT](./select.md)
* [Group By](./group_by.md)
* [ORDER BY](./order_by.md)
* [AND OR Operators](./and_or_operators.md)
* [CASE](./case.md)
* [LIKE](./like.md)
* [IN clause](./in_clause.md)
* [Filter using WHERE and HAVING](./filter_using_WHERE_and_HAVING.md)
* [SKIP TAKE (Pagination)](./skip_take_pagination.md)
* [EXCEPT](./except.md)
* [EXPLAIN and DESCRIBE](./explain_describe.md)
* [EXISTS](./exists_clause.md)
* [UPDATE](./update.md)
* [CREATE Database](./create_database.md)





* [SQL Execution Order](./sql_execution_order.md)