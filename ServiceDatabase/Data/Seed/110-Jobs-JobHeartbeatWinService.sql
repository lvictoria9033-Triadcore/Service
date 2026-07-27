
DECLARE @UpdateUserId INT = -1


SELECT @UpdateUserId=UserId FROM Base.Users WHERE UserName='SysDataLoader'


IF ( NOT EXISTS (SELECT [JobId] FROM [Service].[Jobs] WHERE [JobName]='JobHeartbeatWinService')) BEGIN
	EXEC [Service].[UpdateJob]
		 NULL --@JobId INT
		,'__JobHeartbeatWinService' --@SortText VARCHAR(100)
		,'JobHeartbeatWinService' --@JobName VARCHAR(50)
		,'Windows Service Heartbeat Checker' --@JobFriendlyName VARCHAR(100)
		,'Code run by the job server windows service that indicates that the windows service is up and running by virtue of executing this job.' --@Description VARCHAR(200)
		,'{BasePath}\Applications\JobHeartbeatWinService' --@ExecPath VARCHAR(2000)
		,'Triadcore.Service.JobHeartbeatWinService.exe' --@ExecFile VARCHAR(200)
		,'' --@ParamString VARCHAR(1000)
		,1 --@LogStarts BIT
		,1 --@LogFinishes BIT
		,@UpdateUserId --@UpdateUserId INT
END

EXEC [Service].[GetJobs]
	null --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,null --@JobId INT
	,null --@CreateUserId INT
	,null --@UpdateUserId INT
	,null --@Active BIT
	,null --@JobNameCompareLogic VARCHAR(8)  -- only '=','<>,'LIKE', 'NOT LIKE', 'IN', 'NOT IN'
	,null --@JobName VARCHAR(100)
	,null --@LogFinishesCompareLogic VARCHAR(10)
	,null --@LogFinishes BIT