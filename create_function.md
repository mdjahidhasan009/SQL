| Argument            | Description                         |
|---------------------|-------------------------------------|
| function_name       | the name of function                |
| list_of_paramenters | parameters that function accepts    |
| return_data_type    | type that function returs.          |
| function_body       | the code of function                |
| scalar_expression   | scalar value returned by function   |

## Create a new Function
General form of creating a function is:
**MySQL**

```sql
-- list_of_parameters is optional
--list_of_parameters will be like function_name(param1 datatype, param2 datatype, ...)
CREATE FUNCTION function_name(list_of_parameters) 
RETURNS return_data_type
DETERMINISTIC
BEGIN
    -- function_body
    -- scalar_expression
    RETURN scalar_expression;
END;
```

**SQL Server**

```sql
CREATE FUNCTION function_name(list_of_parameters)
RETURNS return_data_type
AS
BEGIN
    -- function_body
    -- scalar_expression
    RETURN scalar_expression;
END;
```

### Example
**MySQL**
```sql
DELIMITER //

CREATE FUNCTION FirstWord(input VARCHAR(1000))
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN
    DECLARE output VARCHAR(1000);
    SET output = SUBSTRING(input, 1, 
        CASE WHEN LOCATE(' ', input) = 0 
             THEN LENGTH(input) 
             ELSE LOCATE(' ', input) - 1 
        END);
    RETURN output;
END //

DELIMITER ;
```

**SQL Server**
```sql
CREATE FUNCTION FirstWord (@input VARCHAR(1000))
RETURNS VARCHAR(1000)
AS
BEGIN
    DECLARE @output VARCHAR(1000);
    SET @output = SUBSTRING(@input, 1, CASE CHARINDEX(' ', @input)
        WHEN 0 THEN LEN(@input)
        ELSE CHARINDEX(' ', @input) - 1
    END);
    RETURN @output;
END;

```

This example creates a function named FirstWord, that accepts a varchar parameter and returns another varchar
value.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)
