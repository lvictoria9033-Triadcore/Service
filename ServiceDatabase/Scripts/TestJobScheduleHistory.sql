/*
 delete from [Service].JobScheduleHistory where JobScheduleId<853
 delete from Base.MessageLog 
 */

 ----------------------------------------------------------------------------------
 -- select * from [Service].JobSchedules
 ----------------------------------------------------------------------------------
EXEC [Service].[GetJobSchedulesHistories]
	null --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,null --@JobScheduleHistoryId INT
	,null --@JobScheduleId INT
	,null --@ResultCode INT
	,null --@ResultTextCompareLogic VARCHAR(8)  -- only '=','<>,'LIKE', 'NOT LIKE'
	,null --@ResultText VARCHAR(1000)
	,null --@Active BIT
	,null --@UpdateUserId INT
	,null --@CreateUserId INT

----------------------------------------------------------------------------------
-- select * from [Service].JobScheduleHistory
----------------------------------------------------------------------------------
-- select * from Base.MessageLog order by EventDateTime desc


