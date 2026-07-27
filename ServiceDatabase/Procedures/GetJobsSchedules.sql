IF (Base.ProcedureExists('Service','GetJobSchedules')=1)
	DROP PROCEDURE [Service].[GetJobSchedules]

GO

/*---------------------------------------------------------------------------------------------------------------------
Returns job schedules from the JobSchedules table.
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[GetJobSchedules]
(
	@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,@JobScheduleId INT
	,@JobScheduleNameCompareLogic VARCHAR(8)  -- only '=','<>,'LIKE', 'NOT LIKE', 'IN', 'NOT IN'
	,@JobScheduleName VARCHAR(100)
	,@JobId INT
	,@NextStartCompareLogic VARCHAR(8)  -- only '=', '<', '>', '<=', '>='
	,@NextStart DATETIME
	,@Active BIT
	,@UpdateUserId INT
	,@CreateUserId INT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1

IF (@GroupingLogic IS NULL) BEGIN
	SET @GroupingLogic = 'AND'  -- 'AND', 'OR'
END
ELSE BEGIN
	IF ( @GroupingLogic NOT IN ('AND','OR') ) BEGIN
		RAISERROR('The grouping logic ''%s'' is invalid',11,1,@GroupingLogic)
		GOTO HANDLE_ERROR
	END
END

IF ((@JobScheduleName IS NOT NULL) AND (@JobScheduleNameCompareLogic IS NULL)) BEGIN
	SET @JobScheduleNameCompareLogic = '='
END

IF ((@NextStart IS NOT NULL) AND (@NextStartCompareLogic IS NULL)) BEGIN
	SET @NextStartCompareLogic = '='
END

----------------------------------------------------------------------------------------------------------------------------------
-- Return result set.
----------------------------------------------------------------------------------------------------------------------------------
IF (@GroupingLogic = 'OR') BEGIN --  'OR'  

	SELECT js.JobScheduleId, js.JobScheduleName, js.[Description], js.JobScheduleTypeId, jst.JobScheduleTypeName, js.BaseDateTime, js.NextStart
		, js.[Interval], js.[Month], js.[Day], js.[Date], js.[Time], js.IsRecurring, js.RunAsUser, js.RunAsPassword
		, j.JobId, j.JobName
		, js.Active, js.UpdateDate, js.UpdateUserId, js.CreateDate, js.CreateUserId, js.RecordComment
	FROM [Service].JobSchedules js WITH (NOLOCK) 
		JOIN [Service].Jobs j WITH (NOLOCK) ON js.JobId=j.JobId 
		JOIN [Service].JobScheduleTypes jst WITH (NOLOCK) ON js.JobScheduleTypeId=jst.JobScheduleTypeId
	WHERE			( @JobScheduleId IS NOT NULL	AND  @JobScheduleId=js.JobScheduleId )
				OR	( @JobId IS NOT NULL			AND  @JobId=js.JobId )
				OR	( @JobScheduleName IS NOT NULL	AND  (		(@JobScheduleNameCompareLogic='='			AND js.JobScheduleName=@JobScheduleName) 
															OR	(@JobScheduleNameCompareLogic='<='			AND js.JobScheduleName<>@JobScheduleName)
															OR	(@JobScheduleNameCompareLogic='LIKE'		AND js.JobScheduleName LIKE @JobScheduleName)
															OR	(@JobScheduleNameCompareLogic='NOT LIKE'	AND js.JobScheduleName NOT LIKE @JobScheduleName)
															OR	(@JobScheduleNameCompareLogic='IN'			AND js.JobScheduleName IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleName,'''',''''''), ',', '''')))
															OR	(@JobScheduleNameCompareLogic='NOT IN'		AND js.JobScheduleName NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleName,'''',''''''), ',', ''''))) ) )
				OR	( @NextStart IS NOT NULL		AND  (		(@NextStartCompareLogic='='		AND js.NextStart=@NextStart) 
															OR	(@NextStartCompareLogic='<='	AND js.NextStart<=@NextStart)
															OR	(@NextStartCompareLogic='>='	AND js.NextStart>=@NextStart)
															OR	(@NextStartCompareLogic='<'		AND js.NextStart<@NextStart)
															OR	(@NextStartCompareLogic='>'		AND js.NextStart>@NextStart) ) )
				OR  ( @Active IS NOT NULL			AND  @Active=js.Active )
				OR  ( @UpdateUserId IS NOT NULL		AND  @UpdateUserId=js.UpdateUserId )
				OR  ( @CreateUserId IS NOT NULL		AND  @CreateUserId=js.CreateUserId ) 
	ORDER BY js.Active DESC, js.NextStart
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error retrieving job schedule(s). Error code=%d. Logic condition=OR.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END
ELSE BEGIN  -- 'AND' 

	SELECT js.JobScheduleId, js.JobScheduleName, js.[Description], js.JobScheduleTypeId, jst.JobScheduleTypeName, js.BaseDateTime, js.NextStart
		, js.[Interval], js.[Month], js.[Day], js.[Date], js.[Time], js.IsRecurring, js.RunAsUser, js.RunAsPassword
		, j.JobId, j.JobName
		, js.Active, js.UpdateDate, js.UpdateUserId, js.CreateDate, js.CreateUserId, js.RecordComment
	FROM [Service].JobSchedules js WITH (NOLOCK) 
		JOIN [Service].Jobs j WITH (NOLOCK) ON js.JobId=j.JobId 
		JOIN [Service].JobScheduleTypes jst WITH (NOLOCK) ON js.JobScheduleTypeId=jst.JobScheduleTypeId
	WHERE		( (@JobScheduleId IS NULL)		OR  (@JobScheduleId IS NOT NULL AND @JobScheduleId=js.JobScheduleId) )
			AND ( (@JobId IS NULL)				OR  (@JobId IS NOT NULL AND @JobId=js.JobId) )
			AND ( (@JobScheduleName IS NULL)	OR  (@JobScheduleName IS NOT NULL	AND (		(@JobScheduleNameCompareLogic='='			AND js.JobScheduleName=@JobScheduleName) 
																							OR	(@JobScheduleNameCompareLogic='<>'			AND js.JobScheduleName<>@JobScheduleName)
																							OR	(@JobScheduleNameCompareLogic='LIKE'		AND js.JobScheduleName LIKE @JobScheduleName)
																							OR	(@JobScheduleNameCompareLogic='NOT LIKE'	AND js.JobScheduleName NOT LIKE @JobScheduleName)
																							OR	(@JobScheduleNameCompareLogic='IN'			AND js.JobScheduleName IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleName,'''',''''''), ',', '''')))
																							OR	(@JobScheduleNameCompareLogic='NOT IN'		AND js.JobScheduleName NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleName,'''',''''''), ',', ''''))) ) ) ) 
			AND ( (@NextStart IS NULL)			OR  (@NextStart IS NOT NULL	AND (		(@NextStartCompareLogic='='		AND js.NextStart=@NextStart) 
																					OR	(@NextStartCompareLogic='<='	AND js.NextStart<=@NextStart)
																					OR	(@NextStartCompareLogic='>='	AND js.NextStart>=@NextStart)
																					OR	(@NextStartCompareLogic='<'		AND js.NextStart<@NextStart)
																					OR	(@NextStartCompareLogic='>'		AND js.NextStart>@NextStart) ) ) )
			AND ( (@Active IS NULL)				OR  (@Active IS NOT NULL AND @Active=js.Active) )
			AND ( (@UpdateUserId IS NULL)		OR	(@UpdateUserId IS NOT NULL AND @UpdateUserId=js.UpdateUserId) )
			AND ( (@CreateUserId IS NULL)		OR	(@CreateUserId IS NOT NULL AND @CreateUserId=js.CreateUserId) )
	ORDER BY js.Active DESC, js.NextStart
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error retrieving job schedule(s). Error code=%d. Logic condition=AND.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END

RETURN 0

HANDLE_ERROR:
RETURN -1

