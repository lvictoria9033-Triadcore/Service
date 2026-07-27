use kvmconsulting
go

-- DELETE FROM [Service].JobScheduleHistory WHERE ExecuteDateTimeStart <= '2019-08-22'

SELECT j.JobId, j.JobName, j.Active, j.ExecFile, j.LogStarts, j.LogFinishes
		, js.JobScheduleId, js.Active AS [ActiveJobSchedule]
		, jsh.ExecuteDateTimeStart, jsh.ExecuteDateTimeEnd
		, jsh.ExecuteParams
		, jsh.ResultText
		, jst.JobScheduleTypeName
		, js.Interval, js.[Time]
		, js.NextStart
		, jsh.CreateDate AS [HistoryCreateDate]
FROM [Service].Jobs j
		LEFT OUTER JOIN [Service].JobSchedules js ON j.JobId=js.JobId
			LEFT OUTER JOIN [Service].JobScheduleTypes jst ON js.JobScheduleTypeId=jst.JobScheduleTypeId
			LEFT OUTER JOIN [Service].JobScheduleHistory jsh ON js.JobScheduleId=jsh.JobScheduleId
--WHERE jsh.ResultText LIKE '%\KVM\Applications\Applications%'
ORDER BY jsh.ExecuteDateTimeStart DESC, j.JobName

-- EXEC [Service].GetJobSchedulesDetails
-- EXEC [Service].[GetRunNowJobs]