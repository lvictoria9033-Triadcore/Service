IF (Base.ProcedureExists('Service','UpdateJob')=1) BEGIN
	DROP PROCEDURE [Service].[UpdateJob]
END
GO

/*---------------------------------------------------------------------------------------------------------------------
Inserts a new Job if it does not exist, otherwise the Job is updated.
Create Date: 2026.07.28
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[UpdateJob]
(
	@JobId INT
	,@SortText VARCHAR(100)
	,@JobName VARCHAR(50)
	,@JobFriendlyName VARCHAR(100)
	,@Description VARCHAR(200)
	,@ExecPath VARCHAR(2000)
	,@ExecFile VARCHAR(200)
	,@ParamString VARCHAR(1000)
	,@LogStarts BIT
	,@LogFinishes BIT
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @LastUpdatedId INT
DECLARE @ErrorCode INT = -1




IF (@SortText IS NULL) BEGIN
	SET @SortText=''
END

IF (@JobName IS NULL) BEGIN
	RAISERROR('Input parameter @JobName is null.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (LTRIM(RTRIM(@JobName))= '') BEGIN
	RAISERROR('Input parameter @JobName cannot be blank.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (@JobFriendlyName IS NULL) BEGIN
	SET @JobFriendlyName=''
END

IF (@Description IS NULL) BEGIN
	SET @Description=''
END

IF (@ExecPath IS NULL) BEGIN
	RAISERROR('Input parameter @ExecPath is null.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (LTRIM(RTRIM(@ExecPath))= '') BEGIN
	RAISERROR('Input parameter @ExecPath cannot be blank.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (@ExecFile IS NULL) BEGIN
	RAISERROR('Input parameter @ExecFile is null.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (LTRIM(RTRIM(@ExecFile))= '') BEGIN
	RAISERROR('Input parameter @ExecFile cannot be blank.', 11, 1)
	GOTO HANDLE_ERROR1
END

IF (@ParamString IS NULL) BEGIN
	SET @ParamString=''
END

IF (@LogStarts IS NULL) BEGIN
	SET @LogStarts=0
END

IF (@LogFinishes IS NULL) BEGIN
	SET @LogFinishes=0
END

IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId=ISNULL([UserId],-102) FROM [Base].[Users] WHERE [DefaultFlag]=1
END


BEGIN TRANSACTION [TransUpdateData]

	IF EXISTS(SELECT [JobId] FROM [Service].[Jobs] WHERE [JobId]=@JobId) BEGIN
		-- Update the record		UPDATE [Service].[Jobs]
			SET  [UpdateDate] = GETDATE()
				,[UpdateUserId] = @UpdateUserId
				,[SortText] = @SortText
				,[JobName] = @JobName
				,[JobFriendlyName] = @JobFriendlyName
				,[Description] = @Description
				,[ExecPath] = @ExecPath
				,[ExecFile] = @ExecFile
				,[ParamString] = @ParamString
				,[LogStarts] = @LogStarts
				,[LogFinishes] = @LogFinishes
			WHERE JobId = @JobId
		SET @ErrorCode = @@ERROR
		IF (@ErrorCode<>0) BEGIN
			RAISERROR('Failed to UPDATE Job. Error code=%d.',18,2,@ErrorCode)
			GOTO HANDLE_ERROR
		END
		SET @LastUpdatedId = @JobId
	END
	ELSE BEGIN
		-- Insert a new record
		INSERT 
			INTO [Service].[Jobs] 
					([UpdateUserId]
					,[CreateUserId]
					,[RecordComment]
					,[SortText]
					,[JobName]
					,[JobFriendlyName]
					,[Description]
					,[ExecPath]
					,[ExecFile]
					,[ParamString]
					,[LogStarts]
					,[LogFinishes])
			VALUES ( @UpdateUserId
					,@UpdateUserId
					,'Created via [Service].[UpdateJob].'
					,@SortText
					,@JobName
					,@JobFriendlyName
					,@Description
					,@ExecPath
					,@ExecFile
					,@ParamString
					,@LogStarts
					,@LogFinishes)
		SET @ErrorCode = @@ERROR
		IF (@ErrorCode<>0) BEGIN
			RAISERROR('Failed to INSERT new Job. Error code=%d.',11,1,@ErrorCode)
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
