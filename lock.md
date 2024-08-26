# Lock Escalation
Lock escalation is the process of converting a lot of low level locks (like row locks, page locks) into higher level 
locks (like table locks). Every lock is a memory structure too many locks would mean, more memory being occupied by 
locks. To prevent this from happening, SQL Server escalates the many fine-grain locks to fewer coarse-grain locks. Lock
escalation threshold was definable in SQL Server 6.5, but from SQL Server 7.0 onwards it's dynamically managed by SQL 
Server.