IF ( Base.TableExists('Service','Jobs')=1 ) BEGIN

	DECLARE @LoaderUserId INT = -1

	SELECT @LoaderUserId=UserId FROM Base.Users WHERE UserName='SysDataLoader'
	
	IF (SELECT COUNT(*) FROM [Service].Jobs)=0 BEGIN
		DBCC CHECKIDENT('[Service].Jobs', RESEED, 1)
	END

	--@JobId, @JobName, @JobFriendlyName, @Description, @ExecPath, @ExecFile, @ParamString, @LogStarts, @LogFinishes, @SortText, @UpdateUserId, @RecordComment

	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].Jobs WHERE JobName='JobHeartbeatWinService') ) BEGIN
		EXEC [Service].UpdateJob null, 'Job_001', 'JobHeartbeatWinService', 'Windows Service Heartbeat Checker', 'Code run by the windows service that indicates that the windows service is up and running.', '{BasePath}\Applications\JobHeartbeatWinService', 'Triadcore.Service.JobHeartbeatWinService.exe', NULL, 1, 1, @LoaderUserId
	END

	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].Jobs WHERE JobName='UriChecker') ) BEGIN
		EXEC [Service].UpdateJob null, 'Job_001', 'UriChecker', 'URI Heartbeat Checker', 'Checks if a URI (website) is online and responsive.', '{BasePath}\Applications\JobUriChecker', 'Triadcore.ServiceJobUriChecker.exe', NULL, 1, 1, @LoaderUserId
	END


	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].Jobs WHERE JobName='JobMessageLogPurge') ) BEGIN
		EXEC [Service].UpdateJob null, 'Job_001', 'JobMessageLogPurge', 'Log Data Purge', 'Code run by the windows service that runs a process to purge data from the message log.', '{BasePath}\Applications\JobMessageLogPurge', 'Triadcore.Service.JobMessageLogPurge.exe', NULL, 1, 1, @LoaderUserId
	END


	------------------------------------------------------------------------------------------------------------------------------------
	UPDATE [Service].Jobs
	SET SortText = UPPER(JobName) WHERE ISNULL(SortText,'')=''

END

select * from [Service].Jobs order by SortText
