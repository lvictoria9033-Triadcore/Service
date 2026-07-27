
SELECT * FROM [Service].[JobScheduleTypes] ORDER BY Active DESC

SELECT * FROM [Service].[Jobs] ORDER BY Active DESC, SortText

SELECT * FROM [Service].[JobSchedules] ORDER BY Active DESC

SELECT * FROM [Service].[JobScheduleHistory] 

SELECT j.JobId, j.JobFriendlyName, j.[Description], js.JobScheduleName, js.Interval, js.[Date], js.[Month], js.[Day], js.[Time], js.IsRecurring
FROM [Service].[Jobs] j 
		LEFT OUTER JOIN [Service].[JobSchedules] js ON j.JobId=js.JobId
