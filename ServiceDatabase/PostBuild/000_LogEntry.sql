
DECLARE @DefaultUserId INT = -1

SELECT @DefaultUserId=UserId FROM [Base].Users WHERE DefaultFlag=1

EXEC [Base].[UpdateMessageLog]
	NULL --@MessageLogId INT
	,'DbBuilder' --@GroupIdentifier VARCHAR(50)
	,NULL --@EventDateTime DATETIME
	,'Normal' --@Severity VARCHAR(50)
	,'Informmational' --@SeverityDescription VARCHAR(200)
	,'Info' --@MessageType VARCHAR(50)
	,'[Service] component of the database created' --@LogMessage VARCHAR(4000)
	,'Notification for database component build completion' --@Description VARCHAR(1000)
	,'SQL Server' --@ClientIdentifier VARCHAR(100)s
	,-1 --@ApplicationId INT
	,'Database Builder' --@ApplicationIdentifier VARCHAR(100)
	,NULL --@DataId INT
	,NULL --@DataIdentifier VARCHAR(100)
	,'SQL Server' --@Environment VARCHAR(100)
	,NULL --@ComponentName VARCHAR(100)
	,'The [Service] component of the database was built.' --@UserText VARCHAR(2000)
	,'' --@UserName VARCHAR(100)
	,@DefaultUserId --@UpdateUserId INT

