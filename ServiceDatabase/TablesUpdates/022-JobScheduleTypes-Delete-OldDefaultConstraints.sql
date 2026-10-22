
IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','Active','DFLT_Job_JobScheduleTypes_Active')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] 
	DROP CONSTRAINT DFLT_Job_JobScheduleTypes_Active
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','CreateDate','DFLT_Job_JobScheduleTypes_CreateDate')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] 
	DROP CONSTRAINT DFLT_Job_JobScheduleTypes_CreateDate
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','CreateUserId','DFLT_Job_JobScheduleTypes_CreateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] 
	DROP CONSTRAINT DFLT_Job_JobScheduleTypes_CreateUserId
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','UpdateDate','DFLT_Job_JobScheduleTypes_UpdateDate')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] 
	DROP CONSTRAINT DFLT_Job_JobScheduleTypes_UpdateDate
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','UpdateUserId','DFLT_Job_JobScheduleTypes_UpdateUserId')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] 
	DROP CONSTRAINT DFLT_Job_JobScheduleTypes_UpdateUserId
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','Description','DFLT_Job_JobScheduleTypes_Description')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] 
	DROP CONSTRAINT DFLT_Job_JobScheduleTypes_Description
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','InstanceDescription','DFLT_Job_JobScheduleTypes_InstanceDescription')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] 
	DROP CONSTRAINT DFLT_Job_JobScheduleTypes_InstanceDescription
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','Note','DFLT_Job_JobScheduleTypes_Note')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] 
	DROP CONSTRAINT DFLT_Job_JobScheduleTypes_Note
END

IF ( Base.ColumnDefaultExists('Service','JobScheduleTypes','RecordComment','DFLT_Job_JobScheduleTypes_RecordComment')=1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] 
	DROP CONSTRAINT DFLT_Job_JobScheduleTypes_RecordComment
END



