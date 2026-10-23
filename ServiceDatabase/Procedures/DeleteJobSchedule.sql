IF (Base.ProcedureExists('Service','DeleteJobSchedule') = 1)
	DROP PROCEDURE [Service].[DeleteJobSchedule]

GO

/*---------------------------------------------------------------------------------------------------------------------
Deletes the JobSchedule from the [JobSchedules] table.
Create Date: 2026.10.23
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[DeleteJobSchedule]
(
	@JobScheduleId INT
	,@Note VARCHAR(900)
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1
DECLARE @Comment VARCHAR(1000) = ''

IF ( @JobScheduleId IS NULL ) BEGIN
	RAISERROR('The JobScheduleId parameter is null.',11,1)
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
	SELECT @Comment='[JobScheduleName]=' + ISNULL(CAST([JobScheduleName] AS VARCHAR(200)),'Uid not specified') + '; ' + @Note FROM [Service].[JobSchedules] WITH (NOLOCK) WHERE [JobScheduleId] = @JobScheduleId

	-- Delete from [JobSchedules] table
	DELETE FROM [Service].[JobSchedules] WHERE [JobScheduleId] = @JobScheduleId
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode <> 0) BEGIN
		RAISERROR('Error deleting data with id=%d. Error code=%d.',11,1,@JobScheduleId,@ErrorCode)
		GOTO HANDLE_ERROR
	END
	EXEC Base.LogDelete @UpdateUserId, '[Service].[JobSchedules]', @JobScheduleId, @Comment, 'SP [Service].[DeleteJobSchedule]'

COMMIT TRANSACTION [TransDeleteData]


RETURN 0

HANDLE_ERROR:
ROLLBACK TRANSACTION [TransDeleteData]
RETURN -1

HANDLE_ERROR1:
RETURN -2
