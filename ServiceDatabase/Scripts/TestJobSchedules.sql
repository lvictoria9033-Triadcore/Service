
-- SELECT * FROM [Service].Jobs
-- SELECT * FROM [Service].JobScheduleTypes
/*
EXEC [Service].[DeleteJobSchedule] 1, 2
select * from Base.DeleteLog order by CreateDate desc
*/
/*
EXEC [Service].[SetJobScheduleNextStart] NULL, 2
*/
/*
EXEC [Service].[UpdateJobSchedule]
	null --@JobScheduleId INT
	,'URI Heartbeat Checks' --@JobScheduleName VARCHAR(100)
	,'Schedule for the job that checks if a website is alive.' --@Description VARCHAR(1000)
	,1 --@JobScheduleTypeId INT
	,6  --@JobId INT
	,null --@BaseDate DATETIME
	,null --@Month INT     -- month index; 1-12
	,60 --@Interval INT  -- minutes
	,null --@Day INT       -- day of week index; 1-7; M-S
	,null --@Date INT      -- date of month
	,null --@Time INT      -- 24hr format without colon (:)
	,null --@IsRecurring BIT 
	,null --@RunAsUser VARCHAR(100)
	,null --@RunAsPassword VARCHAR(200)
	,null --@UpdateUserId INT
	,'LV - Manual Add' --@RecordComment VARCHAR(1000)
*/
EXEC [Service].[GetJobSchedulesDetails]

/*
EXEC [Service].[UpdateJobScheduleHistory]
	NULL --@JobScheduleHistoryId INT
	,6 --@JobScheduleId INT
	,'2018-07-09 15:00:03' --@ExecuteDateTimeStart DATETIME
	,'2018-07-09 15:08:49' --@ExecuteDateTimeEnd DATETIME
	,'SysUser' --@ExecuteUserName VARCHAR(100)
	,NULL --@ExecuteParams VARCHAR(1000)
	,0 --@ResultCode INT
	,'TEst Test Test Process ran with no errors.' --@ResultText INT
	,'lv test' --@Note VARCHAR(2000)
	,2 --@UpdateUserId INT
	,NULL --@RecordComment VARCHAR(1000)
SELECT * FROM [Service].[JobScheduleHistory]
*/

select j.JobId, j.JobName, j.ExecPath, j.ExecFile
		, js.NextStart
from [Service].Jobs j
	left outer join [Service].JobSchedules js on j.JobId=js.JobId
order by j.JobName