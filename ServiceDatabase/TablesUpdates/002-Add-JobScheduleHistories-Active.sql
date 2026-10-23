-- Add nullable column
IF ( [Base].ColumnExists('Service','JobScheduleHistories','Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories]
	ADD [Active] BIT NULL
END
GO

-- Set values in column
UPDATE [Service].[JobScheduleHistories]
SET [Active]=1
WHERE [Active] IS NULL
GO

-- Set column NOT NULL
ALTER TABLE [Service].[JobScheduleHistories]
ALTER COLUMN [Active] BIT NOT NULL
GO

-- Set column default constratint
IF ( [Base].ColumnDefaultExists('Service','JobScheduleHistories','Active','DFLT_Service_JobScheduleHistories_Active')=0 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] 
	ADD CONSTRAINT DFLT_Service_JobScheduleHistories_Active DEFAULT (1) FOR [Active]
END
GO

