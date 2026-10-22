--------------------------------------------------------------------------------------------------------------------------------- 
-- JobScheduleType database components testing 
-- Create Date: 2026.10.22
-- Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------------------

-- General use SELECT -------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Service].[JobScheduleTypes] WITH (NOLOCK) ORDER BY [JobScheduleTypeId] DESC
*/

-- Get ----------------------------------------------------------------------------------------------------------------
EXEC [Service].[GetJobScheduleTypes] 
	 NULL --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,NULL --@JobScheduleTypeId INT
	,NULL -- @CreateDate DATETIME
	,NULL -- @CreateUserId INT
	,NULL -- @UpdateDate DATETIME
	,NULL -- @UpdateUserId INT
	,NULL -- @Active BIT
	,NULL -- @JobScheduleTypeNameCompareLogic VARCHAR(10)
	,NULL -- @JobScheduleTypeName VARCHAR(100)
	,NULL -- @InstanceDescriptionCompareLogic VARCHAR(10)
	,NULL -- @InstanceDescription VARCHAR(1000)

-- Update -------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[UpdateJobScheduleType]
	 NULL --@JobScheduleTypeId INT
	,NULL -- @JobScheduleTypeName VARCHAR(100)
	,NULL -- @Description VARCHAR(1000)
	,NULL -- @InstanceDescription VARCHAR(1000)
	,NULL -- @Note VARCHAR(1000)
	,NULL --@UpdateUserId INT
*/

--- Get Update History from UpdateMarkup --------------------------------------------------------------------------------
/*
EXEC [Service].[GetJobScheduleTypeUpdateHistory] null
*/

-- Set Activation -------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[SetJobScheduleTypeActivation] NULL, 0, NULL
*/

-- Set Default ----------------------------------------------------------------------------------------------------------
/*

*/

-- Delete ---------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[DeleteJobScheduleType] NULL, '[ACB Testing]', NULL
SELECT * FROM [Base].[DeleteLogs] ORDER BY [DeleteLogId] DESC
*/

-- Update SortText ------------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[JobScheduleTypes] 
SET [SortText] = [<ColumnName>]
WHERE [SortText] IS NULL OR SortText=''
*/

-- SortText testing  -------------------------------------------------------------------------------------------------
/*

*/

-- Update UpdateMarkup --------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[JobScheduleTypes] 
SET [UpdateMarkup] = '<[Column] old="[OldValue]" new="[NewValue]" date="2000-01-01T00:00:01" userId="1" >' + [UpdateMarkup]
WHERE JobScheduleTypeId = 1
*/

-- UpdateMarkup sample --------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Base].[ParseUpdateMarkup]('<ShDesc old="" new="new" date="2023-04-26T15:35:49" userId="26">')
*/
