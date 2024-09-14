## Difference between DROP and TRUNCATE statements
If a table is dropped, all things associated with the tables are dropped as well. This includes - the relationships defined
on the table with other tables, the integrity checks and constraints, access privileges and other grants that the table
has. To create and use the table again in its original form, all these relations, checks, constraints, privileges and
relationships need to be redefined. However, if a table is truncated, none of the above problems exist and the table
retains its original structure.

## Difference between DELETE and TRUNCATE statements
The TRUNCATE command is used to delete all the rows from the table and free the space containing the table.
The DELETE command deletes only the rows from the table based on the condition given in the where clause or deletes all
the rows from the table if no condition is specified. But it does not free the space containing the table.