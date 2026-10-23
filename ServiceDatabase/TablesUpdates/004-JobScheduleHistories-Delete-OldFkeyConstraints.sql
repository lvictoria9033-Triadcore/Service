
-- FKey CreateUserId 
IF (Base.ForeignKeyExists('Service','JobScheduleHistories','FK_Job_JobScheduleHistory_CreateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] DROP CONSTRAINT FK_Job_JobScheduleHistory_CreateUserId
	PRINT 'Deleted FKey FK_Job_JobScheduleHistory_CreateUserId'
END
IF (Base.ForeignKeyExists('Service','JobScheduleHistories','FK_Service_JobScheduleHistory_CreateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] DROP CONSTRAINT FK_Service_JobScheduleHistory_CreateUserId
	PRINT 'Deleted FKey FK_Service_JobScheduleHistory_CreateUserId'
END
GO

-- FKey UpdateUserId 
IF (Base.ForeignKeyExists('Service','JobScheduleHistories','FK_Job_JobScheduleHistory_UpdateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] DROP CONSTRAINT FK_Job_JobScheduleHistory_UpdateUserId
	PRINT 'Deleted FKey FK_Job_JobScheduleHistory_UpdateUserId'
END
IF (Base.ForeignKeyExists('Service','JobScheduleHistories','FK_Service_JobScheduleHistory_UpdateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] DROP CONSTRAINT FK_Service_JobScheduleHistory_UpdateUserId
	PRINT 'Deleted FKey FK_Service_JobScheduleHistory_UpdateUserId'
END
GO

-- FKey JobScheduleId 
IF (Base.ForeignKeyExists('Service','JobScheduleHistories','FK_Job_JobScheduleHistory_JobScheduleId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] DROP CONSTRAINT FK_Job_JobScheduleHistory_JobScheduleId
	PRINT 'Deleted FKey FK_Job_JobScheduleHistory_JobScheduleId'
END
IF (Base.ForeignKeyExists('Service','JobScheduleHistories','FK_Service_JobScheduleHistory_JobScheduleId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] DROP CONSTRAINT FK_Service_JobScheduleHistory_JobScheduleId
	PRINT 'Deleted FKey FK_Service_JobScheduleHistory_JobScheduleId'
END
GO

