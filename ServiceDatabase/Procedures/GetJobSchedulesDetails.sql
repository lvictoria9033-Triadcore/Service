IF (Base.ProcedureExists('Service','GetJobSchedulesDetails')=1)
	DROP PROCEDURE [Service].[GetJobSchedulesDetails]

GO

/*---------------------------------------------------------------------------------------------------------------------
Returns job schedules that are scheduled to run NOW.
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[GetJobSchedulesDetails]

AS

SET NOCOUNT ON

DECLARE @RunNowCount INT = 0
DECLARE @CurrDate DATETIME = GETDATE()

-- Temp table for schedule date/times
DECLARE @JobRunTemp TABLE (  JobId INT
							,JobFriendlyName VARCHAR(200)
							,JobExecPath VARCHAR(1000)
							,JobParams VARCHAR(1000)
							,JobActive BIT
							,JobScheduleId INT
							,JobScheduleName VARCHAR(200)
							,JobScheduleDescription VARCHAR(1000)
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

INSERT INTO @JobRunTemp
	SELECT   j.JobId 
			,j.JobFriendlyName
			,j.ExecPath + '\' + j.ExecFile
			,j.ParamString
			,j.Active
			,js.JobScheduleId
			,js.JobScheduleName
			,js.[Description]
			,js.Active
			,js.BaseDateTime
			,js.NextStart
			,js.RunAsUser
			,js.RunAsPassword
			,jst.JobScheduleTypeId
			,jst.JobScheduleTypeName
			,jst.[Description]
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
			  )
			,jst.Active
			,js.[Month]
			,js.Interval
			,js.[Day]
			,CASE
				WHEN js.[Day]=1 THEN 'SU'
				WHEN js.[Day]=2 THEN 'MO'
				WHEN js.[Day]=3 THEN 'TU'
				WHEN js.[Day]=4 THEN 'WE'
				WHEN js.[Day]=5 THEN 'TH'
				WHEN js.[Day]=6 THEN 'FR'
				WHEN js.[Day]=7 THEN 'SA'
				ELSE NULL
			 END
			,js.[Date]
			,js.[Time]
			,js.IsRecurring
			,NULL
			,NULL
	FROM [Service].Jobs j WITH (NOLOCK)
		JOIN [Service].JobSchedules js WITH (NOLOCK) ON j.JobId=js.JobId
		JOIN [Service].JobScheduleTypes jst WITH (NOLOCK) ON js.JobScheduleTypeId=jsT.JobScheduleTypeId


SELECT   JobId
		,JobFriendlyName
		,JobExecPath
		,JobParams
		,JobActive
		,JobScheduleId
		,JobScheduleDescription
		,JobScheduleActive
		,StartDateTime AS [BaseDateTime]
		,NextStart
		,RunAsUser
		,RunAsPassword
		,JobScheduleTypeId
		,JobScheduleTypeName
		,JobScheduleTypeDescription
		,JobScheduleInstanceDescription
		,TypeActive
		,[Month]
		,Interval
		,DayIndex
		,DayAbbrev
		,[Date]
		,[Time]
		,IsRecurring
		,[Service].GetJobScheduleEarliestRun(JobScheduleId) AS [EarliestRun]
		,[Service].GetJobScheduleNextRun(JobScheduleId) AS [NextRunDateTime]
FROM  @JobRunTemp
--WHERE GETDATE()>=NextStart
ORDER BY NextStart

RETURN @RunNowCount

HANDLE_ERROR:
RETURN -1

