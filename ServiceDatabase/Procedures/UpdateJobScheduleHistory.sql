IF (Base.ProcedureExists('Service','UpdateJobScheduleHistory')=1) BEGIN
	DROP PROCEDURE [Service].[UpdateJobScheduleHistory]
END
GO

/*---------------------------------------------------------------------------------------------------------------------
Inserts a new JobScheduleHistory if it does not exist, otherwise the JobScheduleHistory is updated.
Create Date: 2023.08.31
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[UpdateJobScheduleHistory]
(
	@JobScheduleHistoryId INT
	,@JobScheduleId INT
	,@ExecuteDateTimeStart DATETIME
	,@ExecuteDateTimeEnd DATETIME
	,@ExecuteUserName VARCHAR(100)
	,@ExecuteParams VARCHAR(1000)
	,@ResultCode INT
	,@ResultText VARCHAR(1000)
	,@Note VARCHAR(2000)
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @LastUpdatedId INT
DECLARE @ErrorCode INT = -1

IF (@JobScheduleId IS NULL) BEGIN
	RAISERROR('Input parameter @JobScheduleId is null.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (@ExecuteDateTimeStart IS NULL) BEGIN
	RAISERROR('Input parameter @ExecuteDateTimeStart is null.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (@ExecuteUserName IS NULL) BEGIN
	SET @ExecuteUserName=''
END

IF (@ExecuteParams IS NULL) BEGIN
	SET @ExecuteParams=''
END

IF (@ResultCode IS NULL) BEGIN
	RAISERROR('Input parameter @ResultCode is null.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (@ResultText IS NULL) BEGIN
	SET @ResultText=''
END

IF (@Note IS NULL) BEGIN
	SET @Note=''
END

IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId=ISNULL([UserId],-102) FROM [Base].[Users] WHERE [DefaultFlag]=1
END


BEGIN TRANSACTION [TransUpdateData]

	IF EXISTS(SELECT [JobScheduleHistoryId] FROM [Service].[JobScheduleHistory] WHERE [JobScheduleHistoryId]=@JobScheduleHistoryId) BEGIN
		-- Update the record
		
		UPDATE [Service].[JobScheduleHistory]
			SET  [UpdateDate] = GETDATE()
				,[UpdateUserId] = @UpdateUserId
				,[JobScheduleId] = @JobScheduleId
				,[ExecuteDateTimeStart] = @ExecuteDateTimeStart
				,[ExecuteDateTimeEnd] = @ExecuteDateTimeEnd
				,[ExecuteUserName] = @ExecuteUserName
				,[ExecuteParams] = @ExecuteParams
				,[ResultCode] = @ResultCode
				,[ResultText] = @ResultText
				,[Note] = @Note
			WHERE JobScheduleHistoryId = @JobScheduleHistoryId
		SET @ErrorCode = @@ERROR
		IF (@ErrorCode<>0) BEGIN
			RAISERROR('Failed to UPDATE JobScheduleHistory. Error code=%d.',18,2,@ErrorCode)
			GOTO HANDLE_ERROR
		END
		SET @LastUpdatedId = @JobScheduleHistoryId

	END
	ELSE BEGIN
		-- Insert a new record
		INSERT 
			INTO [Service].[JobScheduleHistory] 
					([UpdateUserId]
					,[CreateUserId]
					,[JobScheduleId]
					,[ExecuteDateTimeStart]
					,[ExecuteDateTimeEnd]
					,[ExecuteUserName]
					,[ExecuteParams]
					,[ResultCode]
					,[ResultText]
					,[Note])
			VALUES ( @UpdateUserId
					,@UpdateUserId
					,@JobScheduleId
					,@ExecuteDateTimeStart
					,@ExecuteDateTimeEnd
					,@ExecuteUserName
					,@ExecuteParams
					,@ResultCode
					,@ResultText
					,@Note)
		SET @ErrorCode = @@ERROR
		IF (@ErrorCode<>0) BEGIN
			RAISERROR('Failed to INSERT new JobScheduleHistory. Error code=%d.',11,1,@ErrorCode)
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
