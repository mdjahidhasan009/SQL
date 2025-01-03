# Relational Schema

> A Relational Schema is the blueprint or structure of a relational database. It defines the organization of data in
> tables and the relationships between them

An example of relational schema between tables `customers`, `orders`, `orders_items`, and `items` is shown below:

```shell
+---------------------+          +---------------------+
|      customers      |          |       orders        |
+---------------------+          +---------------------+
| customer_id (PK)    |----      | order_id (PK)       |----
| customer_phone      |   |      | order_date          |   |
| customer_email      |   |----->| customer_id (FK)    |   | 
+---------------------+          +---------------------+   v
                           ----------------<---------------|
                           |                                
                           |
                           |
+---------------------+    |         +---------------------+
|    orders_items     |    |         |       items         |
+---------------------+    v         +---------------------+
| order_id (FK)       |<----    |--->| item_id (PK)        |
| item_id (FK)        |----------    | item_name           |
| item_quantity       |              | item_price          |
+---------------------+              +---------------------+

```


# References
- [Database for Software Developers - ostad](https://ostad.app/course/database-for-developer)
