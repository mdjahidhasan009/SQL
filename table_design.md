## Properties of a well designed table
A true relational database must go beyond throwing data into a few tables and writing some SQL statements to pull
that data out.

At best a badly designed table structure will slow the execution of queries and could make it impossible for the
database to function as intended.


A database table should not be considered as just another table; it has to follow a set of rules to be considered truly
relational. Academically it is referred to as a 'relation' to make the distinction.

The ﬁve rules of a relational table are:
1. Each value is atomic; the value in each ﬁeld in each row must be a single value.
2. Each ﬁeld contains values that are of the same data type.
3. Each ﬁeld heading has a unique name.
4. Each row in the table must have at least one value that makes it unique amongst the other records in the
   table.
5. The order of the rows and columns has no signiﬁcance.

A table conforming to the ﬁve rules:

| Id  | Name  | DOB          | Manager |
|-----|-------|--------------|---------|
| 1   | Fred  | 11/02/1971   | 3       |
| 2   | Fred  | 11/02/1971   | 3       |
| 3   | Sue   | 08/07/1975   | 2       |

* Rule 1: Each value is atomic. Id, Name, DOB and Manager only contain a single value.
* Rule 2: Id contains only integers, Name contains text (we could add that it's text of four characters or less), DOB
  contains dates of a valid type and Manager contains integers (we could add that corresponds to a Primary Key
  ﬁeld in a managers table).
* Rule 3: Id, Name, DOB and Manager are unique heading names within the table.
* Rule 4: The inclusion of the Id ﬁeld ensures that each record is distinct from any other record within the
table

A badly designed table:

| Id | Name | DOB                        | Name  |
|----|------|----------------------------|-------|
| 1  | Fred | 11/02/1971                 | 3     |
| 1  | Fred | 11/02/1971                 | 3     |
| 3  | Sue  | Friday the 18th July 1975  | 2, 1  |

* Rule 1: The second name ﬁeld contains two values - 2 and 1.
* Rule 2: The DOB ﬁeld contains dates and text.
* Rule 3: There's two ﬁelds called 'name'.
* Rule 4: The ﬁrst and second record are exactly the same.
* Rule 5: This rule isn't broken.



Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)