
DECLARE @JobScheduleName VARCHAR(100) = 'Windows Service Heartbeat Notification'
DECLARE @JobScheduleId INT = -1
DECLARE @UpdateUserId INT = -1
DECLARE @JobScheduleTypeId INT = -1
DECLARE @JobId INT = -1

SELECT @UpdateUserId=UserId FROM Base.Users WHERE UserName='SysDataLoader'
SELECT @JobScheduleTypeId=JobScheduleTypeId FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='TimeInterval'
SELECT @JobId=JobId FROM [Service].Jobs WHERE JobName='JobHeartbeatWinService'


IF ( NOT EXISTS(SELECT * FROM [Service].[JobSchedules] WHERE [JobScheduleName]=@JobScheduleName) ) BEGIN

	EXEC [Service].[UpdateJobSchedule]
		 NULL --@JobScheduleId INT
		,@JobScheduleName --@JobScheduleName VARCHAR(100)
		,'Schedule for the job to indicate that the job server Windows service is still running.' --@Description VARCHAR(1000)
		,@JobScheduleTypeId --@JobScheduleTypeId INT
		,@JobId --@JobId INT
		,'2024-01-01 00:00:00.000' --@BaseDate DATETIME
		,NULL --@Month INT     
		,60 --@Interval INT  -- runs every 60 mins
		,NULL --@Day INT       
		,NULL --@Date INT      
		,NULL --@Time INT      
		,1 --@IsRecurring BIT 
		,'' --@RunAsUser VARCHAR(100)
		,'' --@RunAsPassword VARCHAR(200)
		,@UpdateUserId --@UpdateUserId INT
		,'Created manually by LV' --@RecordComment VARCHAR(1000)

		SELECT @JobScheduleId=JobScheduleId FROM [Service].[JobSchedules] WHERE [JobScheduleName]=@JobScheduleName
		EXEC [Service].[SetJobScheduleActivation]
			 @JobScheduleId --@JobScheduleId INT
			,0 --@Active BIT 
			,@UpdateUserId --@UpdateUserId INT

END

EXEC [Service].[GetJobSchedules]
	 null --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,null --@JobScheduleId INT
	,null --@JobScheduleNameCompareLogic VARCHAR(8)  -- only '=','<>,'LIKE', 'NOT LIKE', 'IN', 'NOT IN'
	,null --@JobScheduleName VARCHAR(100)
	,null --@JobId INT
	,null --@NextStartCompareLogic VARCHAR(8)  -- only '=', '<', '>', '<=', '>='
	,null --@NextStart DATETIME
	,null --@Active BIT
	,null --@UpdateUserId INT
	,null --@CreateUserId INT

EXEC [Service].[GetJobSchedulesDetails]