IF (Base.ProcedureExists('Service','DeleteJobScheduleType')=1)
	DROP PROCEDURE [Service].[DeleteJobScheduleType]

GO

/*---------------------------------------------------------------------------------------------------------------------
Deletes the JobScheduleType from the [JobScheduleTypes] table.
Create Date: 2023.07.01
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[DeleteJobScheduleType]
(
	@JobScheduleTypeId INT
	,@UpdateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1
DECLARE @Comment VARCHAR(200) = ''
DECLARE @CommentRef VARCHAR(400) = ''

IF ( @JobScheduleTypeId IS NULL ) BEGIN
	RAISERROR('The JobScheduleTypeId parameter is null.',11,1)
	GOTO HANDLE_ERROR1
END

IF ( @UpdateUserId IS NULL ) BEGIN
	SET @UpdateUserId = -101
	SELECT @UpdateUserId=ISNULL([UserId],-102) FROM Base.Users WITH (NOLOCK) WHERE [DefaultFlag]=1 
END



BEGIN TRANSACTION [TransDeleteData]

	-- Set a delete log value that identifies that this record was deleted
	SELECT @Comment=ISNULL(CAST([JobScheduleTypeName] AS VARCHAR(200)),'Id not specified') FROM [Service].[JobScheduleTypes] WITH (NOLOCK) WHERE [JobScheduleTypeId]=@JobScheduleTypeId

	-- Delete from [JobScheduleTypes] table
	DELETE FROM [Service].[JobScheduleTypes] WHERE [JobScheduleTypeId]=@JobScheduleTypeId
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error deleting data with id=%d. Error code=%d.',11,1,@JobScheduleTypeId,@ErrorCode)
		GOTO HANDLE_ERROR
	END
	EXEC Base.LogDelete @UpdateUserId, '[Service].[JobScheduleTypes]', @JobScheduleTypeId, @Comment, 'SP [Service].[DeleteJobScheduleType]'

COMMIT TRANSACTION [TransDeleteData]


RETURN 0

HANDLE_ERROR:
ROLLBACK TRANSACTION [TransDeleteData]
RETURN -1

HANDLE_ERROR1:
RETURN -2
