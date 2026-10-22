/*---------------------------------------------------------------------------------------------------------------------
Must use SP 'sp_executesql' because 'CREATE SCHEMA' must be the first statement in a query batch. (bummer!)
Create Date: 2026.10.22
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
IF NOT EXISTS(SELECT schema_id FROM sys.schemas WHERE name='Service') BEGIN
	EXEC sp_executesql N'CREATE SCHEMA Service'
END

select * from sys.schemas
