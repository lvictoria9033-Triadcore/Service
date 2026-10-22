

-- FK JobScheduleTypeId in JobSchedules referencing JobScheduleTypes PK. 
-- This must be rebuilt on JobSchedules after this is done. See ..\Constraints\ConstraintsJobSchedules.sql.
IF (Base.ForeignKeyExists('Service','JobSchedules','FKey_Service_JobSchedules_JobScheduleTypeId')=1 ) BEGIN
	ALTER TABLE [Service].JobSchedules DROP CONSTRAINT FKey_Service_JobSchedules_JobScheduleTypeId
END
GO

-- Remove PK constraint on JobScheduleTypeId
IF ( Base.PrimaryKeyExists('Service','JobScheduleTypes','PKEY_Job_JobScheduleTypes')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] 
	DROP CONSTRAINT PKEY_Job_JobScheduleTypes
END
GO