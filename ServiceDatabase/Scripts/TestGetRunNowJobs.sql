
SELECT * FROM [Base].NameValues WHERE NameGroup='esp'

SELECT * FROM [Service].Jobs

EXEC [Service].[GetRunNowJobs]

select * from [Service].[JobScheduleHistory] order by ExecuteDateTimeStart DESC