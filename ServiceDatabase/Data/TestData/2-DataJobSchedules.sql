--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JobSchedule test data insert
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DELETE FROM [Service].[JobSchedules]; DBCC CHECKIDENT ('[Service].[JobSchedules]', RESEED, 0);

DECLARE @UpdateUserId INT = 1
DECLARE @JobScheduleNameCompareLogic VARCHAR(10) = NULL
DECLARE @JobScheduleName VARCHAR(100) = ''
DECLARE @Description VARCHAR(1000) = ''
DECLARE @JobId INT = 1
DECLARE @JobScheduleTypeId INT = 1
DECLARE @BaseDateTime DATETIME = GETDATE()
DECLARE @NextStart DATETIME = GETDATE()
DECLARE @Interval INT = 1
DECLARE @Date INT = 1
DECLARE @Month INT = 1
DECLARE @Day INT = 1
DECLARE @Time INT = 1
DECLARE @IsRecurring BIT = 1
DECLARE @RunAsUser VARCHAR(100) = ''
DECLARE @RunAsPassword VARCHAR(200) = ''
DECLARE @UpdateUserId INT = 3


-------  1  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @JobScheduleName = 'JobScheduleName-129'
SET @Description = ''
SET @JobId = 1
SET @JobScheduleTypeId = 5
SET @BaseDateTime = DATEADD(DAY, 43, GETDATE())
SET @NextStart = DATEADD(DAY, 115, GETDATE())
SET @Interval = 69
SET @Date = 104
SET @Month = 133
SET @Day = 93
SET @Time = 98
SET @IsRecurring = 1
SET @RunAsUser = ''
SET @RunAsPassword = 'RunAsPassword-99'
IF (NOT EXISTS(SELECT * FROM [Service].[JobSchedules] WHERE [JobScheduleName]=@JobScheduleName AND [JobId]=@JobId AND ISNULL([Interval],0)=ISNULL(@Interval,0) AND ISNULL([Date],0)=ISNULL(@Date,0) AND ISNULL([Day],0)=ISNULL(@Day,0) AND [IsRecurring]=@IsRecurring)) BEGIN
	EXEC [Service].[UpdateJobSchedule]
		  NULL --@JobScheduleId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @JobScheduleName -- @JobScheduleName VARCHAR(100)
		, @Description -- @Description VARCHAR(1000)
		, @JobId -- @JobId INT
		, @JobScheduleTypeId -- @JobScheduleTypeId INT
		, @BaseDateTime -- @BaseDateTime DATETIME
		, @NextStart -- @NextStart DATETIME
		, @Interval -- @Interval INT
		, @Date -- @Date INT
		, @Month -- @Month INT
		, @Day -- @Day INT
		, @Time -- @Time INT
		, @IsRecurring -- @IsRecurring BIT
		, @RunAsUser -- @RunAsUser VARCHAR(100)
		, @RunAsPassword -- @RunAsPassword VARCHAR(200)
		, @UpdateUserId -- @UpdateUserId INT
END


-------  2  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @JobScheduleName = 'JobScheduleName-129'
SET @Description = ''
SET @JobId = 1
SET @JobScheduleTypeId = 5
SET @BaseDateTime = DATEADD(DAY, 43, GETDATE())
SET @NextStart = NULL
SET @Interval = NULL
SET @Date = NULL
SET @Month = NULL
SET @Day = NULL
SET @Time = NULL
SET @IsRecurring = 1
SET @RunAsUser = ''
SET @RunAsPassword = 'RunAsPassword-99'
IF (NOT EXISTS(SELECT * FROM [Service].[JobSchedules] WHERE [JobScheduleName]=@JobScheduleName AND [JobId]=@JobId AND ISNULL([Interval],0)=ISNULL(@Interval,0) AND ISNULL([Date],0)=ISNULL(@Date,0) AND ISNULL([Day],0)=ISNULL(@Day,0) AND [IsRecurring]=@IsRecurring)) BEGIN
	EXEC [Service].[UpdateJobSchedule]
		  NULL --@JobScheduleId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @JobScheduleName -- @JobScheduleName VARCHAR(100)
		, @Description -- @Description VARCHAR(1000)
		, @JobId -- @JobId INT
		, @JobScheduleTypeId -- @JobScheduleTypeId INT
		, @BaseDateTime -- @BaseDateTime DATETIME
		, @NextStart -- @NextStart DATETIME
		, @Interval -- @Interval INT
		, @Date -- @Date INT
		, @Month -- @Month INT
		, @Day -- @Day INT
		, @Time -- @Time INT
		, @IsRecurring -- @IsRecurring BIT
		, @RunAsUser -- @RunAsUser VARCHAR(100)
		, @RunAsPassword -- @RunAsPassword VARCHAR(200)
		, @UpdateUserId -- @UpdateUserId INT
END


