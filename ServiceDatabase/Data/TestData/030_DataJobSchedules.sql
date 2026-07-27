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

------------------------------------------------------------------------------------------------------------------------------------
-- Run ESP windows service "I'm alive" notification daily at 12:15am.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobHeartbeatWinService'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'ESP Windows Service Heartbeat Notification'
SET @JobScheduleDescription = 'Job to indicate that the ESP Windows service is running.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null         , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  0000,            1, NULL       , NULL          , @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run UPS carrier API queries nightly at 1am.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'OrderTrackCarrierQueryUPS'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'UPS API Bulk Order Tracking Updates'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the UPS tracking API.'
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
-- Run FedEx carrier API queries nightly at 2am.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'OrderTrackCarrierQueryFedEx'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'FedEx API Bulk Order Tracking Updates'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the FedEx tracking API.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, NULL, NULL, NULL, 200, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run USPS carrier API queries nightly at 3am.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'OrderTrackCarrierQueryUSPS'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'USPS API Bulk Order Tracking Updates'
SET @JobScheduleDescription = 'Scheduled job for order tracking updates via the USPS tracking API.'
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
-- Run ESP windows service ESP statistics notification daily at 6am.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'EspSummaryStatsNotification'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'ESPStatsNotificationJob'
SET @JobScheduleDescription = 'Job to report current ESP statistics.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null         , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  0600,            1, NULL       , NULL          , @LoaderUserId, 'Created by DB auto-build'
							--		 @JobScheduleId,@JobScheduleName, @Description           , @JobScheduleTypeId, @JobId,  @BaseDate  , @Month, @Interval, @Day, @Date, @Time, @IsRecurring, @RunAsUser, @RunAsPassword ,@UpdateUserId ,@RecordComment
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run ESP Web API heartbeat check every 60 minutes.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobHeartbeatEspWebApiMain'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'ESP Web API Heartbeat Check'
SET @JobScheduleDescription = 'Job to run process to check that the ESP Web API is running by polling the Main{} controller.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, 60, NULL, NULL, 0045, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run order import job every 10 minutes.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobOrderImport'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'Order Import'
SET @JobScheduleDescription = 'Job to import orders from XML files in a specified staging directory.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, 10, NULL, NULL, 0000, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run shipment import job every 20 minutes (gives time for order import to import orders associated with shipments).
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobShipmentImport'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'Shipment Import'
SET @JobScheduleDescription = 'Job to import shipments and confirmations from XML files in a specified staging directory.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2020-01-01', NULL, 20, NULL, NULL, 0000, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run SDI Excel order import job every 10 minutes.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobOrderImport2'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'Order Import 2 - SDI CSV'
SET @JobScheduleDescription = 'Job to import SDI orders from Excel files in a specified staging directory.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, 10, NULL, NULL, 0000, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run ParseHub import daily at 3am.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobParseHubImport'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'JobParseHubImport'
SET @JobScheduleDescription = 'Job to run the ParseHub data import.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null         , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  0300,            1, NULL       , NULL          , @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run ParseHub import daily at 1am.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobParseHubProjectRuns'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'JobParseHubProjectRuns'
SET @JobScheduleDescription = 'Job to run ParseHub projects.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null         , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  0100,            1, NULL       , NULL          , @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run order stats update every 60 minutes.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobOrderStatsUpdate'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'Order Status Periodic Update'
SET @JobScheduleDescription = 'Job to add current data to the order stats/metrics data.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL,   60, NULL, NULL, 0000, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run ESP user order stats update every 15 minutes.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'EspUserOrderStatsUpdate'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'ESP User-Order Statistics Update'
SET @JobScheduleDescription = 'Job to update the user-order statistics.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, 15, NULL, NULL, 0005, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run ESP admin stats update every 6 hours.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'EspAdminStatsUpdate'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'ESP Administrative Statistics Update'
SET @JobScheduleDescription = 'Job to update the ESP admin statistics.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, 360, NULL, NULL, 0010, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run URI checker every 4 hours.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'UriChecker'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'URI Heartbeat Checker'
SET @JobScheduleDescription = 'Job to check if a web site/resource is up and running'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null, @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL, 240, NULL, NULL, 0035, NULL, NULL, NULL, @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run supplier/rep confirmation & tracking request email sender daily at 9am (the 9am transmit).
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobConfirmTrackInfoRequestEmail'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'JobConfirmTrackInfoRequestEmailRun0900'
SET @JobScheduleDescription = '9am job to send emails to supplier reps requesting confirmation and tracking information.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null          , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  0900,            1, NULL       , NULL          , @LoaderUserId, 'Created by DB auto-build'
END
------------------------------------------------------------------------------------------------------------------------------------
-- Run supplier/rep confirmation & tracking request email sender daily at 10am (the 10am transmit).
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobConfirmTrackInfoRequestEmail'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'JobConfirmTrackInfoRequestEmailRun1000'
SET @JobScheduleDescription = '10am job to send emails to supplier reps requesting confirmation and tracking information.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null          , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  1000,            1, NULL       , NULL          , @LoaderUserId, 'Created by DB auto-build'
END
------------------------------------------------------------------------------------------------------------------------------------
-- Run supplier/rep confirmation & tracking request email sender daily at 12pm (the 12pm transmit).
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobConfirmTrackInfoRequestEmail'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'JobConfirmTrackInfoRequestEmailRun1200'
SET @JobScheduleDescription = '12pm job to send emails to supplier reps requesting confirmation and tracking information.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null          , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  1200,            1, NULL       , NULL         , @LoaderUserId, 'Created by DB auto-build'
END
------------------------------------------------------------------------------------------------------------------------------------
-- Run supplier/rep confirmation & tracking request email sender daily at 3pm (the 3pm transmit).
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobConfirmTrackInfoRequestEmail'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'JobConfirmTrackInfoRequestEmailRun1500'
SET @JobScheduleDescription = '3pm job to send emails to supplier reps requesting confirmation and tracking information.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null          , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  1500,            1, NULL       , NULL         , @LoaderUserId, 'Created by DB auto-build'
END
------------------------------------------------------------------------------------------------------------------------------------
-- Run *RUSH* supplier/rep confirmation & tracking request email sender every 60 min.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobConfirmTrackInfoRequestEmail-R'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'JobConfirmTrackInfoRequestEmailRun-R'
SET @JobScheduleDescription = 'Job to send emails to supplier reps requesting confirmation and tracking information for RUSH orders.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null          , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  , 60       , NULL, NULL , 0030 , NULL        , NULL      , NULL          , @LoaderUserId, 'Created by DB auto-build'
	--								 @JobScheduleId, @JobScheduleName, @Description           , @JobScheduleTypeId, @JobId, @BaseDate   , @Month, @Interval, @Day, @Date, @Time, @IsRecurring, @RunAsUser, @RunAsPassword, @UpdateUserId , @RecordComment
