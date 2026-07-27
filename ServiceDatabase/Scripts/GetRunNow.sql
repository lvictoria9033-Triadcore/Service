/*
UPDATE [Service].JobSchedules
--SET StartDateTime = DATEADD(dd, -5, StartDateTime)
SET StartDateTime = '2018-06-28 04:20:00.000'
WHERE JobScheduleId=3
*/

-- Temp table for schedule date/times
DECLARE @JobRunTemp TABLE (JobScheduleId INT
							, JobScheduleName VARCHAR(200)
							, JobId INT
							, StartDateTime DATETIME
							, TimeInterval BIGINT
							, NextStart DATETIME
							--, ElapsedMinutes BIGINT
							--, ElapsedIntervals BIGINT
							, EarliestRun DATETIME
							, NextRunTime DATETIME)

-- Temp table for scheduled times to run now
DECLARE @JobRunTemp1 TABLE (JobScheduleId INT
							, JobScheduleName VARCHAR(200)
							, JobId INT
							, StartDateTime DATETIME
							, TimeInterval BIGINT
							, NextStart DATETIME
							--, ElapsedMinutes BIGINT
							--, ElapsedIntervals BIGINT
							, EarliestRun DATETIME
							, NextRunTime DATETIME)

-- Populate schedule times
INSERT INTO @JobRunTemp
	SELECT js.JobScheduleId
			, js.JobScheduleName
			, js.JobId
			, js.StartDateTime
			, js.TimeInterval
			, js.NextStart
			--, DATEDIFF(MI, js.StartDateTime, GETDATE()) AS [ElapsedMinutes]
			--, DATEDIFF(MI, js.StartDateTime, GETDATE())/TimeInterval AS [ElapsedIntervals]
			, DATEADD(MI, (DATEDIFF(MI, js.StartDateTime, GETDATE())/js.TimeInterval)*js.TimeInterval ,js.StartDateTime) AS [EarliestRun]
			, DATEADD(MI, js.TimeInterval, DATEADD(MI, (DATEDIFF(MI, js.StartDateTime, GETDATE())/js.TimeInterval)*js.TimeInterval, js.StartDateTime)) AS [NextRunTime]
	FROM [Service].JobSchedules js JOIN [Service].Jobs j ON js.Jobid=j.JobId
	WHERE js.Active=1

-- Populate schedule times that are to run now
INSERT INTO @JobRunTemp1 
	SELECT JobScheduleId
				, JobScheduleName
				, JobId
				, StartDateTime
				, TimeInterval
				, NextStart
				--, ElapsedMinutes
				--, ElapsedIntervals
				, EarliestRun
				, NextRunTime
	FROM @JobRunTemp
	WHERE GETDATE()>=StartDateTime AND NextStart <= GETDATE()

-- View jobs to run now
SELECT * FROM @JobRunTemp1 WHERE GETDATE()>NextRunTime


-- View next job run time
SELECT JobScheduleId, JobScheduleName, JobId, StartDateTime, DATEADD(MI, TimeInterval, DATEADD(MI, (DATEDIFF(MI, StartDateTime, GETDATE())/TimeInterval)*TimeInterval, StartDateTime)) AS [Next]
FROM [Service].JobSchedules

-- Update the next job run time (to be done after a scheduled job has run)
/*
UPDATE [Service].JobSchedules
SET NextStart = DATEADD(MI, TimeInterval, DATEADD(MI, (DATEDIFF(MI, StartDateTime, GETDATE())/TimeInterval)*TimeInterval, StartDateTime))
WHERE JobScheduleId=@JobScheduleId
*/


  -- Review update
SELECT * FROM [Service].JobSchedules

