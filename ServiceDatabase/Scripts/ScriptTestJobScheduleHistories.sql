---------------------------------------------------------------------------------------------------------- 
-- JobScheduleHistory database components testing 
-- Create Date: 2023.08.31
-- Created By : Triadcore (ACB)
----------------------------------------------------------------------------------------------------------

USE KvmConsulting
GO 

------------------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Service].[JobScheduleHistories] 
*/



------------------------------------------------------------------------------------------------------------
EXEC [Service].[GetJobScheduleHistories] 
	 NULL --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,NULL --@JobScheduleHistoryId INT
	,NULL --@CreateUserId INT
	,NULL --@UpdateUserId INT
	,NULL --@JobScheduleId INT
	,NULL --@ResultCode INT
	,NULL --@ResultTextCompareLogic VARCHAR(10)
	,NULL --@ResultText VARCHAR(1000)

------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[UpdateJobScheduleHistory]
	NULL --@JobScheduleHistoryId INT
	,0 --@JobScheduleId INT
	,'1900-01-01 00:00:00' --@ExecuteDateTimeStart DATETIME
	,NULL --@ExecuteDateTimeEnd DATETIME
	,'' --@ExecuteUserName VARCHAR(100)
	,'' --@ExecuteParams VARCHAR(1000)
	,0 --@ResultCode INT
	,'' --@ResultText VARCHAR(1000)
	,'' --@Note VARCHAR(2000)
	,NULL --@UpdateUserId INT
*/

------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[SetJobScheduleHistoryActivation] NULL, 0, NULL
*/



------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[DeleteJobScheduleHistory] NULL, NULL
SELECT * FROM Base.DeleteLogs ORDER BY DeleteLogId DESC
*/

------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[GetJobScheduleHistoryUpdateHistory] null
*/

------------------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[JobScheduleHistories] 
SET SortText = [<ColumnName>]
WHERE SortText IS NULL OR SortText=''

UPDATE[Service].[JobScheduleHistories] 
SET UpdateMarkup = ''
*/

------------------------------------------------------------------------------------------------------------
/*
select * from Base.ParseUpdateMarkup('<ShDesc old="" new="new" date="2023-04-26T15:35:49" userId="26">')
*/
