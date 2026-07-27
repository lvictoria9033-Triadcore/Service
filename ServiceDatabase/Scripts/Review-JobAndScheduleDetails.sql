

SELECT j.[JobId], j.[Active], j.[JobName], j.[Description], nv.[Value] AS [BasePath], REPLACE(j.[ExecPath], '{BasePath}', ISNULL(nv.[Value],'{NULL}')) + '\' + j.[ExecFile] AS [ExecPath], j.[LogStarts], j.[LogFinishes]
		, js.[JobScheduleName], js.[Active], js.[NextStart], js.[IsRecurring], js.[Interval], js.[Date], js.[Month], js.[Day], js.[Time]
FROM [Service].[Jobs] j
	LEFT OUTER JOIN [Base].[NameValues] nv ON nv.[Name]='JobBasePath'
	LEFT OUTER JOIN [Service].[JobSchedules] js ON j.[JobId]=js.[JobId]


DECLARE @JobRunTemp TABLE (  JobId INT
							,JobFriendlyName VARCHAR(200)
							,JobExecPath VARCHAR(1000)
							,JobParams VARCHAR(1000)
							,JobActive BIT
							,JobScheduleId INT
							,JobScheduleName VARCHAR(200)
							,JobScheduleActive BIT
							,StartDateTime DATETIME
							,NextStart DATETIME
							,RunAsUser VARCHAR(100)
							,RunAsPassword VARCHAR(200)
							,JobScheduleTypeId	INT
							,JobScheduleTypeName VARCHAR(100)
							,JobScheduleTypeDescription VARCHAR(1000)
							,JobScheduleInstanceDescription VARCHAR(1000)
							,TypeActive BIT
							,[Month] INT
							,Interval BIGINT
							,DayIndex INT
							,DayAbbrev VARCHAR(2)
							,[Date] INT
							,[Time] INT
							,IsRecurring BIT
							,EarliestRun DATETIME
							,NextRun DATETIME )

INSERT INTO @JobRunTemp EXEC [Service].[GetJobSchedulesDetails]

SELECT *
FROM @JobRunTemp
--WHERE JobId=1