# Index
An index is performance tuning method of allowing faster retrieval of records from table at the cost of additional writes
and the use of more storage space to maintain the extra copy of data. An index creates an entry for
each value and it will be faster to retrieve data. This indexing does not allow the field to have duplicate values if 
the column is unique indexed. Unique index can be applied automatically when primary key is defined. These
indexes need extra space on disk, but they allow faster search according
to different frequently searched values.

### Clustered Index
This type of index records the physical order of the table and search based on key values. Each table can have only one
clustered index.

### Non-Clustered Index
Non-Clustered Index does not alter the physical order of the table and maintains logical order of data. Each table can
have 999 non-clustered indexes.