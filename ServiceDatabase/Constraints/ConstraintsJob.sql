
	-- FK UserId
	IF ( Base.ForeignKeyExists('Service','Jobs','FK_Service_Jobs_CreateUserId')=1 ) BEGIN
		ALTER TABLE [Service].[Jobs] DROP CONSTRAINT FK_Service_Jobs_CreateUserId
	END
	IF ( Base.TableExists('base','Users')=1 ) BEGIN
		IF ( Base.ColumnExists('base','Users','UserId')=1 ) BEGIN
			ALTER TABLE [Service].[Jobs]
			ADD CONSTRAINT FK_Service_Jobs_CreateUserId
			FOREIGN KEY ([CreateUserId]) 
			REFERENCES [base].[Users] ([UserId])
		END
	END

	-- FK UserId
	IF ( Base.ForeignKeyExists('Service','Jobs','FK_Service_Jobs_UpdateUserId')=1 ) BEGIN
		ALTER TABLE [Service].[Jobs] DROP CONSTRAINT FK_Service_Jobs_UpdateUserId
	END
	IF ( Base.TableExists('base','Users')=1 ) BEGIN
		IF ( Base.ColumnExists('base','Users','UserId')=1 ) BEGIN
			ALTER TABLE [Service].[Jobs]
			ADD CONSTRAINT FK_Service_Jobs_UpdateUserId
			FOREIGN KEY ([UpdateUserId]) 
			REFERENCES [base].[Users] ([UserId])
		END
	END

