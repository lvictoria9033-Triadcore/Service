IF (Base.ProcedureExists('Service','GetJobs')=1)
	DROP PROCEDURE [Service].[GetJobs]

GO

/*----------------------------------------------------------------------------------------------------------------------------
Returns results based on the criteria specified in the parameters.
The calling program is required to embed the proper single quotes into the paramenters.
Note: Specifying @GroupingLogic='OR' requires that at least one of the input arguments is not 'null'.
Create Date: 2026.07.28
Created By : Triadcore (ACB)
Special Note: Created by ACB but manually modified to include [FullPath]. Do not overwrite with subsequent re-run of ACB.
----------------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[GetJobs]
(
	@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,@JobId INT
	,@UpdateUserId INT
	,@CreateUserId INT
	,@Active BIT
	,@JobNameCompareLogic VARCHAR(10)
	,@JobName VARCHAR(50)
	,@LogFinishesCompareLogic VARCHAR(10)
	,@LogFinishes BIT
)

AS

SET NOCOUNT ON

DECLARE @ErrorCode INT = -1
DECLARE @BasePathNameValueName VARCHAR(100) = 'JobsProcessRunnerPath'
DECLARE @BasePathNameValueGroupName VARCHAR(100) = 'Jobs'
DECLARE @BasePath VARCHAR(500) = ''

IF ( @GroupingLogic IS NULL ) BEGIN
	SET @GroupingLogic = 'AND'
END
ELSE BEGIN
	IF ( @GroupingLogic NOT IN ('AND','OR') ) BEGIN
		RAISERROR('The grouping logic ''%s'' is invalid',11,1,@GroupingLogic)
		GOTO HANDLE_ERROR
	END
END

IF (@BasePathNameValueName IS NOT NULL AND LTRIM(RTRIM(@BasePathNameValueName))<>'') BEGIN
	SELECT @BasePath=[Value] FROM [Base].[NameValues] WITH (NOLOCK) WHERE [NameGroup]=@BasePathNameValueGroupName AND [Name]=@BasePathNameValueName
END
SET @BasePath = LTRIM(RTRIM(@BasePath))


----------------------------------------------------------------------------------------------------------------------------------
-- Return result set.
----------------------------------------------------------------------------------------------------------------------------------
IF (@GroupingLogic = 'AND') BEGIN  

	SELECT [j].[JobId]
			, [j].[RecordComment], [j].[UpdateDate], [j].[UpdateUserId], [usrs].[UserName] AS [UpdateUserName], [j].[CreateDate], [j].[CreateUserId], [usrs1].[UserName] AS [CreateUserName], [j].[Active]
							, [j].[SortText], [j].[JobName], [j].[JobFriendlyName], [j].[Description]
							, [j].[ExecPath], [j].[ExecFile], REPLACE([j].[ExecPath], '{BasePath}', @BasePath) + '\' + [j].[ExecFile] AS [FullPath]
							, [j].[ParamString], [j].[LogStarts]
							, [j].[LogFinishes]
	FROM [Service].[Jobs] [j] WITH (NOLOCK)
				LEFT OUTER JOIN [Base].[Users] [usrs] WITH (NOLOCK) ON [j].[UpdateUserId]=[usrs].[UserId]
								LEFT OUTER JOIN [Base].[Users] [usrs1] WITH (NOLOCK) ON [j].[CreateUserId]=[usrs1].[UserId]
	WHERE       ((@JobId IS NULL) OR (@JobId IS NOT NULL AND @JobId = [j].[JobId]) )
							AND ((@UpdateUserId IS NULL) OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [j].[UpdateUserId]) )
							AND ((@CreateUserId IS NULL) OR (@CreateUserId IS NOT NULL AND @CreateUserId = [j].[CreateUserId]) )
							AND ((@Active IS NULL) OR (@Active IS NOT NULL AND @Active = [j].[Active]) )
							AND ((@JobName IS NULL) OR ( @JobName IS NOT NULL AND ((@JobNameCompareLogic = '='        AND [j].[JobName] = @JobName)
																					OR (@JobNameCompareLogic = '<>'       AND [j].[JobName] <> @JobName)
																					OR (@JobNameCompareLogic = 'LIKE'     AND [j].[JobName] LIKE @JobName)
																					OR (@JobNameCompareLogic = 'NOT LIKE' AND [j].[JobName] NOT LIKE @JobName)
																					OR (@JobNameCompareLogic = 'IN'       AND [j].[JobName] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobName, '''', ''''''), ',', '''')))
																					OR (@JobNameCompareLogic = 'NOT IN'   AND [j].[JobName] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobName, '''', ''''''), ',', ''''))) )))
							AND ((@LogFinishes IS NULL) OR ( @LogFinishes IS NOT NULL AND ((@LogFinishesCompareLogic = '='        AND [j].[LogFinishes] =  @LogFinishes)
																					OR (@LogFinishesCompareLogic = '<>' AND [j].[LogFinishes] <> @LogFinishes) )))
	ORDER BY [j].[SortText]
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error retrieving Job(s). Error code=%d. Grouping logic = AND.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END
ELSE BEGIN  -- 'OR' 

	SELECT [j].[JobId]
			, [j].[RecordComment], [j].[UpdateDate], [j].[UpdateUserId], [usrs].[UserName] AS [UpdateUserName], [j].[CreateDate], [j].[CreateUserId], [usrs1].[UserName] AS [CreateUserName], [j].[Active]
							, [j].[SortText], [j].[JobName], [j].[JobFriendlyName], [j].[Description]
							, [j].[ExecPath], [j].[ExecFile], REPLACE([j].[ExecPath], '{BasePath}', @BasePath) + '\' + [j].[ExecFile] AS [FullPath]
							, [j].[ParamString], [j].[LogStarts]
							, [j].[LogFinishes]
	FROM [Service].[Jobs] [j] WITH (NOLOCK)
				LEFT OUTER JOIN [Base].[Users] [usrs] WITH (NOLOCK) ON [j].[UpdateUserId]=[usrs].[UserId]
								LEFT OUTER JOIN [Base].[Users] [usrs1] WITH (NOLOCK) ON [j].[CreateUserId]=[usrs1].[UserId]
	WHERE      (@JobId IS NOT NULL AND @JobId = [j].[JobId])
							OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [j].[UpdateUserId])
							OR (@CreateUserId IS NOT NULL AND @CreateUserId = [j].[CreateUserId])
							OR (@Active IS NOT NULL AND @Active = [j].[Active])
							OR (@JobName IS NOT NULL	AND ( (@JobNameCompareLogic = '='        AND [j].[JobName] = @JobName)
															OR (@JobNameCompareLogic = '<>'       AND [j].[JobName] <> @JobName)
															OR (@JobNameCompareLogic = 'LIKE'     AND [j].[JobName] LIKE @JobName)
															OR (@JobNameCompareLogic = 'NOT LIKE' AND [j].[JobName] NOT LIKE @JobName)
															OR (@JobNameCompareLogic = 'IN'       AND [j].[JobName] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobName, '''', ''''''), ',', '''')))
															OR (@JobNameCompareLogic = 'NOT IN'   AND [j].[JobName] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobName, '''', ''''''), ',', '''')) )))
							OR (@LogFinishes IS NOT NULL	AND ( (@LogFinishesCompareLogic = '='        AND [j].[LogFinishes] = @LogFinishes)
															OR (@LogFinishesCompareLogic = '<>'       AND [j].[LogFinishes] <> @LogFinishes) ))
	ORDER BY [j].[SortText]
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error retrieving Job(s). Error code=%d. Grouping logic = OR.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END

RETURN 0

HANDLE_ERROR:
RETURN -1

