IF (Base.ProcedureExists('Service','GetJobScheduleHistories') = 1)
	DROP PROCEDURE [Service].[GetJobScheduleHistories]

GO

/*---------------------------------------------------------------------------------------------------------------------
Returns results based on the criteria specified in the parameters.
The calling program is required to embed the proper single quotes into the parameters.
Note: Specifying @GroupingLogic='OR' requires that at least one of the input arguments is not 'null'.
Create Date: 2026.10.23
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[GetJobScheduleHistories]
(
	@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,@JobScheduleHistoryId INT
	,@CreateDate DATETIME
	,@CreateUserId INT -- Fkey
	,@UpdateDate DATETIME
	,@UpdateUserId INT -- Fkey
	,@Active BIT
	,@JobScheduleId INT -- Fkey
	,@ExecuteDateTimeStartCompareLogic VARCHAR(10)
	,@ExecuteDateTimeStart DATETIME
	,@ExecuteDateTimeEndCompareLogic VARCHAR(10)
	,@ExecuteDateTimeEnd DATETIME
	,@ExecuteUserNameCompareLogic VARCHAR(10)
	,@ExecuteUserName VARCHAR(100)
	,@ResultCode INT
	,@ResultTextCompareLogic VARCHAR(10)
	,@ResultText VARCHAR(1000)
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1


IF ( @GroupingLogic IS NULL ) BEGIN
	SET @GroupingLogic = 'AND'
END
ELSE BEGIN
	IF ( @GroupingLogic NOT IN ('AND','OR') ) BEGIN
		RAISERROR('The grouping logic ''%s'' is invalid',11,1,@GroupingLogic)
		GOTO HANDLE_ERROR
	END
END

IF (@ExecuteDateTimeStart IS NOT NULL AND @ExecuteDateTimeStartCompareLogic IS NULL) BEGIN
	SET @ExecuteDateTimeStartCompareLogic = '='
END

IF (@ExecuteDateTimeEnd IS NOT NULL AND @ExecuteDateTimeEndCompareLogic IS NULL) BEGIN
	SET @ExecuteDateTimeEndCompareLogic = '='
END

IF (@ExecuteUserName IS NOT NULL AND @ExecuteUserNameCompareLogic IS NULL) BEGIN
	SET @ExecuteUserNameCompareLogic = '='
END

IF (@ResultText IS NOT NULL AND @ResultTextCompareLogic IS NULL) BEGIN
	SET @ResultTextCompareLogic = '='
END




----------------------------------------------------------------------------------------------------------------------------------
-- Return result set.
----------------------------------------------------------------------------------------------------------------------------------
IF (@GroupingLogic = 'AND') BEGIN  

	SELECT [jsh].[JobScheduleHistoryId]
				, [jsh].[CreateDate], [jsh].[CreateUserId], [usrs].[UserName] AS [CreateUserName], [jsh].[UpdateDate], [jsh].[UpdateUserId], [usrs1].[UserName] AS [UpdateUserName]
				, [jsh].[Active]
				, [jsh].[JobScheduleId], [jbschdls].[JobScheduleName] AS [JobScheduleName], [jsh].[ExecuteDateTimeStart], [jsh].[ExecuteDateTimeEnd], [jsh].[ExecuteUserName], [jsh].[ExecuteParams]
				, [jsh].[ResultCode], [jsh].[ResultText], [jsh].[Note]
	FROM [Service].[JobScheduleHistories] [jsh] WITH (NOLOCK)
				LEFT OUTER JOIN [Base].[Users] [usrs] WITH (NOLOCK) ON [jsh].[CreateUserId] = [usrs].[UserId]
				LEFT OUTER JOIN [Base].[Users] [usrs1] WITH (NOLOCK) ON [jsh].[UpdateUserId] = [usrs1].[UserId]
				LEFT OUTER JOIN [Service].[JobSchedules] [jbschdls] WITH (NOLOCK) ON [jsh].[JobScheduleId] = [jbschdls].[JobScheduleId]
	WHERE       ((@JobScheduleHistoryId IS NULL) OR (@JobScheduleHistoryId IS NOT NULL AND @JobScheduleHistoryId = [jsh].[JobScheduleHistoryId]) )
							 AND ((@CreateDate IS NULL) OR (@CreateDate IS NOT NULL AND @CreateDate = [jsh].[CreateDate]) )
							AND ((@CreateUserId IS NULL) OR (@CreateUserId IS NOT NULL AND @CreateUserId = [jsh].[CreateUserId]) )
							 AND ((@UpdateDate IS NULL) OR (@UpdateDate IS NOT NULL AND @UpdateDate = [jsh].[UpdateDate]) )
							AND ((@UpdateUserId IS NULL) OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [jsh].[UpdateUserId]) )
							AND ((@Active IS NULL) OR (@Active IS NOT NULL AND @Active = [jsh].[Active]) )
							AND ((@JobScheduleId IS NULL) OR (@JobScheduleId IS NOT NULL AND @JobScheduleId = [jsh].[JobScheduleId]) )
							AND ((@ExecuteDateTimeStart IS NULL) OR ( @ExecuteDateTimeStart IS NOT NULL AND ((@ExecuteDateTimeStartCompareLogic = '='  AND [jsh].[ExecuteDateTimeStart] =  @ExecuteDateTimeStart)
																					OR (@ExecuteDateTimeStartCompareLogic = '<>' AND [jsh].[ExecuteDateTimeStart] <> @ExecuteDateTimeStart)
																					OR (@ExecuteDateTimeStartCompareLogic = '<=' AND [jsh].[ExecuteDateTimeStart] <= @ExecuteDateTimeStart)
																					OR (@ExecuteDateTimeStartCompareLogic = '>=' AND [jsh].[ExecuteDateTimeStart] >= @ExecuteDateTimeStart)
																					OR (@ExecuteDateTimeStartCompareLogic = '<'  AND [jsh].[ExecuteDateTimeStart] <  @ExecuteDateTimeStart)
																					OR (@ExecuteDateTimeStartCompareLogic = '>'  AND [jsh].[ExecuteDateTimeStart] >  @ExecuteDateTimeStart))))
							AND ((@ExecuteDateTimeEnd IS NULL) OR ( @ExecuteDateTimeEnd IS NOT NULL AND ((@ExecuteDateTimeEndCompareLogic = '='  AND [jsh].[ExecuteDateTimeEnd] =  @ExecuteDateTimeEnd)
																					OR (@ExecuteDateTimeEndCompareLogic = '<>' AND [jsh].[ExecuteDateTimeEnd] <> @ExecuteDateTimeEnd)
																					OR (@ExecuteDateTimeEndCompareLogic = '<=' AND [jsh].[ExecuteDateTimeEnd] <= @ExecuteDateTimeEnd)
																					OR (@ExecuteDateTimeEndCompareLogic = '>=' AND [jsh].[ExecuteDateTimeEnd] >= @ExecuteDateTimeEnd)
																					OR (@ExecuteDateTimeEndCompareLogic = '<'  AND [jsh].[ExecuteDateTimeEnd] <  @ExecuteDateTimeEnd)
																					OR (@ExecuteDateTimeEndCompareLogic = '>'  AND [jsh].[ExecuteDateTimeEnd] >  @ExecuteDateTimeEnd))))
							AND ((@ExecuteUserName IS NULL) OR ( @ExecuteUserName IS NOT NULL AND ((@ExecuteUserNameCompareLogic = '='        AND [jsh].[ExecuteUserName] = @ExecuteUserName)
																					OR (@ExecuteUserNameCompareLogic = '<>'       AND [jsh].[ExecuteUserName] <> @ExecuteUserName)
																					OR (@ExecuteUserNameCompareLogic = 'LIKE'     AND [jsh].[ExecuteUserName] LIKE @ExecuteUserName)
																					OR (@ExecuteUserNameCompareLogic = 'NOT LIKE' AND [jsh].[ExecuteUserName] NOT LIKE @ExecuteUserName)
																					OR (@ExecuteUserNameCompareLogic = 'IN'       AND [jsh].[ExecuteUserName] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ExecuteUserName, '''', ''''''), ',', '''')))
																					OR (@ExecuteUserNameCompareLogic = 'NOT IN'   AND [jsh].[ExecuteUserName] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ExecuteUserName, '''', ''''''), ',', ''''))) )))
							AND ((@ResultCode IS NULL) OR (@ResultCode IS NOT NULL AND @ResultCode = [jsh].[ResultCode]) )
							AND ((@ResultText IS NULL) OR ( @ResultText IS NOT NULL AND ((@ResultTextCompareLogic = '='        AND [jsh].[ResultText] = @ResultText)
																					OR (@ResultTextCompareLogic = '<>'       AND [jsh].[ResultText] <> @ResultText)
																					OR (@ResultTextCompareLogic = 'LIKE'     AND [jsh].[ResultText] LIKE @ResultText)
																					OR (@ResultTextCompareLogic = 'NOT LIKE' AND [jsh].[ResultText] NOT LIKE @ResultText)
																					OR (@ResultTextCompareLogic = 'IN'       AND [jsh].[ResultText] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ResultText, '''', ''''''), ',', '''')))
																					OR (@ResultTextCompareLogic = 'NOT IN'   AND [jsh].[ResultText] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ResultText, '''', ''''''), ',', ''''))) )))
	
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode <> 0) BEGIN
		RAISERROR('Error retrieving JobScheduleHistory(s). Error code=%d. Grouping logic = AND.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END
ELSE BEGIN  -- 'OR' 

	SELECT [jsh].[JobScheduleHistoryId]
				, [jsh].[CreateDate], [jsh].[CreateUserId], [usrs].[UserName] AS [CreateUserName], [jsh].[UpdateDate], [jsh].[UpdateUserId], [usrs1].[UserName] AS [UpdateUserName]
				, [jsh].[Active]
				, [jsh].[JobScheduleId], [jbschdls].[JobScheduleName] AS [JobScheduleName], [jsh].[ExecuteDateTimeStart], [jsh].[ExecuteDateTimeEnd], [jsh].[ExecuteUserName], [jsh].[ExecuteParams]
				, [jsh].[ResultCode], [jsh].[ResultText], [jsh].[Note]
	FROM [Service].[JobScheduleHistories] [jsh] WITH (NOLOCK)
				LEFT OUTER JOIN [Base].[Users] [usrs] WITH (NOLOCK) ON [jsh].[CreateUserId] = [usrs].[UserId]
				LEFT OUTER JOIN [Base].[Users] [usrs1] WITH (NOLOCK) ON [jsh].[UpdateUserId] = [usrs1].[UserId]
				LEFT OUTER JOIN [Service].[JobSchedules] [jbschdls] WITH (NOLOCK) ON [jsh].[JobScheduleId] = [jbschdls].[JobScheduleId]
	WHERE      (@JobScheduleHistoryId IS NOT NULL AND @JobScheduleHistoryId = [jsh].[JobScheduleHistoryId])
							OR (@CreateDate IS NOT NULL AND @CreateDate = [jsh].[CreateDate])
							OR (@CreateUserId IS NOT NULL AND @CreateUserId = [jsh].[CreateUserId])
							OR (@UpdateDate IS NOT NULL AND @UpdateDate = [jsh].[UpdateDate])
							OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [jsh].[UpdateUserId])
							OR (@Active IS NOT NULL AND @Active = [jsh].[Active])
							OR (@JobScheduleId IS NOT NULL AND @JobScheduleId = [jsh].[JobScheduleId])
							OR (@ExecuteDateTimeStart IS NOT NULL	AND ( (@ExecuteDateTimeStartCompareLogic = '='  AND [jsh].[ExecuteDateTimeStart] = @ExecuteDateTimeStart)
															OR (@ExecuteDateTimeStartCompareLogic = '<>' AND [jsh].[ExecuteDateTimeStart] <> @ExecuteDateTimeStart)
															OR (@ExecuteDateTimeStartCompareLogic = '>=' AND [jsh].[ExecuteDateTimeStart] >= @ExecuteDateTimeStart)
															OR (@ExecuteDateTimeStartCompareLogic = '<=' AND [jsh].[ExecuteDateTimeStart] <= @ExecuteDateTimeStart)
															OR (@ExecuteDateTimeStartCompareLogic = '>'  AND [jsh].[ExecuteDateTimeStart] >  @ExecuteDateTimeStart)
															OR (@ExecuteDateTimeStartCompareLogic = '<'  AND [jsh].[ExecuteDateTimeStart] <  @ExecuteDateTimeStart)))
							OR (@ExecuteDateTimeEnd IS NOT NULL	AND ( (@ExecuteDateTimeEndCompareLogic = '='  AND [jsh].[ExecuteDateTimeEnd] = @ExecuteDateTimeEnd)
															OR (@ExecuteDateTimeEndCompareLogic = '<>' AND [jsh].[ExecuteDateTimeEnd] <> @ExecuteDateTimeEnd)
															OR (@ExecuteDateTimeEndCompareLogic = '>=' AND [jsh].[ExecuteDateTimeEnd] >= @ExecuteDateTimeEnd)
															OR (@ExecuteDateTimeEndCompareLogic = '<=' AND [jsh].[ExecuteDateTimeEnd] <= @ExecuteDateTimeEnd)
															OR (@ExecuteDateTimeEndCompareLogic = '>'  AND [jsh].[ExecuteDateTimeEnd] >  @ExecuteDateTimeEnd)
															OR (@ExecuteDateTimeEndCompareLogic = '<'  AND [jsh].[ExecuteDateTimeEnd] <  @ExecuteDateTimeEnd)))
							OR (@ExecuteUserName IS NOT NULL	AND ( (@ExecuteUserNameCompareLogic = '='        AND [jsh].[ExecuteUserName] = @ExecuteUserName)
															OR (@ExecuteUserNameCompareLogic = '<>'       AND [jsh].[ExecuteUserName] <> @ExecuteUserName)
															OR (@ExecuteUserNameCompareLogic = 'LIKE'     AND [jsh].[ExecuteUserName] LIKE @ExecuteUserName)
															OR (@ExecuteUserNameCompareLogic = 'NOT LIKE' AND [jsh].[ExecuteUserName] NOT LIKE @ExecuteUserName)
															OR (@ExecuteUserNameCompareLogic = 'IN'       AND [jsh].[ExecuteUserName] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ExecuteUserName, '''', ''''''), ',', '''')))
															OR (@ExecuteUserNameCompareLogic = 'NOT IN'   AND [jsh].[ExecuteUserName] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ExecuteUserName, '''', ''''''), ',', '''')) )))
							OR (@ResultCode IS NOT NULL AND @ResultCode = [jsh].[ResultCode])
							OR (@ResultText IS NOT NULL	AND ( (@ResultTextCompareLogic = '='        AND [jsh].[ResultText] = @ResultText)
															OR (@ResultTextCompareLogic = '<>'       AND [jsh].[ResultText] <> @ResultText)
															OR (@ResultTextCompareLogic = 'LIKE'     AND [jsh].[ResultText] LIKE @ResultText)
															OR (@ResultTextCompareLogic = 'NOT LIKE' AND [jsh].[ResultText] NOT LIKE @ResultText)
															OR (@ResultTextCompareLogic = 'IN'       AND [jsh].[ResultText] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ResultText, '''', ''''''), ',', '''')))
															OR (@ResultTextCompareLogic = 'NOT IN'   AND [jsh].[ResultText] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ResultText, '''', ''''''), ',', '''')) )))
	
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode <> 0) BEGIN
		RAISERROR('Error retrieving JobScheduleHistory(s). Error code=%d. Grouping logic = OR.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END

RETURN 0

HANDLE_ERROR:
RETURN -1

