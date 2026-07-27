
	-- FK UserId
	IF ( Base.ForeignKeyExists('Service','JobScheduleTypes','FK_Service_JobScheduleTypes_CreateUserId')=1 ) BEGIN
		ALTER TABLE [Service].[JobScheduleTypes] DROP CONSTRAINT FK_Service_JobScheduleTypes_CreateUserId
	END
	IF ( Base.TableExists('base','Users')=1 ) BEGIN
		IF ( Base.ColumnExists('base','Users','UserId')=1 ) BEGIN
			ALTER TABLE [Service].[JobScheduleTypes]
			ADD CONSTRAINT FK_Service_JobScheduleTypes_CreateUserId
			FOREIGN KEY ([CreateUserId]) 
			REFERENCES [base].[Users] ([UserId])
		END
	END

	-- FK UserId
	IF ( Base.ForeignKeyExists('Service','JobScheduleTypes','FK_Service_JobScheduleTypes_UpdateUserId')=1 ) BEGIN
		ALTER TABLE [Service].[JobScheduleTypes] DROP CONSTRAINT FK_Service_JobScheduleTypes_UpdateUserId
	END
	IF ( Base.TableExists('base','Users')=1 ) BEGIN
		IF ( Base.ColumnExists('base','Users','UserId')=1 ) BEGIN
			ALTER TABLE [Service].[JobScheduleTypes]
			ADD CONSTRAINT FK_Service_JobScheduleTypes_UpdateUserId
			FOREIGN KEY ([UpdateUserId]) 
			REFERENCES [base].[Users] ([UserId])
		END
	END

