# Trigger
Trigger allows us to execute a batch of SQL code when a table event occurs(Insert, update or delete command executed
against a specific table)

## Nested Triggers
Triggers may implement data modification logic by using INSERT, UPDATE and DELETE statement, we can add trigger before
or after those statements. These triggers that contain data modification logic and find other triggers for data 
modification are called Nested Triggers.

Example on MySQL: <br/>
Here `datetime` is a column in the `location` table, and we want to set the value of `datetime` to the current time
when a new row is inserted into the `location` table.
```sql
DROP TRIGGER IF EXITS tr_ins_location;

CREATE TRIGGER tr_ins_location
BEFORE INSERT ON `location`
FOR EACH ROW
SET NEW.datetime = NOW();
```

## Sources:
- [MySQL Interview Questions and Answers | MySQL Interview Preparation | Freshers & Experienced](https://www.youtube.com/watch?v=9hfjC-BpY20)