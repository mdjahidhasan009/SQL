# Normalization
Normalization is the process of normalizing redundancy and dependency by organizing fields and tables of a database. The
main aim of Normalizing is to add, delete or modify field that can be made in a single table.

# Types of normalization
## First Normal Form(1NF)
This should remove all the duplicate columns from the table. Creation of tables for the related data and identification 
of unique columns.

* Every column must have atomic (single value)
* To Remove duplicate columns from the same table
* Create separate tables for each group of related data and identify each row with a unique column

## Second Normal Form(2NF)
Meeting all requirements of first normal form. Placing the subsets of data in separate tables and creation of 
relationships between tables using primary keys.

Every non-prime attribute is fully functionally dependent on the primary key, i.e., every non-key attribute should be
dependent on the primary key in such a way that if any key element is deleted, then even the non_key element will still 
be saved in the database.

## Third Normal Form(3NF)
This should meet all requirements of 2NF. Removing the columns which are not dependent on primary key constraints.

Each non-prime attribute of a table is said to be non-transitively dependent on every key of the table.

## Fourth Normal Form(4NF)
Meeting all requirement of third normal form, and it should not have multivalued dependency.

# Denormalization
Denormalization is the inverse process of normalization, where the normalized schema is converted into a schema which has 
redundant information. The performance is improved by using redundancy and keeping the redundant data consistent. The 
reason for performing denormalization is the overheads produced in query processor by an over-normalized structure.


Sources:
* https://www.javatpoint.com/dbms-interview-questions