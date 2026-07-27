IF (Base.ProcedureExists('Service','UpdateJobScheduleType')=1) BEGIN
	DROP PROCEDURE [Service].[UpdateJobScheduleType]
END
GO

/*---------------------------------------------------------------------------------------------------------------------
Inserts a new JobScheduleType if it does not exist, otherwise the JobScheduleType is updated.
Create Date: 2023.07.01
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[UpdateJobScheduleType]
(
	@JobScheduleTypeId INT
	,@JobScheduleTypeName VARCHAR(100)
	,@Description VARCHAR(1000)
	,@InstanceDescription VARCHAR(1000)
	,@Note VARCHAR(1000)
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @LastUpdatedId INT
DECLARE @ErrorCode INT = -1

IF (@JobScheduleTypeName IS NULL) BEGIN
	RAISERROR('Input parameter @JobScheduleTypeName is null.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (LTRIM(RTRIM(@JobScheduleTypeName))= '') BEGIN
	RAISERROR('Input parameter @JobScheduleTypeName cannot be blank.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (@Description IS NULL) BEGIN
	SET @Description=''
END

IF (@InstanceDescription IS NULL) BEGIN
	SET @InstanceDescription=''
END

IF (@Note IS NULL) BEGIN
	SET @Note=''
END

IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId=ISNULL([UserId],-102) FROM [Base].[Users] WHERE [DefaultFlag]=1
END


BEGIN TRANSACTION [TransUpdateData]

	IF EXISTS(SELECT [JobScheduleTypeId] FROM [Service].[JobScheduleTypes] WHERE [JobScheduleTypeId]=@JobScheduleTypeId) BEGIN
		-- Update the record
		
		UPDATE [Service].[JobScheduleTypes]
			SET  [UpdateDate] = GETDATE()
				,[UpdateUserId] = @UpdateUserId
				,[JobScheduleTypeName] = @JobScheduleTypeName
				,[Description] = @Description
				,[InstanceDescription] = @InstanceDescription
				,[Note] = @Note
			WHERE JobScheduleTypeId = @JobScheduleTypeId
		SET @ErrorCode = @@ERROR
		IF (@ErrorCode<>0) BEGIN
			RAISERROR('Failed to UPDATE JobScheduleType. Error code=%d.',18,2,@ErrorCode)
			GOTO HANDLE_ERROR
		END
		SET @LastUpdatedId = @JobScheduleTypeId

	END
	ELSE BEGIN
		-- Insert a new record
		INSERT 
			INTO [Service].[JobScheduleTypes] 
					([UpdateUserId]
					,[CreateUserId]
					,[JobScheduleTypeName]
					,[Description]
					,[InstanceDescription]
					,[Note])
			VALUES ( @UpdateUserId
					,@UpdateUserId
					,@JobScheduleTypeName
					,@Description
					,@InstanceDescription
					,@Note)
		SET @ErrorCode = @@ERROR
		IF (@ErrorCode<>0) BEGIN
			RAISERROR('Failed to INSERT new JobScheduleType. Error code=%d.',11,1,@ErrorCode)
			GOTO HANDLE_ERROR
		END
		SET @LastUpdatedId = @@IDENTITY

	END

COMMIT TRANSACTION [TransUpdateData]


SELECT @LastUpdatedId

RETURN 0

HANDLE_ERROR:
ROLLBACK TRANSACTION [TransUpdateData]
RETURN -1

HANDLE_ERROR1:
RETURN -2
