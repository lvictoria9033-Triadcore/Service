IF (Base.ProcedureExists('Service','DeleteJobScheduleHistory')=1)
	DROP PROCEDURE [Service].[DeleteJobScheduleHistory]

GO

/*---------------------------------------------------------------------------------------------------------------------
Deletes the JobScheduleHistory from the [JobScheduleHistory] table.
Create Date: 2023.08.31
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[DeleteJobScheduleHistory]
(
	@JobScheduleHistoryId INT
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1
DECLARE @Comment VARCHAR(200) = ''
DECLARE @CommentRef VARCHAR(400) = ''

IF ( @JobScheduleHistoryId IS NULL ) BEGIN
	RAISERROR('The JobScheduleHistoryId parameter is null.',11,1)
	GOTO HANDLE_ERROR1
END

IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId=ISNULL([UserId],-102) FROM Base.Users WITH (NOLOCK) WHERE [DefaultFlag]=1 
END



BEGIN TRANSACTION [TransDeleteData]

	-- Set a delete log value that identifies that this record was deleted
	SELECT @Comment='[JobScheduleId]=' + ISNULL(CAST([JobScheduleId] AS VARCHAR(200)),'Id not specified') FROM [Service].[JobScheduleHistory] WITH (NOLOCK) WHERE [JobScheduleHistoryId]=@JobScheduleHistoryId

	-- Delete from [JobScheduleHistory] table
	DELETE FROM [Service].[JobScheduleHistory] WHERE [JobScheduleHistoryId]=@JobScheduleHistoryId
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error deleting data with id=%d. Error code=%d.',11,1,@JobScheduleHistoryId,@ErrorCode)
		GOTO HANDLE_ERROR
	END
	EXEC Base.LogDelete @UpdateUserId, '[Service].[JobScheduleHistory]', @JobScheduleHistoryId, @Comment, 'SP [Service].[DeleteJobScheduleHistory]'

COMMIT TRANSACTION [TransDeleteData]


RETURN 0

HANDLE_ERROR:
ROLLBACK TRANSACTION [TransDeleteData]
RETURN -1

HANDLE_ERROR1:
RETURN -2
