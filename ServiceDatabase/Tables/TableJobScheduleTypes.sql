-- Create the table JobScheduleTypes
IF ( Base.TableExists('Service','JobScheduleTypes')=0 ) BEGIN
	CREATE TABLE [Service].[JobScheduleTypes]
	(
		JobScheduleTypeId INT IDENTITY(1,1) NOT NULL
	)
END

-- Create column JobScheduleTypeId
IF ( Base.ColumnExists('Service','JobScheduleTypes','JobScheduleTypeId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD JobScheduleTypeId INT IDENTITY(1,1)
END
-- Create primary key column
IF ( Base.PrimaryKeyExists('Service','JobScheduleTypes','PKEY_Job_JobScheduleTypes')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT PKEY_Job_JobScheduleTypes PRIMARY KEY NONCLUSTERED 
	(
		[JobScheduleTypeId] ASC
	) ON [PRIMARY]
END

-- Create column JobScheduleTypeName
IF ( Base.ColumnExists('Service','JobScheduleTypes','JobScheduleTypeName')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [JobScheduleTypeName] VARCHAR(100) NOT NULL
END

-- Create column Description
IF ( Base.ColumnExists('Service','JobScheduleTypes','Description')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [Description] VARCHAR(1000) NOT NULL
END
-- Create Description default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','Description','DFLT_Job_JobScheduleTypes_Description')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Job_JobScheduleTypes_Description DEFAULT ('') FOR [Description]
END

-- Create unique constraint for combinded columns Interval, Date, Day, and Time
IF ( Base.UniqueConstraintExists('Service','JobScheduleTypes','UNQ_Service_JobScheduleTypes')=0) BEGIN
	-- Ensure that there are no duplicates (combined columns) before creating the unique constraint
	IF (SELECT COUNT(JobScheduleTypeId) FROM [Service].JobScheduleTypes GROUP BY [JobScheduleTypeName] HAVING COUNT(JobScheduleTypeId)>1) IS NULL BEGIN
		ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT UNQ_Service_JobScheduleTypes UNIQUE (JobScheduleTypeName)
	END
	ELSE BEGIN
		RAISERROR ('Cannot create the Unique Constraint UNQ_Service_JobScheduleTypes for the combined columns [JobScheduleTypes].[JobScheduleTypeName].  The column combination contains non-unique values.',11,1) 
	END
END

-- Create column InstanceDescription
IF ( Base.ColumnExists('Service','JobScheduleTypes','InstanceDescription')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD [InstanceDescription] VARCHAR(1000) NOT NULL
END
-- Create InstanceDescription default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','InstanceDescription','DFLT_Job_JobScheduleTypes_InstanceDescription')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Job_JobScheduleTypes_InstanceDescription DEFAULT ('') FOR [InstanceDescription]
END

-- Create column Note
IF ( Base.ColumnExists('Service','JobScheduleTypes','Note')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD Note VARCHAR(1000) NOT NULL
END
-- Create Note default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','Note','DFLT_Job_JobScheduleTypes_Note')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Job_JobScheduleTypes_Note DEFAULT ('') FOR [Note]
END

-- Create column Active
IF ( Base.ColumnExists('Service','JobScheduleTypes','Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD Active BIT NOT NULL
END
-- Create Active default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','Active','DFLT_Job_JobScheduleTypes_Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Job_JobScheduleTypes_Active DEFAULT (1) FOR [Active]
END

-- Create column UpdateDate
IF ( Base.ColumnExists('Service','JobScheduleTypes','UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD UpdateDate DATETIME NOT NULL
END
-- Create UpdateDate default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','UpdateDate','DFLT_Job_JobScheduleTypes_UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Job_JobScheduleTypes_UpdateDate DEFAULT (GetDate()) FOR [UpdateDate]
END

-- Create column UpdateUserId
IF ( Base.ColumnExists('Service','JobScheduleTypes','UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD UpdateUserId INT NOT NULL
END
-- Create UpdateUserId default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','UpdateUserId','DFLT_Job_JobScheduleTypes_UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Job_JobScheduleTypes_UpdateUserId DEFAULT (0) FOR [UpdateUserId]
END

-- Create column CreateDate
IF ( Base.ColumnExists('Service','JobScheduleTypes','CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CreateDate DATETIME NOT NULL
END
-- Create CreateDate default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','CreateDate','DFLT_Job_JobScheduleTypes_CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Job_JobScheduleTypes_CreateDate DEFAULT (GetDate()) FOR [CreateDate]
END

-- Create column CreateUserId
IF ( Base.ColumnExists('Service','JobScheduleTypes','CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CreateUserId INT NOT NULL
END
-- Create CreateUserId default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','CreateUserId','DFLT_Job_JobScheduleTypes_CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Job_JobScheduleTypes_CreateUserId DEFAULT (0) FOR [CreateUserId]
END

-- Create column RecordComment
IF ( Base.ColumnExists('Service','JobScheduleTypes','RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD RecordComment VARCHAR(1000) NOT NULL
END
-- Create RecordComment default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','RecordComment','DFLT_Job_JobScheduleTypes_RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] ADD CONSTRAINT DFLT_Job_JobScheduleTypes_RecordComment DEFAULT ('') FOR [RecordComment]
END

select * from [Service].JobScheduleTypes order by JobScheduleTypeName