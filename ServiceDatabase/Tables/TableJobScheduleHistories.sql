/*---------------------------------------------------------------------------------------------------------------------
Inserts a new JobScheduleHistory table if it does not exist.
Create Date: 2026.10.23
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/

-- Create the table JobScheduleHistories
IF ( Base.TableExists('Service','JobScheduleHistories')=0 ) BEGIN
	CREATE TABLE [Service].[JobScheduleHistories]
	(
		[JobScheduleHistoryId] INT IDENTITY(1,1) NOT NULL
	)
END

-- Create PK column JobScheduleHistoryId
IF ( Base.ColumnExists('Service','JobScheduleHistories','JobScheduleHistoryId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [JobScheduleHistoryId] INT IDENTITY(1,1) NOT NULL
END
-- Create primary key column
IF ( Base.PrimaryKeyExists('Service','JobScheduleHistories','PKEY_Service_JobScheduleHistories')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD CONSTRAINT PKEY_Service_JobScheduleHistories PRIMARY KEY NONCLUSTERED 
	(
		[JobScheduleHistoryId] ASC
	) ON [PRIMARY]
END

-- Create column [CreateDate]
IF ( Base.ColumnExists('Service','JobScheduleHistories','CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [CreateDate] DATETIME NOT NULL
END
-- Create [CreateDate] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','CreateDate','DFLT_Service_JobScheduleHistories_CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD CONSTRAINT DFLT_Service_JobScheduleHistories_CreateDate DEFAULT (GETDATE()) FOR [CreateDate]
END

-- Create column [CreateUserId]
IF ( Base.ColumnExists('Service','JobScheduleHistories','CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [CreateUserId] INT NOT NULL
END

-- Create column [UpdateDate]
IF ( Base.ColumnExists('Service','JobScheduleHistories','UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [UpdateDate] DATETIME NOT NULL
END
-- Create [UpdateDate] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','UpdateDate','DFLT_Service_JobScheduleHistories_UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD CONSTRAINT DFLT_Service_JobScheduleHistories_UpdateDate DEFAULT (GETDATE()) FOR [UpdateDate]
END

-- Create column [UpdateUserId]
IF ( Base.ColumnExists('Service','JobScheduleHistories','UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [UpdateUserId] INT NOT NULL
END

-- Create column [Active]
IF ( Base.ColumnExists('Service','JobScheduleHistories','Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [Active] BIT NOT NULL
END
-- Create [Active] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','Active','DFLT_Service_JobScheduleHistories_Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD CONSTRAINT DFLT_Service_JobScheduleHistories_Active DEFAULT (1) FOR [Active]
END

-- Create column [RecordComment]
IF ( Base.ColumnExists('Service','JobScheduleHistories','RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [RecordComment] VARCHAR(1000) NOT NULL
END
-- Create [RecordComment] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','RecordComment','DFLT_Service_JobScheduleHistories_RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD CONSTRAINT DFLT_Service_JobScheduleHistories_RecordComment DEFAULT ('') FOR [RecordComment]
END

-- Create column [JobScheduleId]
IF ( Base.ColumnExists('Service','JobScheduleHistories','JobScheduleId')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [JobScheduleId] INT NOT NULL
END

-- Create column [ExecuteDateTimeStart]
IF ( Base.ColumnExists('Service','JobScheduleHistories','ExecuteDateTimeStart')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [ExecuteDateTimeStart] DATETIME NOT NULL
END

-- Create column [ExecuteDateTimeEnd]
IF ( Base.ColumnExists('Service','JobScheduleHistories','ExecuteDateTimeEnd')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [ExecuteDateTimeEnd] DATETIME NOT NULL
END

-- Create column [ExecuteUserName]
IF ( Base.ColumnExists('Service','JobScheduleHistories','ExecuteUserName')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [ExecuteUserName] VARCHAR(100) NOT NULL
END
-- Create [ExecuteUserName] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','ExecuteUserName','DFLT_Service_JobScheduleHistories_ExecuteUserName')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD CONSTRAINT DFLT_Service_JobScheduleHistories_ExecuteUserName DEFAULT ('') FOR [ExecuteUserName]
END

-- Create column [ExecuteParams]
IF ( Base.ColumnExists('Service','JobScheduleHistories','ExecuteParams')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [ExecuteParams] VARCHAR(1000) NOT NULL
END
-- Create [ExecuteParams] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','ExecuteParams','DFLT_Service_JobScheduleHistories_ExecuteParams')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD CONSTRAINT DFLT_Service_JobScheduleHistories_ExecuteParams DEFAULT ('') FOR [ExecuteParams]
END

-- Create column [ResultCode]
IF ( Base.ColumnExists('Service','JobScheduleHistories','ResultCode')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [ResultCode] INT NULL
END

-- Create column [ResultText]
IF ( Base.ColumnExists('Service','JobScheduleHistories','ResultText')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [ResultText] VARCHAR(1000) NULL
END

-- Create column [Note]
IF ( Base.ColumnExists('Service','JobScheduleHistories','Note')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD [Note] VARCHAR(2000) NULL
END
-- Create [Note] default constraint
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','Note','DFLT_Service_JobScheduleHistories_Note')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] ADD CONSTRAINT DFLT_Service_JobScheduleHistories_Note DEFAULT ('') FOR [Note]
END






select * from [Service].[JobScheduleHistories]
