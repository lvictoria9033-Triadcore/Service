-- Create the table JobSchedules
IF ( Base.TableExists('Service','JobSchedules')=0 ) BEGIN
	CREATE TABLE [Service].[JobSchedules]
	(
		JobScheduleId INT IDENTITY(1,1) NOT NULL
	)
END

-- Create column JobScheduleId
IF ( Base.ColumnExists('Service','JobSchedules','JobScheduleId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD JobScheduleId INT IDENTITY(1,1)
END
-- Create primary key column
IF ( Base.PrimaryKeyExists('Service','JobSchedules','PKEY_Job_JobSchedules')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT PKEY_Job_JobSchedules PRIMARY KEY NONCLUSTERED 
	(
		[JobScheduleId] ASC
	) ON [PRIMARY]
END

-- Create column JobScheduleName
IF ( Base.ColumnExists('Service','JobSchedules','JobScheduleName')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [JobScheduleName] VARCHAR(100) NOT NULL
END

-- Create column Description
IF ( Base.ColumnExists('Service','JobSchedules','Description')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Description] VARCHAR(1000) NOT NULL
END
-- Create Description default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','Description','DFLT_Job_JobSchedules_Description')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_Description DEFAULT ('') FOR [Description]
END

-- Create column JobId
IF ( Base.ColumnExists('Service','JobSchedules','JobId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD JobId INT NOT NULL
END

-- Create column BaseDateTime (the date/time the job is to run for the first time)
IF ( Base.ColumnExists('Service','JobSchedules','BaseDateTime')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD BaseDateTime DATETIME NOT NULL
END
-- Create BaseDateTime default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','BaseDateTime','DFLT_Job_JobSchedules_BaseDateTime')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_BaseDateTime DEFAULT (GETDATE()) FOR [BaseDateTime]
END

-- Create column NextStart
IF ( Base.ColumnExists('Service','JobSchedules','NextStart')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD NextStart DATETIME NULL
END

-- Create column JobScheduleTypeId
IF ( Base.ColumnExists('Service','JobSchedules','JobScheduleTypeId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD JobScheduleTypeId INT NOT NULL
END

-- Create column JobScheduleId
IF ( Base.ColumnExists('Service','JobSchedules','JobScheduleId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD JobScheduleId INT NOT NULL
END

-- Create column Interval (in minutes)
IF ( Base.ColumnExists('Service','JobSchedules','Interval')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD Interval INT NULL
END

-- Create column Date (date of month 1-31)
IF ( Base.ColumnExists('Service','JobSchedules','Date')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Date] INT NULL
END

-- Create column Month (month index 1-12)
IF ( Base.ColumnExists('Service','JobSchedules','Month')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Month] INT NULL
END

-- Create column Day (day of week index; 1-7=Sun-Sat)
IF ( Base.ColumnExists('Service','JobSchedules','Day')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Day] INT NULL
END

-- Create column Time (24-hour format without colons ":")
IF ( Base.ColumnExists('Service','JobSchedules','Time')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD [Time] INT NULL
END

-- Create column IsRecurring
IF ( Base.ColumnExists('Service','JobSchedules','IsRecurring')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD IsRecurring BIT NOT NULL
END
-- Create IsRecurring default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','IsRecurring','DFLT_Job_JobSchedules_IsRecurring')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_IsRecurring DEFAULT (1) FOR [IsRecurring]
END

-- Create unique constraint for combinded columns JobId, JobScheduleName, Interval, Date, Day, Time, and IsRecurring
IF ( Base.UniqueConstraintExists('Service','JobSchedules','UNQ_Service_JobSchedules')=0) BEGIN
	-- Ensure that there are no duplicates (combined columns) before creating the unique constraint
	IF (SELECT COUNT(JobScheduleId) FROM [Service].JobSchedules GROUP BY JobId, JobScheduleName, Interval, [Date], [Day], [Time], IsRecurring HAVING COUNT(JobScheduleId)>1) IS NULL BEGIN
		ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT UNQ_Service_JobSchedules UNIQUE (JobId, JobScheduleName, Interval, [Date], [Day], [Time], IsRecurring)
	END
	ELSE BEGIN
		RAISERROR ('Cannot create the Unique Constraint UNQ_Service_JobSchedules for the combined columns [JobSchedules].[JobId], [JobSchedules].[JobScheduleName], [JobSchedules].[JobScheduleId], [JobSchedules].[Interval], [JobSchedules].[Day], [JobSchedules].[Date], [JobSchedules].[Time], and [JobSchedules].[IsRecurring].  The column combination contains non-unique values.',11,1) 
	END
END

-- Create column RunAsUser
IF ( Base.ColumnExists('Service','JobSchedules','RunAsUser')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD RunAsUser VARCHAR(100) NOT NULL
END
-- Create RunAsUser default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','RunAsUser','DFLT_Job_JobSchedules_RunAsUser')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_RunAsUser DEFAULT ('') FOR [RunAsUser]
END

-- Create column RunAsPassword
IF ( Base.ColumnExists('Service','JobSchedules','RunAsPassword')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD RunAsPassword VARCHAR(200) NOT NULL
END
-- Create RunAsPassword default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','RunAsPassword','DFLT_Job_JobSchedules_RunAsPassword')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_RunAsPassword DEFAULT ('') FOR [RunAsPassword]
END

-- Create column Active
IF ( Base.ColumnExists('Service','JobSchedules','Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD Active BIT NOT NULL
END
-- Create Active default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','Active','DFLT_Job_JobSchedules_Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_Active DEFAULT (1) FOR [Active]
END

-- Create column UpdateDate
IF ( Base.ColumnExists('Service','JobSchedules','UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD UpdateDate DATETIME NOT NULL
END
-- Create UpdateDate default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','UpdateDate','DFLT_Job_JobSchedules_UpdateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_UpdateDate DEFAULT (GetDate()) FOR [UpdateDate]
END

-- Create column UpdateUserId
IF ( Base.ColumnExists('Service','JobSchedules','UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD UpdateUserId INT NOT NULL
END
-- Create UpdateUserId default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','UpdateUserId','DFLT_Job_JobSchedules_UpdateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_UpdateUserId DEFAULT (0) FOR [UpdateUserId]
END

-- Create column CreateDate
IF ( Base.ColumnExists('Service','JobSchedules','CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CreateDate DATETIME NOT NULL
END
-- Create CreateDate default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','CreateDate','DFLT_Job_JobSchedules_CreateDate')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_CreateDate DEFAULT (GetDate()) FOR [CreateDate]
END

-- Create column CreateUserId
IF ( Base.ColumnExists('Service','JobSchedules','CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CreateUserId INT NOT NULL
END
-- Create CreateUserId default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','CreateUserId','DFLT_Job_JobSchedules_CreateUserId')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_CreateUserId DEFAULT (0) FOR [CreateUserId]
END

-- Create column RecordComment
IF ( Base.ColumnExists('Service','JobSchedules','RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD RecordComment VARCHAR(1000) NOT NULL
END
-- Create RecordComment default constraint
IF ( Base.ColumnDefaultExists('Service','JobSchedules','RecordComment','DFLT_Job_JobSchedules_RecordComment')=0 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] ADD CONSTRAINT DFLT_Job_JobSchedules_RecordComment DEFAULT ('') FOR [RecordComment]
END

select * from [Service].JobSchedules order by NextStart desc