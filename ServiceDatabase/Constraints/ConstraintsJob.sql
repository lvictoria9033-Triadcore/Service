	-- FK UserId
	IF ( Base.ForeignKeyExists('Service','Jobs','FK_Service_Jobs_UpdateUserId')=1 ) BEGIN
		ALTER TABLE [Service].[Jobs] DROP CONSTRAINT FK_Service_Jobs_UpdateUserId
	END
	IF ( Base.TableExists('Base','Users')=1 ) BEGIN
		IF ( Base.ColumnExists('Base','Users','UserId')=1 ) BEGIN
			ALTER TABLE [Service].[Jobs]
			ADD CONSTRAINT FK_Service_Jobs_UpdateUserId
			FOREIGN KEY ([UpdateUserId]) 
			REFERENCES [Base].[Users] ([UserId])
		END
	END
		-- FK UserId
	IF ( Base.ForeignKeyExists('Service','Jobs','FK_Service_Jobs_CreateUserId')=1 ) BEGIN
		ALTER TABLE [Service].[Jobs] DROP CONSTRAINT FK_Service_Jobs_CreateUserId
	END
	IF ( Base.TableExists('Base','Users')=1 ) BEGIN
		IF ( Base.ColumnExists('Base','Users','UserId')=1 ) BEGIN
			ALTER TABLE [Service].[Jobs]
			ADD CONSTRAINT FK_Service_Jobs_CreateUserId
			FOREIGN KEY ([CreateUserId]) 
			REFERENCES [Base].[Users] ([UserId])
		END
	END

