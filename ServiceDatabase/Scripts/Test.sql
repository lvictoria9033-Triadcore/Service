/*
update [Service].JobSchedules
set NextStart='2018-07-20 12:00:00.000'
where JobScheduleId IN (1, 2, 4, 5, 6, 8, 9)
*/

select * from Base.MessageLog order by EventDateTime desc
--SELECT * FROM [Service].Jobs
--SELECT * FROM [Service].JobScheduleTypes
SELECT * FROM [Service].JobSchedules ORDER BY Active Desc, NextStart
--EXEC [Service].[GetJobSchedulesDetails]
EXEC [Service].[GetRunNowJobs]
--EXEC [Service].[UpdateJobScheduleNextStart] null,2

