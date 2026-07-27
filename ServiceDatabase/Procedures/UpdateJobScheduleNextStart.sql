IF (Base.ProcedureExists('Service','UpdateJobScheduleNextStart')=1)
	DROP PROCEDURE [Service].[UpdateJobScheduleNextStart]
GO

/*--------------------------------------------------------------------------------------------------
Updates a job schedule record.
Sets the NextStart column of the JobSchedules table to next run date time from from the 
interval rows in in JobScheduleIntervals table.
--------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[UpdateJobScheduleNextStart]
(
	@JobScheduleId INT
	, @UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1
DECLARE @NextStart DATETIME = NULL

IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId=ISNULL(UserId,-102) FROM Base.Users WHERE DefaultFlag=1 
END

BEGIN TRANSACTION UpdateJobScheduleNextStart

	SET @NextStart = [Service].GetJobScheduleNextRun(@JobScheduleId)

	UPDATE [Service].JobSchedules
	SET NextStart = @NextStart
	WHERE JobScheduleId=ISNULL(@JobScheduleId, JobScheduleId)

COMMIT TRANSACTION UpdateJobScheduleNextStart

SELECT @NextStart

RETURN 0

HANDLE_ERROR:
ROLLBACK TRANSACTION UpdateJobScheduleNextStart
RETURN -1

HANDLE_ERROR1:
RETURN -2
