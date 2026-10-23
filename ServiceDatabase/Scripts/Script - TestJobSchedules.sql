--------------------------------------------------------------------------------------------------------------------------------- 
-- JobSchedule database components testing 
-- Create Date: 2026.10.23
-- Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------------------

-- General use SELECT -------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Service].[JobSchedules] WITH (NOLOCK) ORDER BY [JobScheduleId] DESC
*/
/*
UPDATE [Service].[JobSchedules]
SET [RunAsUser]='booboo'
	,[RunAsPassword]='aloofa'
WHERE [JobScheduleId]=9
*/

-- Get ----------------------------------------------------------------------------------------------------------------
EXEC [Service].[GetJobSchedules] 
	 NULL --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,NULL --@JobScheduleId INT
	,NULL -- @CreateDate DATETIME
	,NULL -- @CreateUserId INT
	,NULL -- @UpdateDate DATETIME
	,NULL -- @UpdateUserId INT
	,NULL -- @Active BIT
	,NULL -- @JobScheduleNameCompareLogic VARCHAR(10)
	,NULL -- @JobScheduleName VARCHAR(100)
	,NULL -- @JobId INT -- Fkey
	,NULL -- @JobScheduleTypeId INT -- Fkey

-- Update -------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[UpdateJobSchedule]
	 NULL --@JobScheduleId INT
	,NULL -- @JobScheduleName VARCHAR(100)
	,NULL -- @Description VARCHAR(1000)
	,NULL -- @JobId INT -- Fkey
	,NULL -- @JobScheduleTypeId INT -- Fkey
	,NULL -- @BaseDateTime DATETIME
	,NULL -- @NextStart DATETIME
	,NULL -- @Interval INT
	,NULL -- @Date INT
	,NULL -- @Month INT
	,NULL -- @Day INT
	,NULL -- @Time INT
	,NULL -- @IsRecurring BIT
	,NULL -- @RunAsUser VARCHAR(100)
	,NULL -- @RunAsPassword VARCHAR(200)
	,NULL --@UpdateUserId INT
*/

--- Get Update History from UpdateMarkup --------------------------------------------------------------------------------
/*
EXEC [Service].[GetJobScheduleUpdateHistory] null
*/

-- Set Activation -------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[SetJobScheduleActivation] NULL, 0, NULL
*/

-- Set Default ----------------------------------------------------------------------------------------------------------
/*

*/

-- Delete ---------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[DeleteJobSchedule] NULL, '[ACB Testing]', NULL
SELECT * FROM [Base].[DeleteLogs] ORDER BY [DeleteLogId] DESC
*/

-- Update SortText ------------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[JobSchedules] 
SET [SortText] = [<ColumnName>]
WHERE [SortText] IS NULL OR SortText=''
*/

-- SortText testing  -------------------------------------------------------------------------------------------------
/*

*/

-- Update UpdateMarkup --------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[JobSchedules] 
SET [UpdateMarkup] = '<[Column] old="[OldValue]" new="[NewValue]" date="2000-01-01T00:00:01" userId="1" >' + [UpdateMarkup]
WHERE JobScheduleId = 1
*/

-- UpdateMarkup sample --------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Base].[ParseUpdateMarkup]('<ShDesc old="" new="new" date="2023-04-26T15:35:49" userId="26">')
*/
