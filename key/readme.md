# KEY

## Candidate Key
The candidate key represents a set of properties that can uniquely identify a table. Each table may have multiple 
candidate keys. One key amongst all candidate keys can be chosen as a primary key. In the below example since studentId
and firstName can be considered as a Candidate Key since they can uniquely identify every tuple.

## Super Key
The super key defines a set of attributes that can uniquely identify a tuple. Candidate key and primary key are subsets
of the super key, in other words, the super key is their superset.

## Primary Key
The primary key defines a set of attributes that are used to uniquely identify every tuple. In the below example 
studentId and firstName are candidate keys and any one of them can be chosen as a Primary Key. In the given example 
studentId is chosen as the primary key for the student table.

## Unique Key
The unique key is very similar to the primary key except that primary keys don’t allow NULL values in the column but 
unique keys allow them. So essentially unique keys are primary keys with NULL values.

## Alternate Key
All the candidate keys which are not chosen as primary keys are considered as alternate Keys. In the below example,
firstname and lastname are alternate keys in the database.

## Foreign Key
The foreign key defines an attribute that can only take the values present in one table common to the attribute present
in another table. In the below example courseId from the Student table is a foreign key to the Course table, as both, 
the tables contain courseId as one of their attributes.

## Composite Key
A composite key refers to a combination of two or more columns that can uniquely identify each tuple in a table. In the 
below example the studentId and firstname can be grouped to uniquely identify every tuple in the table.


### Primary Key VS Unique Key
* We can have only one primary key in a table whereas we can have more than one unique key in a table.
* Primary key cannot have NULL value whereas a Unique key may have only one null value.
* By default, a primary key is a Clustered Index whereas by default, a Unique key is a unique non-clustered index.
* A primary key supports an auto increment value whereas a unique key doesn't support auto increment value.

### Composite Primary Key
A Composite primary key is a set of columns whose values uniquely identify every row in a table. What it means is that,
table which contains composite primary key will be indexed based on columns specified in the primary key. This key will
be referred in Foreign Key tables.

Source:
* https://www.interviewbit.com/dbms-interview-questions/