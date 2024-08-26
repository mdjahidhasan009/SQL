# Identifier
Syntax rules for names of tables, columns, and other database objects.

Where appropriate, the examples should cover variations used by diﬀerent SQL implementations, or identify the SQL 
implementation of the example.

## Unquoted Identifier
Unquoted identiﬁers can use letters (a-z), digits (0-9), and underscore (_), and must start with a letter.
Depending on SQL implementation, and/or database settings, other characters may be allowed, some even as the ﬁrst character, e.g.

* MS SQL: @, $, #, and other Unicode letters
* MySQL: $ 
* Oracle: $, #, and other letters from database character set
* PostgreSQL: $, and other Unicode letters

Unquoted identiﬁers are case-insensitive. How this is handled depends greatly on SQL implementation:
* MS SQL: Case-preserving, sensitivity deﬁned by database character set, so can be case-sensitive.
* MySQL: Case-preserving, sensitivity depends on database setting and underlying ﬁle system.
* Oracle: Converted to uppercase, then handled like quoted identiﬁer.
* PostgreSQL: Converted to lowercase, then handled like quoted identiﬁer.
* SQLite: Case-preserving; case insensitivity only for ASCII characters.

Sources:
* [SQL Notes for Professionals](https://goalkicker.com/SQLBook)