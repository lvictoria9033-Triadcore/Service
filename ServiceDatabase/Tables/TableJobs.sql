/*---------------------------------------------------------------------------------------------------------------------
Inserts a new Job table if it does not exist.
Create Date: 2026.07.28
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/

-- Create the table Jobs
IF ( Base.TableExists('Service','Jobs')=0 ) BEGIN
	CREATE TABLE [Service].[Jobs]
	(
		[JobId] INT IDENTITY(1,1) NOT NULL
	)
END

-- Create PK column JobId
IF ( Base.ColumnExists('Service','Jobs','JobId')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [JobId] INT IDENTITY(1,1) NOT NULL
END
-- Create primary key column
IF ( Base.PrimaryKeyExists('Service','Jobs','PKEY_Service_Jobs')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT PKEY_Service_Jobs PRIMARY KEY NONCLUSTERED 
	(
		[JobId] ASC
	) ON [PRIMARY]
END

-- Create column RecordComment
IF ( Base.ColumnExists('Service','Jobs','RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [RecordComment] VARCHAR(1000) NOT NULL
END
-- Create RecordComment default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','RecordComment','DFLT_Service_Jobs_RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_RecordComment DEFAULT ('') FOR [RecordComment]
END

-- Create column UpdateDate
IF ( Base.ColumnExists('Service','Jobs','UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [UpdateDate] DATETIME NOT NULL
END
-- Create UpdateDate default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','UpdateDate','DFLT_Service_Jobs_UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_UpdateDate DEFAULT (GETDATE()) FOR [UpdateDate]
END

-- Create column UpdateUserId
IF ( Base.ColumnExists('Service','Jobs','UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [UpdateUserId] INT NOT NULL
END

-- Create column CreateDate
IF ( Base.ColumnExists('Service','Jobs','CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [CreateDate] DATETIME NOT NULL
END
-- Create CreateDate default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','CreateDate','DFLT_Service_Jobs_CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_CreateDate DEFAULT (GETDATE()) FOR [CreateDate]
END

-- Create column CreateUserId
IF ( Base.ColumnExists('Service','Jobs','CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [CreateUserId] INT NOT NULL
END

-- Create column Active
IF ( Base.ColumnExists('Service','Jobs','Active')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [Active] BIT NOT NULL
END
-- Create Active default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','Active','DFLT_Service_Jobs_Active')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_Active DEFAULT (1) FOR [Active]
END

-- Create column SortText
IF ( Base.ColumnExists('Service','Jobs','SortText')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [SortText] VARCHAR(100) NOT NULL
END
-- Create SortText default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','SortText','DFLT_Service_Jobs_SortText')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_SortText DEFAULT ('') FOR [SortText]
END

-- Create column JobName
IF ( Base.ColumnExists('Service','Jobs','JobName')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [JobName] VARCHAR(50) NOT NULL
END

-- Create column JobFriendlyName
IF ( Base.ColumnExists('Service','Jobs','JobFriendlyName')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [JobFriendlyName] VARCHAR(100) NOT NULL
END
-- Create JobFriendlyName default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','JobFriendlyName','DFLT_Service_Jobs_JobFriendlyName')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_JobFriendlyName DEFAULT ('') FOR [JobFriendlyName]
END

-- Create column Description
IF ( Base.ColumnExists('Service','Jobs','Description')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [Description] VARCHAR(200) NOT NULL
END
-- Create Description default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','Description','DFLT_Service_Jobs_Description')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_Description DEFAULT ('') FOR [Description]
END

-- Create column ExecPath
IF ( Base.ColumnExists('Service','Jobs','ExecPath')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [ExecPath] VARCHAR(2000) NOT NULL
END

-- Create column ExecFile
IF ( Base.ColumnExists('Service','Jobs','ExecFile')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [ExecFile] VARCHAR(200) NOT NULL
END

-- Create column ParamString
IF ( Base.ColumnExists('Service','Jobs','ParamString')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [ParamString] VARCHAR(1000) NOT NULL
END
-- Create ParamString default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','ParamString','DFLT_Service_Jobs_ParamString')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_ParamString DEFAULT ('') FOR [ParamString]
END

-- Create column LogStarts
IF ( Base.ColumnExists('Service','Jobs','LogStarts')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [LogStarts] BIT NOT NULL
END
-- Create LogStarts default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','LogStarts','DFLT_Service_Jobs_LogStarts')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_LogStarts DEFAULT (0) FOR [LogStarts]
END

-- Create column LogFinishes
IF ( Base.ColumnExists('Service','Jobs','LogFinishes')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [LogFinishes] BIT NOT NULL
END
-- Create LogFinishes default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','LogFinishes','DFLT_Service_Jobs_LogFinishes')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_LogFinishes DEFAULT (0) FOR [LogFinishes]
END


-- Create unique constraint for a single column
IF (Base.UniqueConstraintExists('Service','Jobs','UNQ_Service_Jobs_JobName')=1) BEGIN
	ALTER TABLE [Service].[Jobs] DROP CONSTRAINT UNQ_Service_Jobs_JobName
END
IF (SELECT TOP 1 [JobName] FROM [Service].[Jobs] GROUP BY JobName HAVING COUNT([JobName])>1) IS NULL BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT UNQ_Service_Jobs_JobName UNIQUE ([JobName])
END
ELSE BEGIN
	RAISERROR ('Cannot create the Unique Constraint for column [JobName].  The column contains non-unique values.',11,1) 
END



select * from [Service].[Jobs]
