////TODO: Will modify this file to be more readable and understandable
## ON DELETE CASCADE
Assume you have an application that administers rooms.

Assume further that your application operates on a per-client basis (tenant). You have several clients. So your database
will contain one table for clients, and one for rooms.

Now, every client has N rooms.

This should mean that you have a foreign key on your room table, referencing the client table.

**SQL-Server:**
```sql
ALTER TABLE dbo.T_Room WITH CHECK ADD
CONSTRAINT FK_T_Room_T_Client FOREIGN KEY(RM_CLI_ID)
REFERENCES dbo.T_Client (CLI_ID)
GO
```

**MySQL:**
```sql
ALTER TABLE T_Room
ADD CONSTRAINT FK_T_Room_T_Client
FOREIGN KEY (RM_CLI_ID)
REFERENCES T_Client (CLI_ID);
```
* `ALTER TABLE T_Room`:
  * This part of the command specifies that you are modifying the table named `T_Room`. You are altering its structure by 
    adding a new constraint.
* `ADD CONSTRAINT FK_T_Room_T_Client`:
  * This section defines the name of the foreign key constraint being added. Naming the constraint (`FK_T_Room_T_Client`)
    helps in managing and identifying it later, especially if you need to drop or modify it.
* `FOREIGN KEY (RM_CLI_ID)`:
  * This specifies that the column `RM_CLI_ID` in the `T_Room` table is the foreign key. A foreign key is a column or a 
    set of columns that establish and enforce a link between the data in the two tables.
* `REFERENCES T_Client (CLI_ID)`:
  * This part points to the primary key column (`CLI_ID`) of the `T_Client` table. It establishes the relationship by 
    specifying that `RM_CLI_ID` in T_Room must match values in `CLI_ID` of the `T_Client` table, ensuring referential 
    integrity.

Assuming a client moves on to some other software, you'll have to delete his data in your software. But if you do
```sql
DELETE FROM T_Client WHERE CLI_ID = x;
```
Then you'll get a foreign key violation, because you can't delete the client when he still has rooms.

Now you'd have written code in your application that deletes the client's rooms before it deletes the client. Assume
further that in the future, many more foreign key dependencies will be added in your database, because your
application's functionality expands. Horrible. For every modification in your database, you'll have to adapt your
application's code in N places. Possibly you'll have to adapt code in other applications as well (e.g. interfaces to
other systems).

There is a better solution than doing it in your code. You can just add `ON DELETE CASCADE` to your foreign key.

**SQL-Server:**
```sql
ALTER TABLE dbo.T_Romm -- WITH CHECK -- SQL-Server can specify WITH CHECK/WITH NOCHECK
ADD CONSTRAINT FK_T_Room_T_Client FOREIGN KEY(RM_CLI_ID)
REFERENCES dbo.T_Client(CLI_ID)
ON DELETE CASCADE
```

**MySQL:**
```sql
ALTER TABLE T_Room
ADD CONSTRAINT FK_T_Room_T_Client
FOREIGN KEY (RM_CLI_ID)
REFERENCES T_Client (CLI_ID)
ON DELETE CASCADE;
```

Now you can say
```sql
DELETE FROM T_Client WHERE CLI_ID = x;
```
and the rooms are automatically deleted when the client is deleted. Problem solved - with no application code changes.

One word of caution: In Microsoft SQL-Server, this won't work if you have a table that references itself. So if you try
to define a delete cascade on a recursive tree structure, like this:

**SQL-Server:**
```sql
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id =
OBJECT_ID(N'[dbo].[FK_T_FMS_Navigation_T_FMS_Navigation]') AND parent_object_id =
OBJECT_ID(N'[dbo].[T_FMS_Navigation]'))
ALTER TABLE [dbo].[T_FMS_Navigation] WITH CHECK ADD CONSTRAINT
[FK_T_FMS_Navigation_T_FMS_Navigation] FOREIGN KEY([NA_NA_UID])
REFERENCES [dbo].[T_FMS_Navigation] ([NA_UID])
ON DELETE CASCADE
IF EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id =
OBJECT_ID(N'[dbo].[FK_T_FMS_Navigation_T_FMS_Navigation]') AND parent_object_id =
OBJECT_ID(N'[dbo].[T_FMS_Navigation]'))
ALTER TABLE [dbo].[T_FMS_Navigation] CHECK CONSTRAINT [FK_T_FMS_Navigation_T_FMS_Navigation]
GO
```

**MySQL:**
```sql
-- Step 1: Check if the foreign key exists using INFORMATION_SCHEMA
SELECT COUNT(*) 
INTO @fk_exists
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_NAME = 'FK_T_FMS_Navigation_T_FMS_Navigation'
  AND TABLE_NAME = 'T_FMS_Navigation'
  AND CONSTRAINT_TYPE = 'FOREIGN KEY';

-- Step 2: Conditionally add the foreign key constraint if it does not exist
SET @sql_add_constraint = IF(@fk_exists = 0, 
    'ALTER TABLE T_FMS_Navigation 
     ADD CONSTRAINT FK_T_FMS_Navigation_T_FMS_Navigation 
     FOREIGN KEY (NA_NA_UID) 
     REFERENCES T_FMS_Navigation (NA_UID) 
     ON DELETE CASCADE;', 
    'SELECT "Foreign Key already exists";');

-- Execute the dynamically built SQL statement to add the constraint
PREPARE stmt_add FROM @sql_add_constraint;
EXECUTE stmt_add;
DEALLOCATE PREPARE stmt_add;

-- Step 3: Check if the foreign key exists again to enable it (if required)
SELECT COUNT(*) 
INTO @fk_exists_enable
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
WHERE CONSTRAINT_NAME = 'FK_T_FMS_Navigation_T_FMS_Navigation'
  AND TABLE_NAME = 'T_FMS_Navigation'
  AND CONSTRAINT_TYPE = 'FOREIGN KEY';

-- Conditionally enable the constraint if it exists (though MySQL does this by default)
SET @sql_enable_constraint = IF(@fk_exists_enable = 1, 
    'ALTER TABLE T_FMS_Navigation 
     CHECK CONSTRAINT FK_T_FMS_Navigation_T_FMS_Navigation;', 
    'SELECT "Foreign Key does not exist to enable";');

-- Execute the dynamically built SQL statement to enable the constraint
PREPARE stmt_enable FROM @sql_enable_constraint;
EXECUTE stmt_enable;
DEALLOCATE PREPARE stmt_enable;
```

it won't work, because Microsoft-SQL-server doesn't allow you to set a foreign key with `ON DELETE CASCADE` on a
recursive tree structure. One reason for this is, that the tree is possibly cyclic, and that would possibly lead to a
deadlock.

PostgreSQL on the other hand can do this, the requirement is that the tree is non-cyclic. If the tree is cyclic, you'll
get a runtime error. In that case, you'll just have to implement the delete function yourself.



#### A word of caution:
This means you can't simply delete and re-insert the client table anymore, because if you do this, it will delete all
entries in "T_Room"... (no non-delta updates anymore). So you'll have to delete the client and re-insert it in two
steps.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)