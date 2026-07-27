/*
UPDATE [Service].JobScheduleTypes
SET InstanceDescription = 'Runs every {UnorderedInterval} minutes.'
WHERE JobScheduleTypeId=1
*/

SELECT j.JobName
		,j.JobFriendlyName
		,j.[Description]
		,j.ExecFile
		,js.JobScheduleName
		,'*' AS [*]
		,jst.JobScheduleTypeId
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
			  ) AS [ScheduleDescription]
		,js.[Month], js.[Interval], js.[Day], js.[Date], js.[Time]
FROM [Service].Jobs j
		LEFT OUTER JOIN [Service].JobSchedules js ON j.JobId=js.JobId
		LEFT OUTER JOIN [Service].[JobScheduleTypes] jst ON js.JobScheduleTypeId=jst.JobScheduleTypeId
--WHERE j.JobName='UpdateCarrierOrderTracking'