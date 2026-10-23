
-- FKey CreateUserId 
IF (Base.ForeignKeyExists('Service','JobSchedules','FK_Service_JobSchedules_CreateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] DROP CONSTRAINT FK_Service_JobSchedules_CreateUserId
	PRINT 'Deleted FKey FK_Service_JobSchedules_CreateUserId'
END
GO

-- FKey UpdateUserId 
IF (Base.ForeignKeyExists('Service','JobSchedules','FK_Service_JobSchedules_UpdateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] DROP CONSTRAINT FK_Service_JobSchedules_UpdateUserId
	PRINT 'Deleted FKey FK_Service_JobSchedules_UpdateUserId'
END
GO

-- FKey JobId
IF (Base.ForeignKeyExists('Service','JobSchedules','FKey_Service_JobSchedules_JobId')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] DROP CONSTRAINT FKey_Service_JobSchedules_JobId
	PRINT 'Deleted FKey FKey_Service_JobSchedules_JobId'
END
GO

