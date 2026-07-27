IF ( Base.TableExists('Service','JobSchedules')=1 ) BEGIN

	DECLARE @LoaderUserId INT = NULL
	DECLARE @JobName VARCHAR(100) = 'Test-Job'
	DECLARE @JobId INT = NULL
	DECLARE @JobScheduleId INT = NULL
	DECLARE @JobScheduleName VARCHAR(100) = NULL
	DECLARE @JobScheduleIntervalId INT = NULL
	DECLARE @JobScheduleTypeName VARCHAR(100) = NULL
	DECLARE @JobScheduleDescription VARCHAR(1000) = NULL
	DECLARE @JobScheduleTypeId INT = NULL
	DECLARE @JobScheduleExistsFlag INT = NULL

	SELECT @LoaderUserId=UserId FROM Base.Users WHERE UserName='SysDataLoader'
	
	------------------------------------------------------------------------------------------------------------------------------------
	-- Job that executes on a specific day of the week (Sunday-Saturday) at a specified time.
	------------------------------------------------------------------------------------------------------------------------------------
	/*
	SET @JobScheduleTypeName = 'DayInterval'
	SET @JobScheduleName = @JobName + ' [' + @JobScheduleTypeName  + '-Test]'
	SET @JobScheduleDescription = @JobScheduleName + ' For testing only'
	SET @JobId = NULL
	SET @JobScheduleId = NULL
	SET @JobScheduleTypeId = NULL
	SET @JobScheduleExistsFlag = NULL
	SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
	SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
	SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
	IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
		EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-11', NULL, NULL,    4, NULL, 1230, NULL, @LoaderUserId, ''
	END
	*/

	------------------------------------------------------------------------------------------------------------------------------------
	-- Job that executes every 2nd Thursday of the month (2nd Tues, 3rd Thurs, 1st Sat, etc.) at a 5am.
	------------------------------------------------------------------------------------------------------------------------------------
	/*
	SET @JobScheduleTypeName = 'DayOccurrence'
	SET @JobScheduleName =  @JobName + ' [' + @JobScheduleTypeName  + '-Test]'
	SET @JobScheduleDescription = @JobScheduleName + ' For testing only'
	SET @JobId = NULL
	SET @JobScheduleId = NULL
	SET @JobScheduleTypeId = NULL
	SET @JobScheduleExistsFlag = NULL
	SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
	SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
	SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
	IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
		EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-12', NULL,  2  ,    5, NULL, 0500, NULL, @LoaderUserId, ''
	END
	*/

	--------------------------------------------------------------------------------------------------------------------------------------
	---- Job that executes last specified day of week of the month (last Tues, last Thurs, last Sat, etc.) at 11:45pm.
	--------------------------------------------------------------------------------------------------------------------------------------
	/*
	SET @JobScheduleTypeName = 'LastDayOccurrence'
	SET @JobScheduleName =  @JobName + ' [' + @JobScheduleTypeName  + '-Test]'
	SET @JobScheduleDescription = @JobScheduleName + ' For testing only'
	SET @JobId = NULL
	SET @JobScheduleId = NULL
	SET @JobScheduleTypeId = NULL
	SET @JobScheduleExistsFlag = NULL
	SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
	SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
	SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
	IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
		EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2018-06-30', NULL, NULL, 4, NULL, 2345, NULL, @LoaderUserId, ''
	END
	*/

	--------------------------------------------------------------------------------------------------------------------------------------
	---- Job that executes on the Nth day of the month at a specified time.
	--------------------------------------------------------------------------------------------------------------------------------------
	/*
	SET @JobScheduleTypeName = 'DateInterval'
	SET @JobScheduleName =  @JobName + ' [' + @JobScheduleTypeName  + '-Test]'
	SET @JobScheduleDescription = @JobScheduleName + ' For testing only'
	SET @JobId = NULL
	SET @JobScheduleId = NULL
	SET @JobScheduleTypeId = NULL
	SET @JobScheduleExistsFlag = NULL
	SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
	SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
	SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
	IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
		EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-12', NULL, NULL, NULL, 12  , 0915, NULL, @LoaderUserId, ''
	END
	*/

	--------------------------------------------------------------------------------------------------------------------------------------
	---- Job that executes on the Mth month at a specified date and time.
	--------------------------------------------------------------------------------------------------------------------------------------
	/*
	SET @JobScheduleTypeName = 'MonthInterval'
	SET @JobScheduleName =  @JobName + ' [' + @JobScheduleTypeName  + '-Test]'
	SET @JobScheduleDescription = @JobScheduleName + ' For testing only'
	SET @JobId = NULL
	SET @JobScheduleId = NULL
	SET @JobScheduleTypeId = NULL
	SET @JobScheduleExistsFlag = NULL
	SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
	SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
	SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
	IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
		EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-12',  7  , NULL, NULL, 13  , 0915, NULL, @LoaderUserId, ''
	END
	*/

	--------------------------------------------------------------------------------------------------------------------------------------
	---- Job that executes on the Mth month at the Nth day of week at a specific time (3rd Friday of July at noon)
	--------------------------------------------------------------------------------------------------------------------------------------
	/*
	SET @JobScheduleTypeName = 'MonthDayInterval'
	SET @JobScheduleName =  @JobName + ' [' + @JobScheduleTypeName  + '-Test]'
	SET @JobScheduleDescription = @JobScheduleName + ' For testing only'
	SET @JobId = NULL
	SET @JobScheduleId = NULL
	SET @JobScheduleTypeId = NULL
	SET @JobScheduleExistsFlag = NULL
	SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
	SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
	SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
	IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
		EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-12',   7,    3,  5  , NULL, 0000, NULL, @LoaderUserId, ''
	END
	*/

	--------------------------------------------------------------------------------------------------------------------------------------
	---- Job that executes on the Mth month at the specified date at a specific time (July 23 @1pm)
	--------------------------------------------------------------------------------------------------------------------------------------
	/*
	SET @JobScheduleTypeName = 'MonthDateInterval'
	SET @JobScheduleName =  @JobName + ' [' + @JobScheduleTypeName  + '-Test]'
	SET @JobScheduleDescription = @JobScheduleName + ' For testing only'
	SET @JobId = NULL
	SET @JobScheduleId = NULL
	SET @JobScheduleTypeId = NULL
	SET @JobScheduleExistsFlag = NULL
	SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
	SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
	SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
	IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
		EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-12',   7, NULL, NULL,   23, 1300, NULL, @LoaderUserId, ''
	END
	*/

	--------------------------------------------------------------------------------------------------------------------------------------
	---- Job that executes on the last day of the month at a specific time (@9am)
	--------------------------------------------------------------------------------------------------------------------------------------
	/*
	SET @JobScheduleTypeName = 'LastDayOfMonth'
	SET @JobScheduleName =  @JobName + ' [' + @JobScheduleTypeName  + '-Test]'
	SET @JobScheduleDescription = @JobScheduleName + ' For testing only'
	SET @JobId = NULL
	SET @JobScheduleId = NULL
	SET @JobScheduleTypeId = NULL
	SET @JobScheduleExistsFlag = NULL
	SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
	SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
	SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
	IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
		EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-31', NULL, NULL, NULL, NULL, 0900, NULL,  @LoaderUserId, ''
	END
	*/

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