END
------------------------------------------------------------------------------------------------------------------------------------
-- Run *EMERGENCY* supplier/rep confirmation & tracking request email sender every 15 min.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobConfirmTrackInfoRequestEmail-E'
SET @JobScheduleTypeName = 'TimeInterval'
SET @JobScheduleName = 'JobConfirmTrackInfoRequestEmailRun-E'
SET @JobScheduleDescription = 'Job to send emails to supplier reps requesting confirmation and tracking information for EMERGENCY orders.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null          , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  , 15       , NULL, NULL , 0030 , NULL        , NULL      , NULL          , @LoaderUserId, 'Created by DB auto-build'
	--								 @JobScheduleId, @JobScheduleName, @Description           , @JobScheduleTypeId, @JobId, @BaseDate   , @Month, @Interval, @Day, @Date, @Time, @IsRecurring, @RunAsUser, @RunAsPassword, @UpdateUserId , @RecordComment
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run data purge daily at 12:30am.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobEspDataPurge'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'JobEspDataPurge'
SET @JobScheduleDescription = 'Job to run the ESP data purge process.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null         , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  0030,            1, NULL       , NULL          , @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run close order track record for closed orders daily at 10pm.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobClosedOrderCloseOrderTrack'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'JobClosedOrderCloseOrderTrack'
SET @JobScheduleDescription = 'Job to run the task to close open order track records associated with closed/delivered orders.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null         , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  2200,            1, NULL       , NULL          , @LoaderUserId, 'Created by DB auto-build'
END

------------------------------------------------------------------------------------------------------------------------------------
-- Run close order track record for order track records with invalid/missing tracking indentifiers daily at 9:50pm.
------------------------------------------------------------------------------------------------------------------------------------
SET @JobName = 'JobInvalidMissingTNCloseOrderTrack'
SET @JobScheduleTypeName = 'DailyInterval'
SET @JobScheduleName = 'JobInvalidMissingTNCloseOrderTrack'
SET @JobScheduleDescription = 'Job to run tasks to close open order track records where the tracking identifier is invalid or missing from the carrier API.'
SET @JobId = NULL
SET @JobScheduleId = NULL
SET @JobScheduleTypeId = NULL
SET @JobScheduleExistsFlag = NULL
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName=@JobName
SELECT @JobScheduleId=JobScheduleId FROM [Service].JobSchedules WHERE JobScheduleName=@JobScheduleName
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName=@JobScheduleTypeName
IF ( (@JobId IS NOT NULL) AND (@JobScheduleId IS NULL) ) BEGIN
	EXEC [Service].UpdateJobSchedule null         , @JobScheduleName, @JobScheduleDescription, @JobScheduleTypeId, @JobId, '2019-01-01', NULL  ,      NULL, NULL, NULL ,  2150,            1, NULL       , NULL          , @LoaderUserId, 'Created by DB auto-build'
END


------------------------------------------------------------------------------------------------------------------------------------
select j.JobId, j.JobName
		, js.JobScheduleId, js.JobScheduleName, js.[Description] AS [ScheduleDescription]
		, jst.JobScheduleTypeName
		, js.[Month], js.Interval, js.[Day], js.[Date], js.[Time], js.IsRecurring
		, jst.[InstanceDescription]
		, jst.[Description] AS [ScheduleTypeDescription]
		, REPLACE(j.ExecPath, '{BasePath}', SUBSTRING(ISNULL(nm.[Value],' '), 1, LEN(nm.[Value]))) + '\' + j.ExecFile AS [ExecFullPath]
		, js.RecordComment
from [Service].Jobs j
	left outer join [Service].JobSchedules js on j.JobId=js.JobId
	left outer join [Service].JobScheduleTypes jst on js.JobScheduleTypeId=jst.JobScheduleTypeId
	left outer join Base.NameValues nm on nm.[Name]='JobBasePath'
order by j.JobName, js.JobScheduleName