-------  3  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @JobScheduleName = 'JobScheduleName-129'
SET @Description = ''
SET @JobId = 1
SET @JobScheduleTypeId = 5
SET @BaseDateTime = DATEADD(DAY, 43, GETDATE())
SET @NextStart = NULL
SET @Interval = NULL
SET @Date = NULL
SET @Month = NULL
SET @Day = NULL
SET @Time = NULL
SET @IsRecurring = 1
SET @RunAsUser = ''
SET @RunAsPassword = 'RunAsPassword-99'
IF (NOT EXISTS(SELECT * FROM [Service].[JobSchedules] WHERE [JobScheduleName]=@JobScheduleName AND [JobId]=@JobId AND ISNULL([Interval],0)=ISNULL(@Interval,0) AND ISNULL([Date],0)=ISNULL(@Date,0) AND ISNULL([Day],0)=ISNULL(@Day,0) AND [IsRecurring]=@IsRecurring)) BEGIN
	EXEC [Service].[UpdateJobSchedule]
		  NULL --@JobScheduleId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @JobScheduleName -- @JobScheduleName VARCHAR(100)
		, @Description -- @Description VARCHAR(1000)
		, @JobId -- @JobId INT
		, @JobScheduleTypeId -- @JobScheduleTypeId INT
		, @BaseDateTime -- @BaseDateTime DATETIME
		, @NextStart -- @NextStart DATETIME
		, @Interval -- @Interval INT
		, @Date -- @Date INT
		, @Month -- @Month INT
		, @Day -- @Day INT
		, @Time -- @Time INT
		, @IsRecurring -- @IsRecurring BIT
		, @RunAsUser -- @RunAsUser VARCHAR(100)
		, @RunAsPassword -- @RunAsPassword VARCHAR(200)
		, @UpdateUserId -- @UpdateUserId INT
END


-------  4  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @JobScheduleName = 'JobScheduleName-129'
SET @Description = ''
SET @JobId = 1
SET @JobScheduleTypeId = 5
SET @BaseDateTime = DATEADD(DAY, 43, GETDATE())
SET @NextStart = NULL
SET @Interval = NULL
SET @Date = NULL
SET @Month = NULL
SET @Day = NULL
SET @Time = NULL
SET @IsRecurring = 1
SET @RunAsUser = ''
SET @RunAsPassword = 'RunAsPassword-99'
IF (NOT EXISTS(SELECT * FROM [Service].[JobSchedules] WHERE [JobScheduleName]=@JobScheduleName AND [JobId]=@JobId AND ISNULL([Interval],0)=ISNULL(@Interval,0) AND ISNULL([Date],0)=ISNULL(@Date,0) AND ISNULL([Day],0)=ISNULL(@Day,0) AND [IsRecurring]=@IsRecurring)) BEGIN
	EXEC [Service].[UpdateJobSchedule]
		  NULL --@JobScheduleId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @JobScheduleName -- @JobScheduleName VARCHAR(100)
		, @Description -- @Description VARCHAR(1000)
		, @JobId -- @JobId INT
		, @JobScheduleTypeId -- @JobScheduleTypeId INT
		, @BaseDateTime -- @BaseDateTime DATETIME
		, @NextStart -- @NextStart DATETIME
		, @Interval -- @Interval INT
		, @Date -- @Date INT
		, @Month -- @Month INT
		, @Day -- @Day INT
		, @Time -- @Time INT
		, @IsRecurring -- @IsRecurring BIT
		, @RunAsUser -- @RunAsUser VARCHAR(100)
		, @RunAsPassword -- @RunAsPassword VARCHAR(200)
		, @UpdateUserId -- @UpdateUserId INT
END


-------  5  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @JobScheduleName = 'JobScheduleName-129'
SET @Description = ''
SET @JobId = 1
SET @JobScheduleTypeId = 5
SET @BaseDateTime = DATEADD(DAY, 43, GETDATE())
SET @NextStart = NULL
SET @Interval = NULL
SET @Date = NULL
SET @Month = NULL
SET @Day = NULL
SET @Time = NULL
SET @IsRecurring = 1
SET @RunAsUser = ''
SET @RunAsPassword = 'RunAsPassword-99'
IF (NOT EXISTS(SELECT * FROM [Service].[JobSchedules] WHERE [JobScheduleName]=@JobScheduleName AND [JobId]=@JobId AND ISNULL([Interval],0)=ISNULL(@Interval,0) AND ISNULL([Date],0)=ISNULL(@Date,0) AND ISNULL([Day],0)=ISNULL(@Day,0) AND [IsRecurring]=@IsRecurring)) BEGIN
	EXEC [Service].[UpdateJobSchedule]
		  NULL --@JobScheduleId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @JobScheduleName -- @JobScheduleName VARCHAR(100)
		, @Description -- @Description VARCHAR(1000)
		, @JobId -- @JobId INT
		, @JobScheduleTypeId -- @JobScheduleTypeId INT
		, @BaseDateTime -- @BaseDateTime DATETIME
		, @NextStart -- @NextStart DATETIME
		, @Interval -- @Interval INT
		, @Date -- @Date INT
		, @Month -- @Month INT
		, @Day -- @Day INT
		, @Time -- @Time INT
		, @IsRecurring -- @IsRecurring BIT
		, @RunAsUser -- @RunAsUser VARCHAR(100)
		, @RunAsPassword -- @RunAsPassword VARCHAR(200)
		, @UpdateUserId -- @UpdateUserId INT
END


------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM [Service].[JobSchedules] ORDER BY [JobScheduleId] DESC
