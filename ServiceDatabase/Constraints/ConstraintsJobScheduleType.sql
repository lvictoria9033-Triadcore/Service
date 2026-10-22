/*---------------------------------------------------------------------------------------------------------------------
Sets JobScheduleType table foreign key constraints.
Create Date: 2026.10.22
Created By: Triadcore(ACB)
---------------------------------------------------------------------------------------------------------------------*/


-- FK [UserId]
IF ( Base.ForeignKeyExists('Service','JobScheduleTypes','FK_Service_JobScheduleTypes_CreateUserId') = 1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] DROP CONSTRAINT FK_Service_JobScheduleTypes_CreateUserId
END
IF ( Base.TableExists('Base','Users') = 1 ) BEGIN
	IF ( Base.ColumnExists('Base','Users','UserId') = 1 ) BEGIN
		ALTER TABLE [Service].[JobScheduleTypes]
		ADD CONSTRAINT FK_Service_JobScheduleTypes_CreateUserId
		FOREIGN KEY ([CreateUserId]) 
		REFERENCES [Base].[Users] ([UserId])
	END
END

-- FK [UserId]
IF ( Base.ForeignKeyExists('Service','JobScheduleTypes','FK_Service_JobScheduleTypes_UpdateUserId') = 1 ) BEGIN
	ALTER TABLE [Service].[JobScheduleTypes] DROP CONSTRAINT FK_Service_JobScheduleTypes_UpdateUserId
END
IF ( Base.TableExists('Base','Users') = 1 ) BEGIN
	IF ( Base.ColumnExists('Base','Users','UserId') = 1 ) BEGIN
		ALTER TABLE [Service].[JobScheduleTypes]
		ADD CONSTRAINT FK_Service_JobScheduleTypes_UpdateUserId
		FOREIGN KEY ([UpdateUserId]) 
		REFERENCES [Base].[Users] ([UserId])
	END
END
