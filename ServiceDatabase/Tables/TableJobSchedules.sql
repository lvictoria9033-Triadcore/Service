/*---------------------------------------------------------------------------------------------------------------------
Inserts a new JobSchedule table if it does not exist.
Create Date: 2026.10.23
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/

-- Create the table JobSchedules
IF ( Base.TableExists('Service','JobSchedules')=0 ) BEGIN
	CREATE TABLE [Service].[JobSchedules]
	(
		[JobScheduleId] INT IDENTITY(1,1) NOT NULL
	)
END

-- Create PK column JobScheduleId
IF ( Base.ColumnExists('Service','JobSchedules','JobScheduleId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [JobScheduleId] INT IDENTITY(1,1) NOT NULL
END
-- Create primary key column
IF ( Base.PrimaryKeyExists('Service','JobSchedules','PKEY_Service_JobSchedules')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT PKEY_Service_JobSchedules PRIMARY KEY NONCLUSTERED 
	(
		[JobScheduleId] ASC
	) ON [PRIMARY]
END

-- Create column [CreateDate]
IF ( Base.ColumnExists('Service','JobSchedules','CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [CreateDate] DATETIME NOT NULL
END
-- Create [CreateDate] default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','CreateDate','DFLT_Service_JobSchedules_CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Service_JobSchedules_CreateDate DEFAULT (GETDATE()) FOR [CreateDate]
END

-- Create column [CreateUserId]
IF ( Base.ColumnExists('Service','JobSchedules','CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [CreateUserId] INT NOT NULL
END

-- Create column [UpdateDate]
IF ( Base.ColumnExists('Service','JobSchedules','UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [UpdateDate] DATETIME NOT NULL
END
-- Create [UpdateDate] default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','UpdateDate','DFLT_Service_JobSchedules_UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Service_JobSchedules_UpdateDate DEFAULT (GETDATE()) FOR [UpdateDate]
END

-- Create column [UpdateUserId]
IF ( Base.ColumnExists('Service','JobSchedules','UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [UpdateUserId] INT NOT NULL
END

-- Create column [Active]
IF ( Base.ColumnExists('Service','JobSchedules','Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Active] BIT NOT NULL
END
-- Create [Active] default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','Active','DFLT_Service_JobSchedules_Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Service_JobSchedules_Active DEFAULT (1) FOR [Active]
END

-- Create column [RecordComment]
IF ( Base.ColumnExists('Service','JobSchedules','RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [RecordComment] VARCHAR(1000) NOT NULL
END
-- Create [RecordComment] default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','RecordComment','DFLT_Service_JobSchedules_RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Service_JobSchedules_RecordComment DEFAULT ('') FOR [RecordComment]
END

-- Create column [JobScheduleName]
IF ( Base.ColumnExists('Service','JobSchedules','JobScheduleName')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [JobScheduleName] VARCHAR(100) NOT NULL
END

-- Create column [Description]
IF ( Base.ColumnExists('Service','JobSchedules','Description')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Description] VARCHAR(1000) NOT NULL
END
-- Create [Description] default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','Description','DFLT_Service_JobSchedules_Description')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Service_JobSchedules_Description DEFAULT ('') FOR [Description]
END

-- Create column [JobId]
IF ( Base.ColumnExists('Service','JobSchedules','JobId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [JobId] INT NOT NULL
END

-- Create column [JobScheduleTypeId]
IF ( Base.ColumnExists('Service','JobSchedules','JobScheduleTypeId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [JobScheduleTypeId] INT NOT NULL
END

-- Create column [BaseDateTime]
IF ( Base.ColumnExists('Service','JobSchedules','BaseDateTime')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [BaseDateTime] DATETIME NOT NULL
END
-- Create [BaseDateTime] default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','BaseDateTime','DFLT_Service_JobSchedules_BaseDateTime')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Service_JobSchedules_BaseDateTime DEFAULT ('GETDATE()') FOR [BaseDateTime]
END

-- Create column [NextStart]
IF ( Base.ColumnExists('Service','JobSchedules','NextStart')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [NextStart] DATETIME NULL
END

-- Create column [Interval]
IF ( Base.ColumnExists('Service','JobSchedules','Interval')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Interval] INT NULL
END

-- Create column [Date]
IF ( Base.ColumnExists('Service','JobSchedules','Date')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Date] INT NULL
END

-- Create column [Month]
IF ( Base.ColumnExists('Service','JobSchedules','Month')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Month] INT NULL
END

-- Create column [Day]
IF ( Base.ColumnExists('Service','JobSchedules','Day')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Day] INT NULL
END

-- Create column [Time]
IF ( Base.ColumnExists('Service','JobSchedules','Time')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Time] INT NULL
END

-- Create column [IsRecurring]
IF ( Base.ColumnExists('Service','JobSchedules','IsRecurring')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [IsRecurring] BIT NOT NULL
END
-- Create [IsRecurring] default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','IsRecurring','DFLT_Service_JobSchedules_IsRecurring')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Service_JobSchedules_IsRecurring DEFAULT (0) FOR [IsRecurring]
END

-- Create column [RunAsUser]
IF ( Base.ColumnExists('Service','JobSchedules','RunAsUser')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [RunAsUser] VARCHAR(100) NOT NULL
END
-- Create [RunAsUser] default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','RunAsUser','DFLT_Service_JobSchedules_RunAsUser')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Service_JobSchedules_RunAsUser DEFAULT ('') FOR [RunAsUser]
END

-- Create column [RunAsPassword]
IF ( Base.ColumnExists('Service','JobSchedules','RunAsPassword')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [RunAsPassword] VARCHAR(200) NOT NULL
END
-- Create [RunAsPassword] default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','RunAsPassword','DFLT_Service_JobSchedules_RunAsPassword')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Service_JobSchedules_RunAsPassword DEFAULT ('') FOR [RunAsPassword]
END


-- Create unique constraint for a column [JobScheduleName]
IF (Base.UniqueConstraintExists('Service','JobSchedules','UNQ_Service_JobSchedules_JobScheduleName') = 1) BEGIN
	ALTER TABLE [Service].[JobSchedules] DROP CONSTRAINT UNQ_Service_JobSchedules_JobScheduleName
END
IF (SELECT TOP 1 [JobScheduleName] FROM [Service].[JobSchedules] GROUP BY JobScheduleName HAVING COUNT([JobScheduleName]) > 1) IS NULL BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT UNQ_Service_JobSchedules_JobScheduleName UNIQUE ([JobScheduleName])
END
ELSE BEGIN
	RAISERROR ('Cannot create the Unique Constraint for column [JobScheduleName].  The column contains non-unique values.',11,1) 
END

-- Create unique constraint for one or combination of multiple columns
IF (Base.UniqueConstraintExists('Service','JobSchedules','UNQCbo_Service_JobSchedules') = 1) BEGIN
	ALTER TABLE [Service].[JobSchedules] DROP CONSTRAINT UNQCbo_Service_JobSchedules
END
IF (SELECT TOP 1 [JobScheduleName] FROM [Service].[JobSchedules] GROUP BY [JobScheduleName], [JobId], [Interval], [Date], [Day], [IsRecurring] HAVING COUNT([JobScheduleId]) > 1) IS NULL BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT UNQCbo_Service_JobSchedules UNIQUE ([JobScheduleName], [JobId], [Interval], [Date], [Day], [IsRecurring])
END
ELSE BEGIN
	RAISERROR ('Cannot create the Unique Constraint for columns [JobScheduleName], [JobId], [Interval], [Date], [Day], [IsRecurring].  The column combination contains non-unique values.',11,1) 
END

select * from [Service].[JobSchedules]
