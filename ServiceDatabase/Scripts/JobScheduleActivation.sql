
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

EXEC [Service].[SetJobScheduleActivation]
			 1 --@JobScheduleId INT
			,0 --@Active BIT 
			,2 --@UpdateUserId INT


EXEC [Service].[GetJobSchedulesDetails]