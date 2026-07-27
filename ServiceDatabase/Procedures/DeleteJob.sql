IF (Base.ProcedureExists('Service','DeleteJob')=1)
	DROP PROCEDURE [Service].[DeleteJob]

GO

/*---------------------------------------------------------------------------------------------------------------------
Deletes the Job from the [Jobs] table.
Create Date: 2023.08.28
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[DeleteJob]
(
	@JobId INT
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1
DECLARE @Comment VARCHAR(200) = ''
DECLARE @CommentRef VARCHAR(400) = ''

IF ( @JobId IS NULL ) BEGIN
	RAISERROR('The JobId parameter is null.',11,1)
	GOTO HANDLE_ERROR1
END

IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId=ISNULL([UserId],-102) FROM Base.Users WITH (NOLOCK) WHERE [DefaultFlag]=1 
END



BEGIN TRANSACTION [TransDeleteData]

	-- Set a delete log value that identifies that this record was deleted
	SELECT @Comment='[JobName]=' + ISNULL(CAST([JobName] AS VARCHAR(200)),'Id not specified') FROM [Service].[Jobs] WITH (NOLOCK) WHERE [JobId]=@JobId

	-- Delete from [Jobs] table
	DELETE FROM [Service].[Jobs] WHERE [JobId]=@JobId
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error deleting data with id=%d. Error code=%d.',11,1,@JobId,@ErrorCode)
		GOTO HANDLE_ERROR
	END
	EXEC Base.LogDelete @UpdateUserId, '[Service].[Jobs]', @JobId, @Comment, 'SP [Service].[DeleteJob]'

COMMIT TRANSACTION [TransDeleteData]


RETURN 0

HANDLE_ERROR:
ROLLBACK TRANSACTION [TransDeleteData]
RETURN -1

HANDLE_ERROR1:
RETURN -2
