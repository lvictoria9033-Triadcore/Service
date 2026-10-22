IF (Base.ProcedureExists('Service','GetJobs') = 1)
	DROP PROCEDURE [Service].[GetJobs]

GO

/*---------------------------------------------------------------------------------------------------------------------
Returns results based on the criteria specified in the parameters.
The calling program is required to embed the proper single quotes into the parameters.
Note: Specifying @GroupingLogic='OR' requires that at least one of the input arguments is not 'null'.
Create Date: 2026.10.22
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[GetJobs]
(
	@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,@JobId INT
	,@CreateDate DATETIME
	,@CreateUserId INT -- Fkey
	,@UpdateDate DATETIME
	,@UpdateUserId INT -- Fkey
	,@Active BIT
	,@JobNameCompareLogic VARCHAR(10)
	,@JobName VARCHAR(50)
	,@ExecFileCompareLogic VARCHAR(10)
	,@ExecFile VARCHAR(200)
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

IF (@JobName IS NOT NULL AND @JobNameCompareLogic IS NULL) BEGIN
	SET @JobNameCompareLogic = '='
END

IF (@ExecFile IS NOT NULL AND @ExecFileCompareLogic IS NULL) BEGIN
	SET @ExecFileCompareLogic = '='
END




----------------------------------------------------------------------------------------------------------------------------------
-- Return result set.
----------------------------------------------------------------------------------------------------------------------------------
IF (@GroupingLogic = 'AND') BEGIN  

	SELECT [j].[JobId]
				, [j].[CreateDate], [j].[CreateUserId], [usrs].[UserName] AS [CreateUserName], [j].[UpdateDate], [j].[UpdateUserId], [usrs1].[UserName] AS [UpdateUserName]
				, [j].[Active], [j].[SortText]
				, [j].[JobName], [j].[JobFriendlyName], [j].[Description], [j].[ExecPath], [j].[ExecFile], [j].[ParamString]
				, [j].[LogStarts], [j].[LogFinishes]
	FROM [Service].[Jobs] [j] WITH (NOLOCK)
				LEFT OUTER JOIN [Base].[Users] [usrs] WITH (NOLOCK) ON [j].[CreateUserId] = [usrs].[UserId]
				LEFT OUTER JOIN [Base].[Users] [usrs1] WITH (NOLOCK) ON [j].[UpdateUserId] = [usrs1].[UserId]
	WHERE       ((@JobId IS NULL) OR (@JobId IS NOT NULL AND @JobId = [j].[JobId]) )
							 AND ((@CreateDate IS NULL) OR (@CreateDate IS NOT NULL AND @CreateDate = [j].[CreateDate]) )
							AND ((@CreateUserId IS NULL) OR (@CreateUserId IS NOT NULL AND @CreateUserId = [j].[CreateUserId]) )
							 AND ((@UpdateDate IS NULL) OR (@UpdateDate IS NOT NULL AND @UpdateDate = [j].[UpdateDate]) )
							AND ((@UpdateUserId IS NULL) OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [j].[UpdateUserId]) )
							AND ((@Active IS NULL) OR (@Active IS NOT NULL AND @Active = [j].[Active]) )
							AND ((@JobName IS NULL) OR ( @JobName IS NOT NULL AND ((@JobNameCompareLogic = '='        AND [j].[JobName] = @JobName)
																					OR (@JobNameCompareLogic = '<>'       AND [j].[JobName] <> @JobName)
																					OR (@JobNameCompareLogic = 'LIKE'     AND [j].[JobName] LIKE @JobName)
																					OR (@JobNameCompareLogic = 'NOT LIKE' AND [j].[JobName] NOT LIKE @JobName)
																					OR (@JobNameCompareLogic = 'IN'       AND [j].[JobName] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobName, '''', ''''''), ',', '''')))
																					OR (@JobNameCompareLogic = 'NOT IN'   AND [j].[JobName] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobName, '''', ''''''), ',', ''''))) )))
							AND ((@ExecFile IS NULL) OR ( @ExecFile IS NOT NULL AND ((@ExecFileCompareLogic = '='        AND [j].[ExecFile] = @ExecFile)
																					OR (@ExecFileCompareLogic = '<>'       AND [j].[ExecFile] <> @ExecFile)
																					OR (@ExecFileCompareLogic = 'LIKE'     AND [j].[ExecFile] LIKE @ExecFile)
																					OR (@ExecFileCompareLogic = 'NOT LIKE' AND [j].[ExecFile] NOT LIKE @ExecFile)
																					OR (@ExecFileCompareLogic = 'IN'       AND [j].[ExecFile] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ExecFile, '''', ''''''), ',', '''')))
																					OR (@ExecFileCompareLogic = 'NOT IN'   AND [j].[ExecFile] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ExecFile, '''', ''''''), ',', ''''))) )))
	ORDER BY [j].[SortText]
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode <> 0) BEGIN
		RAISERROR('Error retrieving Job(s). Error code=%d. Grouping logic = AND.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END
ELSE BEGIN  -- 'OR' 

	SELECT [j].[JobId]
				, [j].[CreateDate], [j].[CreateUserId], [usrs].[UserName] AS [CreateUserName], [j].[UpdateDate], [j].[UpdateUserId], [usrs1].[UserName] AS [UpdateUserName]
				, [j].[Active], [j].[SortText]
				, [j].[JobName], [j].[JobFriendlyName], [j].[Description], [j].[ExecPath], [j].[ExecFile], [j].[ParamString]
				, [j].[LogStarts], [j].[LogFinishes]
	FROM [Service].[Jobs] [j] WITH (NOLOCK)
				LEFT OUTER JOIN [Base].[Users] [usrs] WITH (NOLOCK) ON [j].[CreateUserId] = [usrs].[UserId]
				LEFT OUTER JOIN [Base].[Users] [usrs1] WITH (NOLOCK) ON [j].[UpdateUserId] = [usrs1].[UserId]
	WHERE      (@JobId IS NOT NULL AND @JobId = [j].[JobId])
							OR (@CreateDate IS NOT NULL AND @CreateDate = [j].[CreateDate])
							OR (@CreateUserId IS NOT NULL AND @CreateUserId = [j].[CreateUserId])
							OR (@UpdateDate IS NOT NULL AND @UpdateDate = [j].[UpdateDate])
							OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [j].[UpdateUserId])
							OR (@Active IS NOT NULL AND @Active = [j].[Active])
							OR (@JobName IS NOT NULL	AND ( (@JobNameCompareLogic = '='        AND [j].[JobName] = @JobName)
															OR (@JobNameCompareLogic = '<>'       AND [j].[JobName] <> @JobName)
															OR (@JobNameCompareLogic = 'LIKE'     AND [j].[JobName] LIKE @JobName)
															OR (@JobNameCompareLogic = 'NOT LIKE' AND [j].[JobName] NOT LIKE @JobName)
															OR (@JobNameCompareLogic = 'IN'       AND [j].[JobName] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobName, '''', ''''''), ',', '''')))
															OR (@JobNameCompareLogic = 'NOT IN'   AND [j].[JobName] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobName, '''', ''''''), ',', '''')) )))
							OR (@ExecFile IS NOT NULL	AND ( (@ExecFileCompareLogic = '='        AND [j].[ExecFile] = @ExecFile)
															OR (@ExecFileCompareLogic = '<>'       AND [j].[ExecFile] <> @ExecFile)
															OR (@ExecFileCompareLogic = 'LIKE'     AND [j].[ExecFile] LIKE @ExecFile)
															OR (@ExecFileCompareLogic = 'NOT LIKE' AND [j].[ExecFile] NOT LIKE @ExecFile)
															OR (@ExecFileCompareLogic = 'IN'       AND [j].[ExecFile] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ExecFile, '''', ''''''), ',', '''')))
															OR (@ExecFileCompareLogic = 'NOT IN'   AND [j].[ExecFile] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@ExecFile, '''', ''''''), ',', '''')) )))
	ORDER BY [j].[SortText]
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode <> 0) BEGIN
		RAISERROR('Error retrieving Job(s). Error code=%d. Grouping logic = OR.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END

RETURN 0

HANDLE_ERROR:
RETURN -1

