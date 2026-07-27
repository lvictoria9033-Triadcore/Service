IF ( Base.TableExists('Service','JobScheduleTypes')=1 ) BEGIN

	DECLARE @LoaderUserId INT = -1

	SELECT @LoaderUserId=UserId FROM Base.Users WHERE UserName='SysDataLoader'
	
	IF (SELECT COUNT(*) FROM [Service].JobScheduleTypes)=0 BEGIN
		DBCC CHECKIDENT('[Service].JobScheduleTypes', RESEED, 1)
	END

	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='TimeInterval') ) BEGIN
		EXEC [Service].UpdateJobScheduleType null, 'TimeInterval', 'Job that executes after a period of elapsed minutes.', 'Runs every {UnorderedInterval} minutes.', '', @LoaderUserId
	END
	
	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='DailyInterval') ) BEGIN
		EXEC [Service].UpdateJobScheduleType null, 'DailyInterval', 'Job that executes daily at a specific time.', 'Runs daily at a {Time}.', 'Can create more than one for specific times in a day.', @LoaderUserId
	END

	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='DayInterval') ) BEGIN
		EXEC [Service].UpdateJobScheduleType null, 'DayInterval', 'Job that executes on a specific day of week (Monday-Sunday) at a specified time.', 'Runs every {Day} at {Time}.', 'Can create more than one day of week schedule.', @LoaderUserId
	END
	
	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='DayOccurrence') ) BEGIN
		EXEC [Service].UpdateJobScheduleType null, 'DayOccurrence', 'Job that executes every Nth day of week of the month (2nd Tues, 3rd Thurs, 1st Sat, etc.) at a specified time.', 'Runs every {Interval} {Day} the month at {Time}.', '', @LoaderUserId
	END

	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='LastDayOccurrence') ) BEGIN
		EXEC [Service].UpdateJobScheduleType null, 'LastDayOccurrence', 'Job that executes last day of week of the month (last Tues, last Thurs, last Sat, etc.) at a specified time.', 'Runs on the last {Day} of the month at {Time}.', '', @LoaderUserId
	END

	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='LastDayOfMonth') ) BEGIN
		EXEC [Service].UpdateJobScheduleType null, 'LastDayOfMonth', 'Job that executes on the last day of the month at a specified time.', 'Runs on the last day of the month at {Time}.', '', @LoaderUserId
	END

	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='DateInterval') ) BEGIN
		EXEC [Service].UpdateJobScheduleType null, 'DateInterval', 'Job that executes on the Nth day of the month at a specified time.', 'Runs on the {Date} of the month at {Time}.', '', @LoaderUserId
	END

	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='MonthInterval') ) BEGIN
		EXEC [Service].UpdateJobScheduleType null, 'MonthInterval', 'Job that executes on the Mth month at a specified date and time.', 'Runs on the {Date} of {Month} at {Time}.', '', @LoaderUserId
	END

	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='MonthDayInterval') ) BEGIN
		EXEC [Service].UpdateJobScheduleType null, 'MonthDayInterval', 'Job that executes on the Mth month on the Nth day of week at a specific time.', 'Runs on the {Interval} {Day} of {Month} at {Time}.', '', @LoaderUserId
	END

	------------------------------------------------------------------------------------------------------------------------------------
	IF ( NOT EXISTS(SELECT * FROM [Service].JobScheduleTypes WHERE JobScheduleTypeName='MonthDateInterval') ) BEGIN
		EXEC [Service].UpdateJobScheduleType null, 'MonthDateInterval', 'Job that executes on the Mth month on the specified date at a specific time.', 'Runs on the {Date} of {Month} at {Time}.', '', @LoaderUserId
	END

END

select * from [Service].JobScheduleTypes order by JobScheduleTypeName
