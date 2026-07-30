---------------------------------------------------------------------------------------------------------- 
-- Job database components testing 
-- Create Date: 2026.07.28
-- Created By : Triadcore (ACB)
-- Special Note: [GetJobs] was created by ACB but manually modified to include [FullPath]. Do not
--				 overwrite with subsequent re-run of ACB.
----------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Service].[Jobs] WITH (NOLOCK) ORDER BY 8
*/

------------------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[Jobs]
SET [SortText]=[JobName]
WHERE [SortText]='' OR [SortText] IS NULL
*/

------------------------------------------------------------------------------------------------------------
EXEC [Service].[GetJobs] 
		 NULL --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
		,NULL --@JobId INT
		,NULL --@UpdateUserId INT
		,NULL --@CreateUserId INT
		,NULL --@Active BIT
		,NULL --@JobNameCompareLogic VARCHAR(10)
		,NULL --@JobName VARCHAR(50)
		,NULL --@LogFinishesCompareLogic VARCHAR(10)
		,NULL --@LogFinishes BIT

------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[UpdateJob]
		NULL --@JobId INT
		,'' --@SortText VARCHAR(100)
		,'' --@JobName VARCHAR(50)
		,'' --@JobFriendlyName VARCHAR(100)
		,'' --@Description VARCHAR(200)
		,'' --@ExecPath VARCHAR(2000)
		,'' --@ExecFile VARCHAR(200)
		,'' --@ParamString VARCHAR(1000)
		,0 --@LogStarts BIT
		,0 --@LogFinishes BIT
		,NULL --@UpdateUserId INT
*/

------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[SetJobActivation] NULL, 0, NULL
*/



------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[DeleteJob] NULL, NULL
SELECT * FROM Base.DeleteLogs ORDER BY DeleteLogId DESC
*/

------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[GetJobUpdateHistory] null
*/

------------------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[Jobs] 
SET SortText = [<ColumnName>]
WHERE SortText IS NULL OR SortText=''

UPDATE[Service].[Jobs] 
SET UpdateMarkup = ''
*/

------------------------------------------------------------------------------------------------------------
/*
select * from Base.ParseUpdateMarkup('<ShDesc old="" new="new" date="2023-04-26T15:35:49" userId="26">')
*/
