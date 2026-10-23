
IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','Active','DFLT_Job_JobScheduleHistory_Active')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] 
	DROP CONSTRAINT DFLT_Job_JobScheduleHistory_Active
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','CreateDate','DFLT_Job_JobScheduleHistory_CreateDate')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] 
	DROP CONSTRAINT DFLT_Job_JobScheduleHistory_CreateDate
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','CreateUserId','DFLT_Job_JobScheduleHistory_CreateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] 
	DROP CONSTRAINT DFLT_Job_JobScheduleHistory_CreateUserId
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','UpdateDate','DFLT_Job_JobScheduleHistory_UpdateDate')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] 
	DROP CONSTRAINT DFLT_Job_JobScheduleHistory_UpdateDate
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','UpdateUserId','DFLT_Job_JobScheduleHistory_UpdateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] 
	DROP CONSTRAINT DFLT_Job_JobScheduleHistory_UpdateUserId
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','Note','DFLT_Job_JobScheduleHistory_Note')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] 
	DROP CONSTRAINT DFLT_Job_JobScheduleHistory_Note
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleHistories','RecordComment','DFLT_Job_JobScheduleHistory_RecordComment')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] 
	DROP CONSTRAINT DFLT_Job_JobScheduleHistory_RecordComment
END



