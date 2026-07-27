------------------------------------------------------------------------------------------------------------------------------------
-- Builds FedEx carrier API queries for several specific times.
-- Done separately from the other job schedule builder script because of the schedule specifics of the FedEx schedules.
------------------------------------------------------------------------------------------------------------------------------------
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
-- @JobScheduleId, @JobScheduleName, @Description           , @JobScheduleTypeId, @JobId, @BaseDate   , @Month, @Interval, @Day, @Date, @Time, @IsRecurring, @RunAsUser, @RunAsPassword, @UpdateUserId , @RecordComment

IF ( Base.TableExists('Service','JobSchedules')=0 ) BEGIN
	RAISERROR('Table Service.JobSchedules not found', 11, 1)
	RETURN
END

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

SET @JobName = 'OrderTrackCarrierQueryFedEx'
SET @JobScheduleTypeName = 'DailyInterval'

UPDATE [Service].JobSchedules SET Active=0 WHERE JobScheduleName='FedEx API Bulk Order Tracking Updates'

------------------------------------------------------------------------------------------------------------------------------------
-- 1am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 0100'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 1am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 100, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 3am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 0300'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 3am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 300, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 5am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 0500'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 5am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 500, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 7am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 0700'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 7am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 700, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 9am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 0900'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 9am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 900, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 11am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 1100'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 11am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 1100, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 1pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 1300'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 1pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 1300, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 3pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 1500'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 3pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 1500, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 5pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 1700'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 5pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 1700, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 7pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 1900'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 7pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 1900, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 9pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 2100'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 9pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 2100, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 11pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates - 2300'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API at 11pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 2300, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END


------------------------------------------------------------------------------------------------------------------------------------
select j.JobId, j.JobName
		, js.JobScheduleId, js.JobScheduleName, js.[Description] AS [ScheduleDescription]
		, jst.JobScheduleTypeName
		, js.[Month], js.Interval, js.[Day], js.[Date], js.[Time], js.IsRecurring, js.Active
		, jst.[InstanceDescription]
		, jst.[Description] AS [ScheduleTypeDescription]
		, REPLACE(j.ExecPath, '{BasePath}', SUBSTRING(ISNULL(nm.[Value],' '), 1, LEN(nm.[Value]))) + '\' + j.ExecFile AS [ExecFullPath]
		, js.RecordComment
from [Service].Jobs j
	left outer join [Service].JobSchedules js on j.JobId=js.JobId
	left outer join [Service].JobScheduleTypes jst on js.JobScheduleTypeId=jst.JobScheduleTypeId
	left outer join Base.NameValues nm on nm.[Name]='JobBasePath'
where j.JobName=@JobName
order by j.JobName, js.[Time], js.JobScheduleName
