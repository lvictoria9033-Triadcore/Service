/*
  Service.UpdateJobSchedule Params
	@JobScheduleId INT
	,@JobScheduleName VARCHAR(100)
	,@Description VARCHAR(1000)
	,@JobScheduleTypeId INT
	,@JobId INT
	,@BaseDate DATETIME
	,@Month INT     -- month index; 1-12
	,@Interval INT  -- minutes
	,@Day INT       -- day of week index; 1-7; M-S
	,@Date INT      -- date of month
	,@Time INT      -- 24hr format without colon (:)
	,@IsRecurring BIT 
	,@RunAsUser VARCHAR(100)
	,@RunAsPassword VARCHAR(200)
	,@UpdateUserId INT
	,@RecordComment VARCHAR(1000)
*/

IF ( Base.TableExists('Service','JobSchedules')=1 ) BEGIN

	DECLARE @LoaderUserId INT = NULL
	DECLARE @JobName VARCHAR(100) = NULL
	DECLARE @JobId INT = NULL
	DECLARE @JobScheduleId INT = NULL
	DECLARE @JobScheduleName VARCHAR(100) = NULL
	DECLARE @JobScheduleDescription VARCHAR(1000) = NULL
	DECLARE @JobScheduleIntervalId INT = NULL
	DECLARE @JobScheduleTypeName VARCHAR(100) = NULL
	DECLARE @JobScheduleTypeId INT = NULL
	DECLARE @JobScheduleExistsFlag INT = NULL

	SELECT @LoaderUserId=UserId FROM Base.Users WHERE UserName='SysDataLoader'
	
	IF ( (SELECT COUNT(*) FROM [Service].JobSchedules)=0 ) BEGIN
		DBCC CHECKIDENT('[Service].JobSchedules', RESEED, 1)
	END

	------------------------------------------------------------------------------------------------------------------------------------
	-- Run order tracking API heartbeat check every 60 minutes.
	------------------------------------------------------------------------------------------------------------------------------------
	SET @JobName = 'JobTest'
	SET @JobScheduleTypeName = 'TimeInterval'
	SET @JobScheduleName = 'Test Job'
	SET @JobScheduleDescription = 'Fake job.'
	SET @JobId = NULL
	SET @JobScheduleId = NULL
	SET @JobScheduleTypeId = NULL
	SET @JobScheduleExistsFlag = NULL
	SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
	SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
	SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
	IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
		EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2005-01-01', NULL, 60, NULL, NULL, 0000, NULL, NULL, NULL, @LoaderUserId, ''
	END

END

------------------------------------------------------------------------------------------------------------------------------------
select j.JobId, j.JobName
		, js.JobScheduleId, js.JobScheduleName, js.[Description]
		, jst.JobScheduleTypeName
		, js.[Month], js.Interval, js.[Day], js.[Date], js.[Time], js.IsRecurring, jst.[InstanceDescription], jst.[Description]
from [Service].Jobs j
	left outer join [Service].JobSchedules js on j.JobId=js.JobId
	left outer join [Service].JobScheduleTypes jst on js.JobScheduleTypeId=jst.JobScheduleTypeId
order by j.JobName, js.JobScheduleName
