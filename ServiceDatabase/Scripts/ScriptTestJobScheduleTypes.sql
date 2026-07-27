---------------------------------------------------------------------------------------------------------- 
-- JobScheduleType database components testing 
-- Create Date: 2023.07.01
-- Created By : Triadcore (ACB)
----------------------------------------------------------------------------------------------------------

USE KvmConsulting
GO 

------------------------------------------------------------------------------------------------------------
/*
SELECT * FROM [Service].[JobScheduleTypes] 
*/



------------------------------------------------------------------------------------------------------------
EXEC [Service].[GetJobScheduleTypes] 
	 NULL --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,NULL --@JobScheduleTypeId INT
	,NULL --@CreateUserId INT
	,NULL --@UpdateUserId INT
	,NULL --@Active BIT
	,NULL --@JobScheduleTypeNameCompareLogic VARCHAR(10)
	,NULL --@JobScheduleTypeName VARCHAR(100)
	,NULL --@DescriptionCompareLogic VARCHAR(10)
	,NULL --@Description VARCHAR(1000)
	,NULL --@InstanceDescriptionCompareLogic VARCHAR(10)
	,NULL --@InstanceDescription VARCHAR(1000)
	,NULL --@NoteCompareLogic VARCHAR(10)
	,NULL --@Note VARCHAR(1000)

------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[UpdateJobScheduleType]
	NULL --@JobScheduleTypeId INT
	,'' --@JobScheduleTypeName VARCHAR(100)
	,'' --@Description VARCHAR(1000)
	,'' --@InstanceDescription VARCHAR(1000)
	,'' --@Note VARCHAR(1000)
	,NULL --@UpdateUserId INT
*/

------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[SetJobScheduleTypeActivation] NULL, 0, NULL
*/



------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[DeleteJobScheduleType] NULL, NULL
SELECT * FROM Base.DeleteLogs ORDER BY DeleteLogId DESC
*/

------------------------------------------------------------------------------------------------------------
/*
EXEC [Service].[GetJobScheduleTypeUpdateHistory] null
*/

------------------------------------------------------------------------------------------------------------
/*
UPDATE [Service].[JobScheduleTypes] 
SET SortText = [<ColumnName>]
WHERE SortText IS NULL OR SortText=''

UPDATE[Service].[JobScheduleTypes] 
SET UpdateMarkup = ''
*/

------------------------------------------------------------------------------------------------------------
/*
select * from Base.ParseUpdateMarkup('<ShDesc old="" new="new" date="2023-04-26T15:35:49" userId="26">')
*/
