## AND OR Example
Have a table

| Name | Age | City   |
|------|-----|--------|
| Bob  | 10  | Paris  |
| Mat  | 20  | Berlin |
| Mary | 24  | Prague |

```sql
select Name from table where Age>10 AND City='Prague'
```
Gives

| Name |
|------|
| Mary |


```sql
select Name from table where Age=10 OR City='Prague'
```
Gives

| Name |
|------|
| Bob  |
| Mary |

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)