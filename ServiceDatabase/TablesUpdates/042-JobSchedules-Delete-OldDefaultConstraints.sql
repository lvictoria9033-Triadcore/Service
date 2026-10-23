
IF ( Base.ColumnDefaultExists('Service','JobSchedules','Active','DFLT_Job_JobSchedules_Active')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_Active
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','CreateDate','DFLT_Job_JobSchedules_CreateDate')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_CreateDate
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','CreateUserId','DFLT_Job_JobSchedules_CreateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_CreateUserId
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','UpdateDate','DFLT_Job_JobSchedules_UpdateDate')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_UpdateDate
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','UpdateUserId','DFLT_Job_JobSchedules_UpdateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_UpdateUserId
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','RecordComment','DFLT_Job_JobSchedules_RecordComment')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_RecordComment
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','BaseDateTime','DFLT_Job_JobSchedules_BaseDateTime')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_BaseDateTime
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','Description','DFLT_Job_JobSchedules_Description')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_Description
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','IsRecurring','DFLT_Job_JobSchedules_IsRecurring')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_IsRecurring
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','RecordComment','DFLT_Job_JobSchedules_RecordComment')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_RecordComment
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','RunAsPassword','DFLT_Job_JobSchedules_RunAsPassword')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_RunAsPassword
END

IF ( Base.ColumnDefaultExists('Service','JobSchedules','RunAsUser','DFLT_Job_JobSchedules_RunAsUser')=1 ) BEGIN
	ALTER TABLE [Service].[JobSchedules] 
	DROP CONSTRAINT DFLT_Job_JobSchedules_RunAsUser
END