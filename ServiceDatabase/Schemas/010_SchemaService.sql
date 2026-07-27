-------------------------------------------------------------------------------------
-- Must use SP 'sp_executesql' because 
-- 'CREATE SCHEMA' must be the first statement in a query batch. (bummer!)
-------------------------------------------------------------------------------------
IF NOT EXISTS(SELECT schema_id FROM sys.schemas WHERE name='Service') BEGIN
	EXEC sp_executesql N'CREATE SCHEMA Service'
END

select * from sys.schemas order by [name]