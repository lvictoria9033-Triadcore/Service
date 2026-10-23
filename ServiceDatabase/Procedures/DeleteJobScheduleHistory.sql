IF (Base.ProcedureExists('Service','DeleteJobScheduleHistory') = 1)
	DROP PROCEDURE [Service].[DeleteJobScheduleHistory]

GO

/*---------------------------------------------------------------------------------------------------------------------
Deletes the JobScheduleHistory from the [JobScheduleHistories] table.
Create Date: 2026.10.23
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[DeleteJobScheduleHistory]
(
	@JobScheduleHistoryId INT
	,@Note VARCHAR(900)
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1
DECLARE @Comment VARCHAR(1000) = ''

IF ( @JobScheduleHistoryId IS NULL ) BEGIN
	RAISERROR('The JobScheduleHistoryId parameter is null.',11,1)
	GOTO HANDLE_ERROR1
END

IF (@Note IS NULL) BEGIN
	SET @Note = ''
END

IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId = ISNULL([UserId],-102) FROM Base.Users WITH (NOLOCK) WHERE [DefaultFlag] = 1 
END



BEGIN TRANSACTION [TransDeleteData]

	-- Set a delete log value that identifies that this record was deleted
	SELECT @Comment='[JobScheduleId]=' + ISNULL(CAST([JobScheduleId] AS VARCHAR(200)),'Uid not specified') + '; ' + @Note FROM [Service].[JobScheduleHistories] WITH (NOLOCK) WHERE [JobScheduleHistoryId] = @JobScheduleHistoryId

	-- Delete from [JobScheduleHistories] table
	DELETE FROM [Service].[JobScheduleHistories] WHERE [JobScheduleHistoryId] = @JobScheduleHistoryId
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode <> 0) BEGIN
		RAISERROR('Error deleting data with id=%d. Error code=%d.',11,1,@JobScheduleHistoryId,@ErrorCode)
		GOTO HANDLE_ERROR
	END
	EXEC Base.LogDelete @UpdateUserId, '[Service].[JobScheduleHistories]', @JobScheduleHistoryId, @Comment, 'SP [Service].[DeleteJobScheduleHistory]'

COMMIT TRANSACTION [TransDeleteData]


RETURN 0

HANDLE_ERROR:
ROLLBACK TRANSACTION [TransDeleteData]
RETURN -1

HANDLE_ERROR1:
RETURN -2
