/*---------------------------------------------------------------------------------------------------------------------
Inserts a new JobScheduleType table if it does not exist.
Create Date: 2026.10.22
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/

-- Create the table JobScheduleTypes
IF ( Base.TableExists('Service','JobScheduleTypes')=0 ) BEGIN
	CREATE TABLE [Service].[JobScheduleTypes]
	(
		[JobScheduleTypeId] INT IDENTITY(1,1) NOT NULL
	)
END

-- Create PK column JobScheduleTypeId
IF ( Base.ColumnExists('Service','JobScheduleTypes','JobScheduleTypeId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [JobScheduleTypeId] INT IDENTITY(1,1) NOT NULL
END
-- Create primary key column
IF ( Base.PrimaryKeyExists('Service','JobScheduleTypes','PKEY_Service_JobScheduleTypes')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT PKEY_Service_JobScheduleTypes PRIMARY KEY NONCLUSTERED 
	(
		[JobScheduleTypeId] ASC
	) ON [PRIMARY]
END

-- Create column [CreateDate]
IF ( Base.ColumnExists('Service','JobScheduleTypes','CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [CreateDate] DATETIME NOT NULL
END
-- Create [CreateDate] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','CreateDate','DFLT_Service_JobScheduleTypes_CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Service_JobScheduleTypes_CreateDate DEFAULT (GETDATE()) FOR [CreateDate]
END

-- Create column [CreateUserId]
IF ( Base.ColumnExists('Service','JobScheduleTypes','CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [CreateUserId] INT NOT NULL
END

-- Create column [UpdateDate]
IF ( Base.ColumnExists('Service','JobScheduleTypes','UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [UpdateDate] DATETIME NOT NULL
END
-- Create [UpdateDate] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','UpdateDate','DFLT_Service_JobScheduleTypes_UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Service_JobScheduleTypes_UpdateDate DEFAULT (GETDATE()) FOR [UpdateDate]
END

-- Create column [UpdateUserId]
IF ( Base.ColumnExists('Service','JobScheduleTypes','UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [UpdateUserId] INT NOT NULL
END

-- Create column [RecordComment]
IF ( Base.ColumnExists('Service','JobScheduleTypes','RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [RecordComment] VARCHAR(1000) NOT NULL
END
-- Create [RecordComment] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','RecordComment','DFLT_Service_JobScheduleTypes_RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Service_JobScheduleTypes_RecordComment DEFAULT ('') FOR [RecordComment]
END

-- Create column [Active]
IF ( Base.ColumnExists('Service','JobScheduleTypes','Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [Active] BIT NOT NULL
END
-- Create [Active] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','Active','DFLT_Service_JobScheduleTypes_Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Service_JobScheduleTypes_Active DEFAULT (1) FOR [Active]
END

-- Create column [JobScheduleTypeName]
IF ( Base.ColumnExists('Service','JobScheduleTypes','JobScheduleTypeName')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [JobScheduleTypeName] VARCHAR(100) NOT NULL
END

-- Create column [Description]
IF ( Base.ColumnExists('Service','JobScheduleTypes','Description')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [Description] VARCHAR(1000) NOT NULL
END
-- Create [Description] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','Description','DFLT_Service_JobScheduleTypes_Description')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Service_JobScheduleTypes_Description DEFAULT ('') FOR [Description]
END

-- Create column [InstanceDescription]
IF ( Base.ColumnExists('Service','JobScheduleTypes','InstanceDescription')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [InstanceDescription] VARCHAR(1000) NOT NULL
END
-- Create [InstanceDescription] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','InstanceDescription','DFLT_Service_JobScheduleTypes_InstanceDescription')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Service_JobScheduleTypes_InstanceDescription DEFAULT ('') FOR [InstanceDescription]
END

-- Create column [Note]
IF ( Base.ColumnExists('Service','JobScheduleTypes','Note')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [Note] VARCHAR(1000) NOT NULL
END
-- Create [Note] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','Note','DFLT_Service_JobScheduleTypes_Note')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Service_JobScheduleTypes_Note DEFAULT ('') FOR [Note]
END


-- Create unique constraint for a column [JobScheduleTypeName]
IF (Base.UniqueConstraintExists('Service','JobScheduleTypes','UNQ_Service_JobScheduleTypes_JobScheduleTypeName') = 1) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] DROP CONSTRAINT UNQ_Service_JobScheduleTypes_JobScheduleTypeName
END
IF (SELECT TOP 1 [JobScheduleTypeName] FROM [Service].[JobScheduleTypes] GROUP BY JobScheduleTypeName HAVING COUNT([JobScheduleTypeName]) > 1) IS NULL BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT UNQ_Service_JobScheduleTypes_JobScheduleTypeName UNIQUE ([JobScheduleTypeName])
END
ELSE BEGIN
	RAISERROR ('Cannot create the Unique Constraint for column [JobScheduleTypeName].  The column contains non-unique values.',11,1) 
END



select * from [Service].[JobScheduleTypes]
