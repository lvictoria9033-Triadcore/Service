/***************************************************************************************************************************************************************
Purpose: Maintains a list of process jobs.
Author : Leonard Victoria
Company: Triadcore Design, LLC.
History:
		2018.06.30 - Created.
***************************************************************************************************************************************************************/

-- Create the table Jobs
IF ( Base.TableExists('Service','Jobs')=0 ) BEGIN
	CREATE TABLE [Service].[Jobs]
	(
		JobId INT IDENTITY(1,1) NOT NULL
	)
END

-- Create column JobId
IF ( Base.ColumnExists('Service','Jobs','JobId')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD JobId INT IDENTITY(1,1) NOT NULL
END
-- Create primary key column
IF ( Base.PrimaryKeyExists('Service','Jobs','PKEY_Service_Jobs')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT PKEY_Service_Jobs PRIMARY KEY CLUSTERED 
	(
		[JobId] ASC
	) ON [PRIMARY]
END

-- JobName
IF ( Base.ColumnExists('Service','Jobs','JobName')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD JobName VARCHAR(50) NOT NULL
END

-- JobFriendlyName
IF ( Base.ColumnExists('Service','Jobs','JobFriendlyName')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD JobFriendlyName VARCHAR(100) NOT NULL
END
-- Create JobFriendlyName default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','JobFriendlyName','DFLT_Service_Jobs_JobFriendlyName')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_JobFriendlyName DEFAULT ('') FOR [JobFriendlyName]
END

-- Description
IF ( Base.ColumnExists('Service','Jobs','Description')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [Description] VARCHAR(200) NOT NULL
END
-- Create Status Reason default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','Description','DFLT_Service_Jobs_Description')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_Description DEFAULT ('') FOR [Description]
END

-- ExecPath
IF ( Base.ColumnExists('Service','Jobs','ExecPath')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [ExecPath] VARCHAR(2000) NOT NULL
END

-- ExecFile
IF ( Base.ColumnExists('Service','Jobs','ExecFile')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [ExecFile] VARCHAR(200) NOT NULL
END

-- ParamString -- added 2018.07.??
IF ( Base.ColumnExists('Service','Jobs','ParamString')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [ParamString] VARCHAR(1000) NULL  -- column added at a later date, set nullable
END
-- Create ParamString default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','ParamString','DFLT_Service_Jobs_ParamString')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_ParamString DEFAULT ('') FOR [ParamString]
END

-- Create unique constraint for column JobName
IF ( Base.UniqueConstraintExists('Service','Jobs','UNQ_Service_Jobs')=0) BEGIN
	-- Ensure that there are no duplicates before creating the unique constraint
	IF (SELECT COUNT(JobId) FROM [Service].Jobs GROUP BY JobName HAVING COUNT(JobId)>1) IS NULL BEGIN
		ALTER TABLE [Service].[Jobs] ADD CONSTRAINT UNQ_Service_Jobs UNIQUE (JobName, ExecFile, ParamString)
	END
	ELSE BEGIN
		RAISERROR ('Cannot create the Unique Constraint for the column [Service].[JobName], [Service].[ExecFile], and [Service].[ParamString].  The column combination contains non-unique values.',11,1) 
	END
END

-- LogStarts
IF ( Base.ColumnExists('Service','Jobs','LogStarts')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [LogStarts] BIT NOT NULL
END
-- Create Status Reason default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','LogStarts','DFLT_Service_Jobs_LogStarts')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_LogStarts DEFAULT (1) FOR [LogStarts]
END

-- LogFinishes
IF ( Base.ColumnExists('Service','Jobs','LogFinishes')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [LogFinishes] BIT NOT NULL
END
-- Create Status Reason default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','LogFinishes','DFLT_Service_Jobs_LogFinishes')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_LogFinishes DEFAULT (1) FOR [LogFinishes]
END

-- Active
IF ( Base.ColumnExists('Service','Jobs','Active')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [Active] BIT NOT NULL
END
-- Create Status Reason default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','Active','DFLT_Service_Jobs_Active')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_Active DEFAULT (1) FOR [Active]
END

-- SortText
IF ( Base.ColumnExists('Service','Jobs','SortText')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD [SortText] VARCHAR(50) NOT NULL
END
-- Create Sort Text default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','SortText','DFLT_Service_Jobs_SortText')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_SortText DEFAULT ('') FOR [SortText]
END

-- Create column UpdateDate
IF ( Base.ColumnExists('Service','Jobs','UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD UpdateDate DATETIME NOT NULL
END
-- Create UpdateDate default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','UpdateDate','DFLT_Service_Jobs_UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_UpdateDate DEFAULT (GetDate()) FOR [UpdateDate]
END

-- Create column UpdateUserId
IF ( Base.ColumnExists('Service','Jobs','UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD UpdateUserId INT NOT NULL
END
-- Create UpdateUserId default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','UpdateUserId','DFLT_Service_Jobs_UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_UpdateUserId DEFAULT (0) FOR [UpdateUserId]
END

-- Create column CreateDate
IF ( Base.ColumnExists('Service','Jobs','CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CreateDate DATETIME NOT NULL
END
-- Create CreateDate default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','CreateDate','DFLT_Service_Jobs_CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_CreateDate DEFAULT (GetDate()) FOR [CreateDate]
END

-- Create column CreateUserId
IF ( Base.ColumnExists('Service','Jobs','CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CreateUserId INT NOT NULL
END
-- Create CreateUserId default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','CreateUserId','DFLT_Service_Jobs_CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_CreateUserId DEFAULT (0) FOR [CreateUserId]
END

-- Create column RecordComment
IF ( Base.ColumnExists('Service','Jobs','RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD RecordComment VARCHAR(1000) NOT NULL
END
-- Create RecordComment default constraint
IF ( Base.ColumnDefaultExists('Service','Jobs','RecordComment','DFLT_Service_Jobs_RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[Jobs] ADD CONSTRAINT DFLT_Service_Jobs_RecordComment DEFAULT ('') FOR [RecordComment]
END

select * from [Service].[Jobs]