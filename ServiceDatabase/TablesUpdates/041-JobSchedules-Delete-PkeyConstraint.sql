

-- FK JobScheduleTypeId in JobScheduleHistories referencing JobSchedules PK. 
-- This must be rebuilt on JobScheduleHistories after this is done. See ..\Constraints\ConstraintsJobScheduleHistory.sql.
IF (Base.ForeignKeyExists('Service','JobScheduleHistories','FK_Job_JobScheduleHistory_JobScheduleId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] DROP CONSTRAINT FK_Job_JobScheduleHistory_JobScheduleId
	PRINT 'Deleted FKey FK_Job_JobScheduleHistory_JobScheduleId'
END
GO

-- Remove PK constraint on JobScheduleTypeId
IF ( Base.PrimaryKeyExists('Service','JobSchedules','PKEY_Job_JobSchedules')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] DROP CONSTRAINT PKEY_Job_JobSchedules
	PRINT 'Deleted PKey PKEY_Job_JobSchedules'
END
GO