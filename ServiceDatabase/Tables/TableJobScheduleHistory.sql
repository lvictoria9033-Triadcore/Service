-- Create the table JobScheduleHistory
IF ( Base.TableExists('Service','JobScheduleHistory')=0 ) BEGIN
	CREATE TABLE [Service].[JobScheduleHistory]
	(
		JobScheduleHistoryId INT IDENTITY(1,1) NOT NULL
	)
END

-- Create column JobScheduleHistoryId
IF ( Base.ColumnExists('Service','JobScheduleHistory','JobScheduleHistoryId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD JobScheduleHistoryId INT IDENTITY(1,1)
END
-- Create primary key column
IF ( Base.PrimaryKeyExists('Service','JobScheduleHistory','PKEY_Job_JobScheduleHistory')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD CONSTRAINT PKEY_Job_JobScheduleHistory PRIMARY KEY NONCLUSTERED 
	(
		[JobScheduleHistoryId] ASC
	) ON [PRIMARY]
END

-- Create column JobScheduleId
IF ( Base.ColumnExists('Service','JobScheduleHistory','JobScheduleId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD [JobScheduleId] INT NOT NULL
END

-- Create column ExecuteDateTimeStart
IF ( Base.ColumnExists('Service','JobScheduleHistory','ExecuteDateTimeStart')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD [ExecuteDateTimeStart] DATETIME NOT NULL
END

-- Create column ExecuteDateTimeEnd
IF ( Base.ColumnExists('Service','JobScheduleHistory','ExecuteDateTimeEnd')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD [ExecuteDateTimeEnd] DATETIME NULL
END

-- Create column ExecuteUserName
IF ( Base.ColumnExists('Service','JobScheduleHistory','ExecuteUserName')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD ExecuteUserName VARCHAR(100) NOT NULL
END

-- Create column ExecuteParams
IF ( Base.ColumnExists('Service','JobScheduleHistory','ExecuteParams')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD ExecuteParams VARCHAR(1000) NOT NULL
END

-- Create column ResultCode
IF ( Base.ColumnExists('Service','JobScheduleHistory','ResultCode')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD ResultCode INT NULL
END

-- Create column ResultText
IF ( Base.ColumnExists('Service','JobScheduleHistory','ResultText')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD ResultText VARCHAR(1000) NULL
END

-- Create column Note
IF ( Base.ColumnExists('Service','JobScheduleHistory','Note')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD Note VARCHAR(2000) NULL
END
-- Create Note default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistory','Note','DFLT_Job_JobScheduleHistory_Note')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD CONSTRAINT DFLT_Job_JobScheduleHistory_Note DEFAULT ('') FOR [Note]
END

-- Create column UpdateDate
IF ( Base.ColumnExists('Service','JobScheduleHistory','UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD UpdateDate DATETIME NOT NULL
END
-- Create UpdateDate default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistory','UpdateDate','DFLT_Job_JobScheduleHistory_UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD CONSTRAINT DFLT_Job_JobScheduleHistory_UpdateDate DEFAULT (GetDate()) FOR [UpdateDate]
END

-- Create column UpdateUserId
IF ( Base.ColumnExists('Service','JobScheduleHistory','UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD UpdateUserId INT NOT NULL
END
-- Create UpdateUserId default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistory','UpdateUserId','DFLT_Job_JobScheduleHistory_UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD CONSTRAINT DFLT_Job_JobScheduleHistory_UpdateUserId DEFAULT (0) FOR [UpdateUserId]
END

-- Create column CreateDate
IF ( Base.ColumnExists('Service','JobScheduleHistory','CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD CreateDate DATETIME NOT NULL
END
-- Create CreateDate default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistory','CreateDate','DFLT_Job_JobScheduleHistory_CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD CONSTRAINT DFLT_Job_JobScheduleHistory_CreateDate DEFAULT (GetDate()) FOR [CreateDate]
END

-- Create column CreateUserId
IF ( Base.ColumnExists('Service','JobScheduleHistory','CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD CreateUserId INT NOT NULL
END
-- Create CreateUserId default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistory','CreateUserId','DFLT_Job_JobScheduleHistory_CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD CONSTRAINT DFLT_Job_JobScheduleHistory_CreateUserId DEFAULT (0) FOR [CreateUserId]
END

-- Create column RecordComment
IF ( Base.ColumnExists('Service','JobScheduleHistory','RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD RecordComment VARCHAR(1000) NOT NULL
END
-- Create RecordComment default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistory','RecordComment','DFLT_Job_JobScheduleHistory_RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistory] ADD CONSTRAINT DFLT_Job_JobScheduleHistory_RecordComment DEFAULT ('') FOR [RecordComment]
END

select * from [Service].JobScheduleHistory order by CreateDate desc