IF (Base.ProcedureExists('Service','DeleteJobSchedule')=1)
	DROP PROCEDURE [Service].[DeleteJobSchedule]

GO

/*---------------------------------------------------------------------------------------------------------------------
Deletes the job from the JobSchedules table.
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[DeleteJobSchedule]
(
	@JobScheduleId INT
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1
DECLARE @Comment VARCHAR(200) = ''

IF ( @JobScheduleId IS NULL ) BEGIN
	RAISERROR('The Job ID is not specified.',11,1)
	GOTO HANDLE_ERROR
END

--SELECT @Comment=JobScheduleName FROM [Service].JobSchedules WHERE JobScheduleId=@JobScheduleId
IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId=ISNULL(UserId,-102) FROM Base.Users WHERE DefaultFlag=1
END

-- Delete the record
BEGIN TRANSACTION DeleteJobSchedule

	-- Set a delete log value that identifies that this record was deleted
	SELECT @Comment='[JobScheduleName]=' + JobScheduleName FROM [Service].JobSchedules WHERE JobScheduleId=@JobScheduleId

	DELETE 
		FROM [Service].JobSchedules 
		WHERE JobScheduleId = @JobScheduleId
	SET @ErrorCode = @@ERROR
	IF ( @ErrorCode <> 0 ) BEGIN
		RAISERROR('Failed to delete record ID=%d in table [Service].JobSchedules. Error code=%d.',18,4,@JobScheduleId,@ErrorCode)
		GOTO HANDLE_ERROR
	END

COMMIT TRANSACTION DeleteJobSchedule

EXEC Base.LogDelete @UpdateUserId, '[Service].JobSchedules', @JobScheduleId, @Comment, 'SP [Service].DeleteJobSchedule'

SELECT 0

RETURN 0

HANDLE_ERROR:
ROLLBACK TRANSACTION DeleteJobSchedule
RETURN -1
