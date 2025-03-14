# SQL View
A view is a virtual table whose contents are obtained from an existing table or tables using a query, called base tables.

The retrieval happens through an SQL statement, incorporated into the view. So, you can think of a view object as a view 
into the base table. The view itself does not contain a real data, the data is electronically stored in the base table.
The view simply shows the data contained in the base table. If the data at the base table changes, the view will reflect
those changes. Views are used to simplify complex queries by abstracting the underlying table structure and restricting
access to the data. They can also be used to secure data by only allowing certain users to see specific columns of a 
table.

## Creating a view
**MySQL Example**
```sql
CREATE VIEW `propertylist` AS
SELECT P.listingid, P.propertyName, L.location 
FROM `propertylisting` AS P
INNER JOIN `location` AS L
ON P.locationid = L.id;
```

**Output**
```
Query OK, 0 rows affected
```

## Querying a view
**MySQL Example**
```sql
SELECT * FROM `propertylist`;
```

**Output**
```
listingid | propertyName | location
-----------------------------------
1         | House 1      | Location 1
2         | House 2      | Location 2
3         | House 3      | Location 3
```

## Updating a view
Views can be updated in MySQL by using the `CREATE OR REPLACE VIEW` statement. This will replace the existing view with the new definition.
```sql
CREATE OR REPLACE VIEW `propertylist` AS
SELECT P.listingid, P.propertyName, L.location
FROM `propertylisting` AS P
INNER JOIN `location` AS L
ON P.locationid = L.id
WHERE P.listingid < 3;
```

**Output**
```
Query OK, 0 rows affected
```

## Dropping a view
**MySQL Example**
```sql
DROP VIEW `propertylist`;
```