
	-- FK UserId
	IF ( Base.ForeignKeyExists('Service','JobScheduleHistory','FK_Service_JobScheduleHistory_CreateUserId')=1 ) BEGIN
		ALTER TABLE [Service].[JobScheduleHistory] DROP CONSTRAINT FK_Service_JobScheduleHistory_CreateUserId
	END
	IF ( Base.TableExists('base','Users')=1 ) BEGIN
		IF ( Base.ColumnExists('base','Users','UserId')=1 ) BEGIN
			ALTER TABLE [Service].[JobScheduleHistory]
			ADD CONSTRAINT FK_Service_JobScheduleHistory_CreateUserId
			FOREIGN KEY ([CreateUserId]) 
			REFERENCES [base].[Users] ([UserId])
		END
	END

	-- FK UserId
	IF ( Base.ForeignKeyExists('Service','JobScheduleHistory','FK_Service_JobScheduleHistory_UpdateUserId')=1 ) BEGIN
		ALTER TABLE [Service].[JobScheduleHistory] DROP CONSTRAINT FK_Service_JobScheduleHistory_UpdateUserId
	END
	IF ( Base.TableExists('base','Users')=1 ) BEGIN
		IF ( Base.ColumnExists('base','Users','UserId')=1 ) BEGIN
			ALTER TABLE [Service].[JobScheduleHistory]
			ADD CONSTRAINT FK_Service_JobScheduleHistory_UpdateUserId
			FOREIGN KEY ([UpdateUserId]) 
			REFERENCES [base].[Users] ([UserId])
		END
	END

	-- FK JobScheduleId
	IF ( Base.ForeignKeyExists('Service','JobScheduleHistory','FK_Service_JobScheduleHistory_JobScheduleId')=1 ) BEGIN
		ALTER TABLE [Service].[JobScheduleHistory] DROP CONSTRAINT FK_Service_JobScheduleHistory_JobScheduleId
	END
	IF ( Base.TableExists('Service','JobSchedules')=1 ) BEGIN
		IF ( Base.ColumnExists('Service','JobSchedules','JobScheduleId')=1 ) BEGIN
			ALTER TABLE [Service].[JobScheduleHistory]
			ADD CONSTRAINT FK_Service_JobScheduleHistory_JobScheduleId
			FOREIGN KEY ([JobScheduleId]) 
			REFERENCES [Service].[JobSchedules] ([JobScheduleId])
		END
	END

