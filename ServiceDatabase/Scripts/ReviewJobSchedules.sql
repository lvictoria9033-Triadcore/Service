

EXEC [Service].[GetJobSchedules]
	 'and' --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,null --@JobScheduleId INT
	,'like' --@JobScheduleNameCompareLogic VARCHAR(8)  -- only '=','<>,'LIKE', 'NOT LIKE', 'IN', 'NOT IN'
	,'%windows service heartbeat%' --@JobScheduleName VARCHAR(100)
	,null --@JobId INT
	,null --@NextStartCompareLogic VARCHAR(8)  -- only '=', '<', '>', '<=', '>='
	,null --@NextStart DATETIME
	,null --@Active BIT
	,null --@UpdateUserId INT
	,null --@CreateUserId INT

select * from [Service].JobSchedules
EXEC [Service].[GetJobSchedulesDetails]
-- select * from [Service].[JobScheduleTypes]
/*
update [Service].JobSchedules
set NextStart = getdate()
where JobscheduleId=16
*/
-- EXEC [Service].[GetRunNowJobs]

--SELECT j.JobId, j.JobFriendlyName, j.ExecPath + '\' + j.ExecFile, j.Active
--		, js.JobScheduleId, js.JobScheduleName, js.NextStart
--		, jsh.JobScheduleHistoryId, jsh.ExecuteDateTimeStart, jsh.ExecuteDateTimeEnd, jsh.ExecuteUserName, jsh.ResultText
--FROM [Service].Jobs j
--	LEFT OUTER JOIN [Service].JobSchedules js ON j.JobId=js.JobId
--	LEFT OUTER JOIN [Service].JobScheduleHistory jsh ON js.JobScheduleId=jsh.JobScheduleId
--ORDER BY jsh.ExecuteDateTimeStart DESC




