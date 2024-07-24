## EXISTS CLAUSE
Customer Table

| Id | FirstName | LastName |
|----|-----------|----------|
| 1  | Ozgur     | Ozturk   |
| 2  | Youssef   | Medi     |
| 3  | Henry     | Tai      |

Order Table

| Id  | CustomerId | Amount  |
|-----|------------|---------|
| 1   | 2          | 123.50  |
| 2   | 3          | 14.80   |

Get all customers with a least one order
```sql
SELECT * FROM Customer WHERE EXITS (
    SELECT * FROM order WHERE Order.CustomerId = Customer.Id    
)
```
Result

| Id  | FirstName | LastName |
|-----|-----------|----------|
| 2   | Youssef   | Medi     |
| 3   | Henry     | Tai      |

Get all customers with no order
```sql
SELECT * FROM Customer WHERE NOT EXITS (
    SELECT * FROM Order WHERE Order.CustomerId = Customer.Id
)
```
Result

| Id | FirstName | LastName |
|----|-----------|----------|
| 1  | Ozgur     | Ozturk   |

Purpose

EXISTS, IN and JOIN could sometime be used for the same result, however, they are not equals :
* EXISTS should be used to check if a value exist in another table
* IN should be used for static list
* JOIN should be used to retrieve data from other(s) table(s)

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)