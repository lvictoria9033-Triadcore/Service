--------------------------------------------------------------------------------------------------------------------------------- 
-- Job database components testing 
-- Create Date: 2026.10.22
-- Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------------------

-- General use SELECT -------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Service].[Jobs] WITH (NOLOCK) ORDER BY [JobId] DESC
*/

-- Get ----------------------------------------------------------------------------------------------------------------
EXEC [Service].[GetJobs] 
	 NULL --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,NULL --@JobId INT
	,NULL -- @CreateDate DATETIME
	,NULL -- @CreateUserId INT
	,NULL -- @UpdateDate DATETIME
	,NULL -- @UpdateUserId INT
	,NULL -- @Active BIT
	,NULL -- @JobNameCompareLogic VARCHAR(10)
	,NULL -- @JobName VARCHAR(50)
	,NULL -- @ExecFileCompareLogic VARCHAR(10)
	,NULL -- @ExecFile VARCHAR(200)

-- Update -------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[UpdateJob]
	 NULL --@JobId INT
	,NULL -- @SortText VARCHAR(100)
	,NULL -- @JobName VARCHAR(50)
	,NULL -- @JobFriendlyName VARCHAR(100)
	,NULL -- @Description VARCHAR(200)
	,NULL -- @ExecPath VARCHAR(2000)
	,NULL -- @ExecFile VARCHAR(200)
	,NULL -- @ParamString VARCHAR(1000)
	,NULL -- @LogStarts BIT
	,NULL -- @LogFinishes BIT
	,NULL --@UpdateUserId INT
*/

--- Get Update History from UpdateMarkup --------------------------------------------------------------------------------
/*
EXEC [Service].[GetJobUpdateHistory] null
*/

-- Set Activation -------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[SetJobActivation] NULL, 0, NULL
*/

-- Set Default ----------------------------------------------------------------------------------------------------------
/*

*/

-- Delete ---------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[DeleteJob] NULL, '[ACB Testing]', NULL
SELECT * FROM [Base].[DeleteLogs] ORDER BY [DeleteLogId] DESC
*/

-- Update SortText ------------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[Jobs] 
SET [SortText] = [<ColumnName>]
WHERE [SortText] IS NULL OR SortText=''
*/

-- SortText testing  -------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[Jobs]
SET [SortText] = [JobName]
WHERE [SortText] ='' OR [SortText] IS NULL
*/

-- Update UpdateMarkup --------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[Jobs] 
SET [UpdateMarkup] = '<[Column] old="[OldValue]" new="[NewValue]" date="2000-01-01T00:00:01" userId="1" >' + [UpdateMarkup]
WHERE JobId = 1
*/

-- UpdateMarkup sample --------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Base].[ParseUpdateMarkup]('<ShDesc old="" new="new" date="2023-04-26T15:35:49" userId="26">')
*/
