
-- Remove PK constraint on JobScheduleHistoryId
IF ( Base.PrimaryKeyExists('Service','JobScheduleHistories','PKEY_Job_JobScheduleHistory')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] 
	DROP CONSTRAINT PKEY_Job_JobScheduleHistory
END
GO