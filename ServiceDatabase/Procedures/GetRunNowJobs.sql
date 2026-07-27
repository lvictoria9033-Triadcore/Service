IF (Base.ProcedureExists('Service','GetRunNowJobs')=1)
	DROP PROCEDURE [Service].[GetRunNowJobs]

GO

/*---------------------------------------------------------------------------------------------------------------------
Returns job schedules that are scheduled to run NOW.
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[GetRunNowJobs]

AS

SET NOCOUNT ON

DECLARE @BasePath VARCHAR(1000) = ''

-- Get base path from name-value table
SELECT @BasePath=ISNULL([Value],'') FROM Base.NameValues WHERE [Name]='JobBasePath'

SELECT   j.JobId 
		,js.JobScheduleId
		,j.JobFriendlyName
		,js.JobScheduleName
		,REPLACE(		
				REPLACE(
					 REPLACE(
						  REPLACE(
								  REPLACE(
										  REPLACE(
												   jst.[InstanceDescription]
												   , '{Month}'
												   , CAST(ISNULL(Base.MonthFromIndex(js.[Month],0),'') AS VARCHAR(10))
												 )
										  , '{Day}'
										  , CAST(ISNULL(Base.DayFromIndex(js.[Day],0),'') AS VARCHAR(10))
										 )
									, '{Date}'
									, CAST(Base.FormatOrderedNumberString(ISNULL(js.[Date],0)) AS VARCHAR(10))
								  )
							, '{Time}'
							, CAST(Base.FormatTimeString(js.[Time], '12', 1) AS VARCHAR(10))
						  )
					 , '{Interval}'
					 , CAST(Base.FormatOrderedNumberString(ISNULL(js.[Interval],0)) AS VARCHAR(10))
					)
				, '{UnorderedInterval}'
				, CAST(ISNULL(js.[Interval],'') AS VARCHAR(10))
			  ) AS [ScheduleDescription]
		,js.IsRecurring
		,js.BaseDateTime
		,js.NextStart
		,REPLACE(CASE	
					WHEN (@BasePath<>'' AND  PATINDEX('{BasePath}%', j.ExecPath)>0) THEN REPLACE(@BasePath + '\' + REPLACE(j.ExecPath,'{BasePath}','') + '\' + j.ExecFile, '\\','\')
					ELSE REPLACE(j.ExecPath + '\' + j.ExecFile, '\\', '\')
				 END
				 , '\\'
				 , '\') AS [ExecutablePath]
		,j.ParamString
		,js.RunAsUser
		,js.RunAsPassword
		,j.LogStarts
		,j.LogFinishes
FROM [Service].Jobs j WITH (NOLOCK)
	JOIN [Service].JobSchedules js WITH (NOLOCK) ON j.JobId=js.JobId
	JOIN [Service].JobScheduleTypes jst WITH (NOLOCK) ON js.JobScheduleTypeId=jst.JobScheduleTypeId
WHERE j.Active=1 AND js.Active=1 AND jst.Active=1 AND GETDATE()>=js.NextStart AND js.NextStart>=js.BaseDateTime 
ORDER BY js.NextStart

RETURN  0

HANDLE_ERROR:
RETURN -1

