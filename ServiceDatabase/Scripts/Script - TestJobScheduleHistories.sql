--------------------------------------------------------------------------------------------------------------------------------- 
-- JobScheduleHistory database components testing 
-- Create Date: 2026.10.30
-- Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------------------

-- General use SELECT -------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Service].[JobScheduleHistories] WITH (NOLOCK) ORDER BY [JobScheduleHistoryId] DESC
*/

-- Get ----------------------------------------------------------------------------------------------------------------
EXEC [Service].[GetJobScheduleHistories] 
	 NULL --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,NULL --@JobScheduleHistoryId INT
	,NULL -- @CreateDate DATETIME
	,NULL -- @CreateUserId INT
	,NULL -- @UpdateDate DATETIME
	,NULL -- @UpdateUserId INT
	,NULL -- @Active BIT
	,NULL -- @JobScheduleId INT -- Fkey
	,NULL -- @ExecuteDateTimeStartCompareLogic VARCHAR(10)
	,NULL -- @ExecuteDateTimeStart DATETIME
	,NULL -- @ExecuteDateTimeEndCompareLogic VARCHAR(10)
	,NULL -- @ExecuteDateTimeEnd DATETIME
	,NULL -- @ExecuteUserNameCompareLogic VARCHAR(10)
	,NULL -- @ExecuteUserName VARCHAR(100)
	,NULL -- @ResultCode INT
	,NULL -- @ResultTextCompareLogic VARCHAR(10)
	,NULL -- @ResultText VARCHAR(1000)

-- Update -------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[UpdateJobScheduleHistory]
	 NULL --@JobScheduleHistoryId INT
	,NULL -- @JobScheduleId INT -- Fkey
	,NULL -- @ExecuteDateTimeStart DATETIME
	,NULL -- @ExecuteDateTimeEnd DATETIME
	,NULL -- @ExecuteUserName VARCHAR(100)
	,NULL -- @ExecuteParams VARCHAR(1000)
	,NULL -- @ResultCode INT
	,NULL -- @ResultText VARCHAR(1000)
	,NULL -- @Note VARCHAR(2000)
	,NULL --@UpdateUserId INT
*/

--- Get Update History from UpdateMarkup --------------------------------------------------------------------------------
/*
EXEC [Service].[GetJobScheduleHistoryUpdateHistory] null
*/

-- Set Activation -------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[SetJobScheduleHistoryActivation] NULL, 0, NULL
*/

-- Set Default ----------------------------------------------------------------------------------------------------------
/*

*/

-- Delete ---------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[DeleteJobScheduleHistory] NULL, '[ACB Testing]', NULL
SELECT * FROM [Base].[DeleteLogs] ORDER BY [DeleteLogId] DESC
*/

-- Update SortText ------------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[JobScheduleHistories] 
SET [SortText] = [<ColumnName>]
WHERE [SortText] IS NULL OR SortText=''
*/

-- SortText testing  -------------------------------------------------------------------------------------------------
/*

*/

-- Update UpdateMarkup --------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[JobScheduleHistories] 
SET [UpdateMarkup] = '<[Column] old="[OldValue]" new="[NewValue]" date="2000-01-01T00:00:01" userId="1" >' + [UpdateMarkup]
WHERE JobScheduleHistoryId = 1
*/

-- UpdateMarkup sample --------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Base].[ParseUpdateMarkup]('<ShDesc old="" new="new" date="2023-04-26T15:35:49" userId="26">')
*/
