/*---------------------------------------------------------------------------------------------------------------------
Sets JobScheduleHistory table foreign key constraints.
Create Date: 2026.10.23
Created By: Triadcore(ACB)
---------------------------------------------------------------------------------------------------------------------*/


-- FK [UserId]
IF ( Base.ForeignKeyExists('Service','JobScheduleHistories','FK_Service_JobScheduleHistories_CreateUserId') = 1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] DROP CONSTRAINT FK_Service_JobScheduleHistories_CreateUserId
END
IF ( Base.TableExists('Base','Users') = 1 ) BEGIN
	IF ( Base.ColumnExists('Base','Users','UserId') = 1 ) BEGIN
		ALTER TABLE [Service].[JobScheduleHistories]
		ADD CONSTRAINT FK_Service_JobScheduleHistories_CreateUserId
		FOREIGN KEY ([CreateUserId]) 
		REFERENCES [Base].[Users] ([UserId])
	END
END

-- FK [UserId]
IF ( Base.ForeignKeyExists('Service','JobScheduleHistories','FK_Service_JobScheduleHistories_UpdateUserId') = 1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] DROP CONSTRAINT FK_Service_JobScheduleHistories_UpdateUserId
END
IF ( Base.TableExists('Base','Users') = 1 ) BEGIN
	IF ( Base.ColumnExists('Base','Users','UserId') = 1 ) BEGIN
		ALTER TABLE [Service].[JobScheduleHistories]
		ADD CONSTRAINT FK_Service_JobScheduleHistories_UpdateUserId
		FOREIGN KEY ([UpdateUserId]) 
		REFERENCES [Base].[Users] ([UserId])
	END
END

-- FK [JobScheduleId]
IF ( Base.ForeignKeyExists('Service','JobScheduleHistories','FK_Service_JobScheduleHistories_JobScheduleId') = 1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleHistories] DROP CONSTRAINT FK_Service_JobScheduleHistories_JobScheduleId
END
IF ( Base.TableExists('Service','JobSchedules') = 1 ) BEGIN
	IF ( Base.ColumnExists('Service','JobSchedules','JobScheduleId') = 1 ) BEGIN
		ALTER TABLE [Service].[JobScheduleHistories]
		ADD CONSTRAINT FK_Service_JobScheduleHistories_JobScheduleId
		FOREIGN KEY ([JobScheduleId]) 
		REFERENCES [Service].[JobSchedules] ([JobScheduleId])
	END
END
