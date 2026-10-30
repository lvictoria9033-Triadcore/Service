IF (Base.ProcedureExists('Service','SetJobScheduleHistoryActivation') = 1)
	DROP PROCEDURE [Service].[SetJobScheduleHistoryActivation]

GO

/*---------------------------------------------------------------------------------------------------------------------
Sets the Active column for a record.
Create Date: 2026.10.30
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[SetJobScheduleHistoryActivation]
(
	@JobScheduleHistoryId INT
	,@Active BIT -- 0 or 1 only
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1
DECLARE @CurrentFlag BIT = NULL

IF ( @JobScheduleHistoryId IS NULL ) BEGIN
	RAISERROR('The JobScheduleHistory ID is not specified',11,1)
	GOTO HANDLE_ERROR
END

IF ( @Active IS NULL ) BEGIN
	RAISERROR('The Active bit is not specified',11,1)
	GOTO HANDLE_ERROR
END

IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId = ISNULL(UserId,-102) FROM [Base].[Users] WITH (NOLOCK) WHERE [DefaultFlag] = 1
END



-- Get current value - for UpdateMarkup
SELECT @CurrentFlag = Active FROM  [Service].[JobScheduleHistories] WITH (NOLOCK) WHERE [JobScheduleHistoryId] = @JobScheduleHistoryId

-- Set the Active flag
UPDATE [Service].[JobScheduleHistories]
	SET [Active] = @Active, [UpdateUserId] = @UpdateUserId, [UpdateDate] = GETDATE()
	WHERE [JobScheduleHistoryId] = @JobScheduleHistoryId
SET @ErrorCode = @@ERROR
IF ( @ErrorCode <> 0 ) BEGIN
	DECLARE @ActiveFlag INT = CAST(@Active AS INT)
	RAISERROR('Failed to update the Active flag to [%d] for record ID=%d in table [Service].[JobScheduleHistories]. Error code=%d.',18,3,@ActiveFlag,@JobScheduleHistoryId,@ErrorCode)
	GOTO HANDLE_ERROR
END



SELECT @JobScheduleHistoryId

RETURN 0

HANDLE_ERROR:
RETURN -1

