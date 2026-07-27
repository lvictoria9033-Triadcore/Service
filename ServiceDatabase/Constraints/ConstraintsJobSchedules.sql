-- Create JobSchedules FK constraints
IF ( Base.TableExists('Service','JobSchedules')=1 ) BEGIN

	-- FK JobId
	IF (Base.ForeignKeyExists('Service','JobSchedules','FKey_Service_JobSchedules_JobId')=1 ) BEGIN
		ALTER TABLE [Service].JobSchedules DROP CONSTRAINT FKey_Service_JobSchedules_JobId
	END
	IF  ( Base.TableExists('Service','Jobs')=1 ) BEGIN
		IF ( Base.ColumnExists('Service','Jobs','JobId')=1 ) BEGIN
			ALTER TABLE [Service].JobSchedules
			ADD CONSTRAINT FKey_Service_JobSchedules_JobId
			FOREIGN KEY (JobId) REFERENCES [Service].Jobs (JobId) 
		END
	END

	-- FK JobScheduleTypeId
	IF (Base.ForeignKeyExists('Service','JobSchedules','FKey_Service_JobSchedules_JobScheduleTypeId')=1 ) BEGIN
		ALTER TABLE [Service].JobSchedules DROP CONSTRAINT FKey_Service_JobSchedules_JobScheduleTypeId
	END
	IF  ( Base.TableExists('Service','JobScheduleTypes')=1 ) BEGIN
		IF ( Base.ColumnExists('Service','JobScheduleTypes','JobScheduleTypeId')=1 ) BEGIN
			ALTER TABLE [Service].JobSchedules
			ADD CONSTRAINT FKey_Service_JobSchedules_JobScheduleTypeId
			FOREIGN KEY (JobScheduleTypeId) REFERENCES [Service].JobScheduleTypes (JobScheduleTypeId) 
		END
	END

	-- FK UpdateUserId
	IF ( Base.ForeignKeyExists('Service','JobSchedules','FK_Service_JobSchedules_UpdateUserId')=1 ) BEGIN
		ALTER TABLE [Service].JobSchedules DROP CONSTRAINT FK_Service_JobSchedules_UpdateUserId
	END
	IF  ( Base.TableExists('Base','Users')=1 ) BEGIN
		IF ( Base.ColumnExists('Base','Users','UserId')=1 ) BEGIN
			ALTER TABLE [Service].JobSchedules 
			ADD CONSTRAINT FK_Service_JobSchedules_UpdateUserId 
			FOREIGN KEY (UpdateUserId) REFERENCES Base.Users (UserId)
		END
	END

	-- FK CreateUserId
	IF ( Base.ForeignKeyExists('Service','JobSchedules','FK_Service_JobSchedules_CreateUserId')=1 ) BEGIN
		ALTER TABLE [Service].JobSchedules DROP CONSTRAINT FK_Service_JobSchedules_CreateUserId
	END
	IF  ( Base.TableExists('Base','Users')=1 ) BEGIN
		IF ( Base.ColumnExists('Base','Users','UserId')=1 ) BEGIN
			ALTER TABLE [Service].JobSchedules 
			ADD CONSTRAINT FK_Service_JobSchedules_CreateUserId 
			FOREIGN KEY (CreateUserId) REFERENCES Base.Users (UserId)
		END
	END

END
