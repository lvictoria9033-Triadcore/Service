-------------------------------------------------------------------------------------
-- Ensure the 'Base' schema exists.
-- Must use SP 'sp_executesql' because 
-- 'CREATE SCHEMA' must be the first statement in a query batch. (bummer!)
-------------------------------------------------------------------------------------
IF NOT EXISTS(SELECT schema_id FROM sys.schemas WHERE name='Base') BEGIN
	RAISERROR('Cannot create the Service database components. The schema [Base] was not found. The schema [Base] is a prerequisite.',10,1)
END
