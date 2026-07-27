IF (Base.ProcedureExists('Service','SetJobScheduleActivation')=1)
	DROP PROCEDURE [Service].[SetJobScheduleActivation]

GO

/*----------------------------------------------------
Sets the Active column for a job schedule record.
----------------------------------------------------*/
CREATE PROCEDURE [Service].[SetJobScheduleActivation]
(
	@JobScheduleId INT
	,@Active BIT -- 0 or 1 only
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1

IF ( @JobScheduleId IS NULL ) BEGIN
	RAISERROR('The Job Schedule Id is not specified',11,1)
	GOTO HANDLE_ERROR
END

IF ( @Active IS NULL ) BEGIN	
	RAISERROR('The @Active parameter is null.',11,1)
	GOTO HANDLE_ERROR
END

IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId=ISNULL(UserId,-102) FROM Base.Users WHERE DefaultFlag=1 
END

-- Set the Active flag
UPDATE [Service].JobSchedules 
	SET Active = @Active
		, UpdateUserId = @UpdateUserId
		, UpdateDate = GETDATE()
	WHERE JobScheduleId = @JobScheduleId
SET @ErrorCode = @@ERROR
IF ( @ErrorCode <> 0 ) BEGIN
	DECLARE @ActiveFlag INT = CAST(@Active AS INT)
	RAISERROR('Failed to update the Active flag to [%d] for record ID=%d in table [Service].JobSchedules. Error code=%d.',18,3,@ActiveFlag,@JobScheduleId,@ErrorCode)
	GOTO HANDLE_ERROR
END

SELECT @JobScheduleId

RETURN 0

HANDLE_ERROR:
RETURN -1
