IF (Base.ProcedureExists('Service','GetJobScheduleHistories')=1)
	DROP PROCEDURE [Service].[GetJobScheduleHistories]

GO

/*---------------------------------------------------------------------------------------------------------------------
Returns results based on the criteria specified in the parameters.
The calling program is required to embed the proper single quotes into the paramenters.
Note: Specifying @GroupingLogic='OR' requires that at least one of the input arguments is not 'null'.
Create Date: 2023.08.31
Created By : Triadcore (ACB)
Note       : Special modification to include column [Service].[JobSchedules].[NextStart], which is not doable 
			 with ACB.
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[GetJobScheduleHistories]
(
	@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,@JobScheduleHistoryId INT
	,@CreateUserId INT
	,@UpdateUserId INT
	,@JobScheduleId INT
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


----------------------------------------------------------------------------------------------------------------------------------
-- Return result set.
----------------------------------------------------------------------------------------------------------------------------------
IF (@GroupingLogic = 'AND') BEGIN  

	SELECT [jsh].[JobScheduleHistoryId]
			, [jsh].[CreateDate], [jsh].[CreateUserId], [usrs].[UserName] AS [CreateUserName], [jsh].[UpdateDate], [jsh].[UpdateUserId], [usrs1].[UserName] AS [UpdateUserName], [jsh].[RecordComment]
			, [jsh].[JobScheduleId], [jbschdls].[JobScheduleName] AS [JobScheduleName], [jsh].[ExecuteDateTimeStart], [jsh].[ExecuteDateTimeEnd], [jsh].[ExecuteUserName], [jsh].[ExecuteParams], [jsh].[ResultCode], [jsh].[ResultText]
			, [jbschdls].[NextStart]
			, [jsh].[Note]
	FROM [Service].[JobScheduleHistory] jsh WITH (NOLOCK)
				LEFT OUTER JOIN [base].[Users] [usrs] WITH (NOLOCK) ON [jsh].[CreateUserId]=[usrs].[UserId]
				LEFT OUTER JOIN [base].[Users] [usrs1] WITH (NOLOCK) ON [jsh].[UpdateUserId]=[usrs1].[UserId]
				LEFT OUTER JOIN [Service].[JobSchedules] [jbschdls] WITH (NOLOCK) ON [jsh].[JobScheduleId]=[jbschdls].[JobScheduleId]
	WHERE       ((@JobScheduleHistoryId IS NULL) OR (@JobScheduleHistoryId IS NOT NULL AND @JobScheduleHistoryId = [jsh].[JobScheduleHistoryId]) )
	        AND ((@CreateUserId IS NULL) OR (@CreateUserId IS NOT NULL AND @CreateUserId = [jsh].[CreateUserId]) )
			AND ((@UpdateUserId IS NULL) OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [jsh].[UpdateUserId]) )
			AND ((@JobScheduleId IS NULL) OR (@JobScheduleId IS NOT NULL AND @JobScheduleId = [jsh].[JobScheduleId]) )
			AND ((@ResultCode IS NULL) OR (@ResultCode IS NOT NULL AND @ResultCode = [jsh].[ResultCode]) )
			AND ((@ResultText IS NULL) OR ( @ResultText IS NOT NULL AND ((@ResultTextCompareLogic = '='        AND [jsh].[ResultText] =  @ResultText)
																	OR (@ResultTextCompareLogic = '<>'       AND [jsh].[ResultText] <> @ResultText)
																	OR (@ResultTextCompareLogic = 'LIKE'     AND [jsh].[ResultText] LIKE @ResultText)
																	OR (@ResultTextCompareLogic = 'NOT LIKE' AND [jsh].[ResultText] NOT LIKE @ResultText)
																	OR (@ResultTextCompareLogic = 'IN'       AND [jsh].[ResultText] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ResultText, '''', ''''''), ',', '''')))
																	OR (@ResultTextCompareLogic = 'NOT IN'   AND [jsh].[ResultText] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ResultText, '''', ''''''), ',', ''''))) )))
	ORDER BY [jsh].[ExecuteDateTimeStart] DESC, [jsh].[ExecuteDateTimeEnd] DESC
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error retrieving JobScheduleHistory(s). Error code=%d. Grouping logic = AND.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END
ELSE BEGIN  -- 'OR' 

	SELECT [jsh].[JobScheduleHistoryId]
			, [jsh].[CreateDate], [jsh].[CreateUserId], [usrs].[UserName] AS [CreateUserName], [jsh].[UpdateDate], [jsh].[UpdateUserId], [usrs1].[UserName] AS [UpdateUserName], [jsh].[RecordComment]
			, [jsh].[JobScheduleId], [jbschdls].[JobScheduleName] AS [JobScheduleName], [jsh].[ExecuteDateTimeStart], [jsh].[ExecuteDateTimeEnd], [jsh].[ExecuteUserName], [jsh].[ExecuteParams], [jsh].[ResultCode], [jsh].[ResultText]
			, [jbschdls].[NextStart]
			, [jsh].[Note]
	FROM [Service].[JobScheduleHistory] jsh WITH (NOLOCK)
				LEFT OUTER JOIN [base].[Users] [usrs] WITH (NOLOCK) ON [jsh].[CreateUserId]=[usrs].[UserId]
				LEFT OUTER JOIN [base].[Users] [usrs1] WITH (NOLOCK) ON [jsh].[UpdateUserId]=[usrs1].[UserId]
				LEFT OUTER JOIN [Service].[JobSchedules] [jbschdls] WITH (NOLOCK) ON [jsh].[JobScheduleId]=[jbschdls].[JobScheduleId]
	WHERE      (@JobScheduleHistoryId IS NOT NULL AND @JobScheduleHistoryId = [jsh].[JobScheduleHistoryId])
	        OR (@CreateUserId IS NOT NULL AND @CreateUserId = [jsh].[CreateUserId])
			OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [jsh].[UpdateUserId])
			OR (@JobScheduleId IS NOT NULL AND @JobScheduleId = [jsh].[JobScheduleId])
			OR (@ResultCode IS NOT NULL AND @ResultCode = [jsh].[ResultCode])
			OR (@ResultText IS NOT NULL	AND ( (@ResultTextCompareLogic = '='        AND [jsh].[ResultText] = @ResultText)
											OR (@ResultTextCompareLogic = '<>'       AND [jsh].[ResultText] <> @ResultText)
											OR (@ResultTextCompareLogic = 'LIKE'     AND [jsh].[ResultText] LIKE @ResultText)
											OR (@ResultTextCompareLogic = 'NOT LIKE' AND [jsh].[ResultText] NOT LIKE @ResultText)
											OR (@ResultTextCompareLogic = 'IN'       AND [jsh].[ResultText] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ResultText, '''', ''''''), ',', '''')))
											OR (@ResultTextCompareLogic = 'NOT IN'   AND [jsh].[ResultText] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ResultText, '''', ''''''), ',', '''')) )))
	ORDER BY [jsh].[ExecuteDateTimeStart] DESC, [jsh].[ExecuteDateTimeEnd] DESC
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error retrieving JobScheduleHistory(s). Error code=%d. Grouping logic = OR.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END

RETURN 0

HANDLE_ERROR:
RETURN -1

