| Argument            | Description                         |
|---------------------|-------------------------------------|
| function_name       | the name of function                |
| list_of_paramenters | parameters that function accepts    |
| return_data_type    | type that function returs.          |
| function_body       | the code of function                |
| scalar_expression   | scalar value returned by function   |

## Create a new Function
```sql
CREATE FUNCTION FirstWord (@input varchar(1000))
RETURNS varchar(1000)
AS
BEGIN
    DECLARE @output varchar(1000)
    SET @output = SUBSTRING(@input, 0, CASE CHARINDEX(' ', @input)
        WHEN 0 THEN LEN(@input) + 1
        ELSE CHARINDEX(' ', @input)
    END)
    RETURN @output
END
```

This example creates a function named FirstWord, that accepts a varchar parameter and returns another varchar
value.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)
