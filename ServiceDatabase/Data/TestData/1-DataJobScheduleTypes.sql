--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JobScheduleType test data insert
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DELETE FROM [Service].[JobScheduleTypes]; DBCC CHECKIDENT ('[Service].[JobScheduleTypes]', RESEED, 0);

DECLARE @UpdateUserId INT = 1
DECLARE @JobScheduleTypeNameCompareLogic VARCHAR(10) = NULL
DECLARE @JobScheduleTypeName VARCHAR(100) = ''
DECLARE @Description VARCHAR(1000) = ''
DECLARE @InstanceDescriptionCompareLogic VARCHAR(10) = NULL
DECLARE @InstanceDescription VARCHAR(1000) = ''
DECLARE @Note VARCHAR(1000) = ''
DECLARE @UpdateUserId INT = 3


-------  1  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @JobScheduleTypeName = 'JobScheduleTypeName-85'
SET @Description = ''
SET @InstanceDescription = ''
SET @Note = ''
IF (NOT EXISTS(SELECT * FROM [Service].[JobScheduleTypes] WHERE [JobScheduleTypeName]=@JobScheduleTypeName)) BEGIN
	EXEC [Service].[UpdateJobScheduleType]
		  NULL --@JobScheduleTypeId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @JobScheduleTypeName -- @JobScheduleTypeName VARCHAR(100)
		, @Description -- @Description VARCHAR(1000)
		, @InstanceDescription -- @InstanceDescription VARCHAR(1000)
		, @Note -- @Note VARCHAR(1000)
		, @UpdateUserId -- @UpdateUserId INT
END


-------  2  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @JobScheduleTypeName = 'JobScheduleTypeName-85'
SET @Description = ''
SET @InstanceDescription = ''
SET @Note = ''
IF (NOT EXISTS(SELECT * FROM [Service].[JobScheduleTypes] WHERE [JobScheduleTypeName]=@JobScheduleTypeName)) BEGIN
	EXEC [Service].[UpdateJobScheduleType]
		  NULL --@JobScheduleTypeId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @JobScheduleTypeName -- @JobScheduleTypeName VARCHAR(100)
		, @Description -- @Description VARCHAR(1000)
		, @InstanceDescription -- @InstanceDescription VARCHAR(1000)
		, @Note -- @Note VARCHAR(1000)
		, @UpdateUserId -- @UpdateUserId INT
END


-------  3  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @JobScheduleTypeName = 'JobScheduleTypeName-85'
SET @Description = ''
SET @InstanceDescription = ''
SET @Note = ''
IF (NOT EXISTS(SELECT * FROM [Service].[JobScheduleTypes] WHERE [JobScheduleTypeName]=@JobScheduleTypeName)) BEGIN
	EXEC [Service].[UpdateJobScheduleType]
		  NULL --@JobScheduleTypeId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @JobScheduleTypeName -- @JobScheduleTypeName VARCHAR(100)
		, @Description -- @Description VARCHAR(1000)
		, @InstanceDescription -- @InstanceDescription VARCHAR(1000)
		, @Note -- @Note VARCHAR(1000)
		, @UpdateUserId -- @UpdateUserId INT
END


-------  4  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @JobScheduleTypeName = 'JobScheduleTypeName-85'
SET @Description = ''
SET @InstanceDescription = ''
SET @Note = ''
IF (NOT EXISTS(SELECT * FROM [Service].[JobScheduleTypes] WHERE [JobScheduleTypeName]=@JobScheduleTypeName)) BEGIN
	EXEC [Service].[UpdateJobScheduleType]
		  NULL --@JobScheduleTypeId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @JobScheduleTypeName -- @JobScheduleTypeName VARCHAR(100)
		, @Description -- @Description VARCHAR(1000)
		, @InstanceDescription -- @InstanceDescription VARCHAR(1000)
		, @Note -- @Note VARCHAR(1000)
		, @UpdateUserId -- @UpdateUserId INT
END


-------  5  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @JobScheduleTypeName = 'JobScheduleTypeName-85'
SET @Description = ''
SET @InstanceDescription = ''
SET @Note = ''
IF (NOT EXISTS(SELECT * FROM [Service].[JobScheduleTypes] WHERE [JobScheduleTypeName]=@JobScheduleTypeName)) BEGIN
	EXEC [Service].[UpdateJobScheduleType]
		  NULL --@JobScheduleTypeId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @JobScheduleTypeName -- @JobScheduleTypeName VARCHAR(100)
		, @Description -- @Description VARCHAR(1000)
		, @InstanceDescription -- @InstanceDescription VARCHAR(1000)
		, @Note -- @Note VARCHAR(1000)
		, @UpdateUserId -- @UpdateUserId INT
END


------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM [Service].[JobScheduleTypes] ORDER BY [JobScheduleTypeId] DESC
