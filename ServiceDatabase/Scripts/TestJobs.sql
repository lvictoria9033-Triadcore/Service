
/*
EXEC [Service].SetJobActivation 1, 1, null
*/
/*
EXEC [Service].DeleteJob 1, null
select * from base.DeleteLog order by createdate desc 
*/
/*
EXEC [Service].[UpdateJob]
	19 --@JobId INT
	,'JobTest' --@JobName VARCHAR(50)
	,'Tester Job' --@JobFriendlyName VARCHAR(100)
	,'Tester job description.' --@Description VARCHAR(200)
	,'E:\KVM Consulting\IT\Development\JobTest\JobTest\bin\Debug' --@ExecPath VARCHAR(2000)
	,'KVM.Esp.JobTest.exe' --@ExecFile VARCHAR(200)
	, '<p1 v=a><p2 v=b>' --@ParamString VARCHAR(1000)
	, 0 --@LogStarts BIT
	, 1 --@LogFinishes BIT
	,'XXX-XXX'  --@SortText VARCHAR(50)
	,3 --@UpdateUserId INT
	,'For testing LogStarts and LogFinishes only' --@RecordComment VARCHAR(1000)
*/

EXEC [Service].[GetJobs]
	null --@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,null --@JobId INT
	,null --@CreateUserId INT
	,null --@UpdateUserId INT
	,null --@Active BIT
	,null --@JobNameCompareLogic VARCHAR(8)  -- only '=','<>,'LIKE', 'NOT LIKE', 'IN', 'NOT IN'
	,null --@JobName VARCHAR(100)
	,null --@LogFinishesCompareLogic VARCHAR(10)
	,null --@LogFinishes BIT
	

-- Formatted exec file
select j.JobName, j.JobFriendlyName
		,  nm.[Value]
		, j.ExecPath, j.ExecFile
		,  REPLACE(j.ExecPath, '{BasePath}', SUBSTRING(ISNULL(nm.[Value],' '), 1, LEN(nm.[Value]))) + '\' + j.ExecFile AS [ExecFullPath]
from [Service].Jobs j
		join Base.NameValues nm on nm.[Name]='JobBasePath'
--where j.JobName = 'JobParseHubImport'

