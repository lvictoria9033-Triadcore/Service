------------------------------------------------------------------------------------------------------------------------------------
-- Builds USPS carrier API queries for several specific times.
-- Done separately from the other job schedule builder script because of the schedule specifics of the USPS schedules.
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

SET @JobName = 'OrderTrackCarrierQueryUSPS'
SET @JobScheduleTypeName = 'DailyInterval'

UPDATE [Service].JobSchedules SET Active=0 WHERE JobScheduleName='USPS API Bulk Order Tracking Updates'

------------------------------------------------------------------------------------------------------------------------------------
-- 1:30am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 0130'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 1:30am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 130, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 3:30am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 0330'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 3:30am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 330, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 5:30am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 0530'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 5:30am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 530, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 7:30am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 0730'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 7:30am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 730, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 9:30am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 0930'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 9:30am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 930, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 11:30am.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 1130'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 11:30am.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 1130, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 1:30pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 1330'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 1:30pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 1330, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 3:30pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 1530'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 3:30pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 1530, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 5:30pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 1730'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 5:30pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 1730, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 7:30pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 1930'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 7:30pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 1930, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 9:30pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 2130'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 9:30pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 2130, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- 11:30pm.
-----------------------------------------------------------------------------------------------------------------------------------
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates - 2330'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API at 11:30pm.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 2330, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
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
