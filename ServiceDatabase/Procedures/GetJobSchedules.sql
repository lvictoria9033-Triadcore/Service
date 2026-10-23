IF (Base.ProcedureExists('Service','GetJobSchedules') = 1)
	DROP PROCEDURE [Service].[GetJobSchedules]

GO

/*---------------------------------------------------------------------------------------------------------------------
Returns results based on the criteria specified in the parameters.
The calling program is required to embed the proper single quotes into the parameters.
Note: Specifying @GroupingLogic='OR' requires that at least one of the input arguments is not 'null'.
Create Date: 2026.10.23
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[GetJobSchedules]
(
	@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,@JobScheduleId INT
	,@CreateDate DATETIME
	,@CreateUserId INT -- Fkey
	,@UpdateDate DATETIME
	,@UpdateUserId INT -- Fkey
	,@Active BIT
	,@JobScheduleNameCompareLogic VARCHAR(10)
	,@JobScheduleName VARCHAR(100)
	,@JobId INT -- Fkey
	,@JobScheduleTypeId INT -- Fkey
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

IF (@JobScheduleName IS NOT NULL AND @JobScheduleNameCompareLogic IS NULL) BEGIN
	SET @JobScheduleNameCompareLogic = '='
END




----------------------------------------------------------------------------------------------------------------------------------
-- Return result set.
----------------------------------------------------------------------------------------------------------------------------------
IF (@GroupingLogic = 'AND') BEGIN  

	SELECT [js].[JobScheduleId]
				, [js].[CreateDate], [js].[CreateUserId], [usrs].[UserName] AS [CreateUserName], [js].[UpdateDate], [js].[UpdateUserId], [usrs1].[UserName] AS [UpdateUserName]
				, [js].[Active]
				, [js].[JobScheduleName], [js].[Description], [js].[JobId], [jbs].[JobName] AS [JobName], [js].[JobScheduleTypeId], [jbschdltyps].[JobScheduleTypeName] AS [JobScheduleTypeName]
				, [js].[BaseDateTime], [js].[NextStart], [js].[Interval], [js].[Date], [js].[Month], [js].[Day]
				, [js].[Time], [js].[IsRecurring], [js].[RunAsUser], [js].[RunAsPassword]
	FROM [Service].[JobSchedules] [js] WITH (NOLOCK)
				LEFT OUTER JOIN [Base].[Users] [usrs] WITH (NOLOCK) ON [js].[CreateUserId] = [usrs].[UserId]
				LEFT OUTER JOIN [Base].[Users] [usrs1] WITH (NOLOCK) ON [js].[UpdateUserId] = [usrs1].[UserId]
				LEFT OUTER JOIN [Service].[Jobs] [jbs] WITH (NOLOCK) ON [js].[JobId] = [jbs].[JobId]
				LEFT OUTER JOIN [Service].[JobScheduleTypes] [jbschdltyps] WITH (NOLOCK) ON [js].[JobScheduleTypeId] = [jbschdltyps].[JobScheduleTypeId]
	WHERE       ((@JobScheduleId IS NULL) OR (@JobScheduleId IS NOT NULL AND @JobScheduleId = [js].[JobScheduleId]) )
							 AND ((@CreateDate IS NULL) OR (@CreateDate IS NOT NULL AND @CreateDate = [js].[CreateDate]) )
							AND ((@CreateUserId IS NULL) OR (@CreateUserId IS NOT NULL AND @CreateUserId = [js].[CreateUserId]) )
							 AND ((@UpdateDate IS NULL) OR (@UpdateDate IS NOT NULL AND @UpdateDate = [js].[UpdateDate]) )
							AND ((@UpdateUserId IS NULL) OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [js].[UpdateUserId]) )
							AND ((@Active IS NULL) OR (@Active IS NOT NULL AND @Active = [js].[Active]) )
							AND ((@JobScheduleName IS NULL) OR ( @JobScheduleName IS NOT NULL AND ((@JobScheduleNameCompareLogic = '='        AND [js].[JobScheduleName] = @JobScheduleName)
																					OR (@JobScheduleNameCompareLogic = '<>'       AND [js].[JobScheduleName] <> @JobScheduleName)
																					OR (@JobScheduleNameCompareLogic = 'LIKE'     AND [js].[JobScheduleName] LIKE @JobScheduleName)
																					OR (@JobScheduleNameCompareLogic = 'NOT LIKE' AND [js].[JobScheduleName] NOT LIKE @JobScheduleName)
																					OR (@JobScheduleNameCompareLogic = 'IN'       AND [js].[JobScheduleName] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleName, '''', ''''''), ',', '''')))
																					OR (@JobScheduleNameCompareLogic = 'NOT IN'   AND [js].[JobScheduleName] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleName, '''', ''''''), ',', ''''))) )))
							AND ((@JobId IS NULL) OR (@JobId IS NOT NULL AND @JobId = [js].[JobId]) )
							AND ((@JobScheduleTypeId IS NULL) OR (@JobScheduleTypeId IS NOT NULL AND @JobScheduleTypeId = [js].[JobScheduleTypeId]) )
	ORDER BY [js].[JobScheduleName]
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode <> 0) BEGIN
		RAISERROR('Error retrieving JobSchedule(s). Error code=%d. Grouping logic = AND.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END
ELSE BEGIN  -- 'OR' 

	SELECT [js].[JobScheduleId]
				, [js].[CreateDate], [js].[CreateUserId], [usrs].[UserName] AS [CreateUserName], [js].[UpdateDate], [js].[UpdateUserId], [usrs1].[UserName] AS [UpdateUserName]
				, [js].[Active]
				, [js].[JobScheduleName], [js].[Description], [js].[JobId], [jbs].[JobName] AS [JobName], [js].[JobScheduleTypeId], [jbschdltyps].[JobScheduleTypeName] AS [JobScheduleTypeName]
				, [js].[BaseDateTime], [js].[NextStart], [js].[Interval], [js].[Date], [js].[Month], [js].[Day]
				, [js].[Time], [js].[IsRecurring], [js].[RunAsUser], [js].[RunAsPassword]
	FROM [Service].[JobSchedules] [js] WITH (NOLOCK)
				LEFT OUTER JOIN [Base].[Users] [usrs] WITH (NOLOCK) ON [js].[CreateUserId] = [usrs].[UserId]
				LEFT OUTER JOIN [Base].[Users] [usrs1] WITH (NOLOCK) ON [js].[UpdateUserId] = [usrs1].[UserId]
				LEFT OUTER JOIN [Service].[Jobs] [jbs] WITH (NOLOCK) ON [js].[JobId] = [jbs].[JobId]
				LEFT OUTER JOIN [Service].[JobScheduleTypes] [jbschdltyps] WITH (NOLOCK) ON [js].[JobScheduleTypeId] = [jbschdltyps].[JobScheduleTypeId]
	WHERE      (@JobScheduleId IS NOT NULL AND @JobScheduleId = [js].[JobScheduleId])
							OR (@CreateDate IS NOT NULL AND @CreateDate = [js].[CreateDate])
							OR (@CreateUserId IS NOT NULL AND @CreateUserId = [js].[CreateUserId])
							OR (@UpdateDate IS NOT NULL AND @UpdateDate = [js].[UpdateDate])
							OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [js].[UpdateUserId])
							OR (@Active IS NOT NULL AND @Active = [js].[Active])
							OR (@JobScheduleName IS NOT NULL	AND ( (@JobScheduleNameCompareLogic = '='        AND [js].[JobScheduleName] = @JobScheduleName)
															OR (@JobScheduleNameCompareLogic = '<>'       AND [js].[JobScheduleName] <> @JobScheduleName)
															OR (@JobScheduleNameCompareLogic = 'LIKE'     AND [js].[JobScheduleName] LIKE @JobScheduleName)
															OR (@JobScheduleNameCompareLogic = 'NOT LIKE' AND [js].[JobScheduleName] NOT LIKE @JobScheduleName)
															OR (@JobScheduleNameCompareLogic = 'IN'       AND [js].[JobScheduleName] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleName, '''', ''''''), ',', '''')))
															OR (@JobScheduleNameCompareLogic = 'NOT IN'   AND [js].[JobScheduleName] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleName, '''', ''''''), ',', '''')) )))
							OR (@JobId IS NOT NULL AND @JobId = [js].[JobId])
							OR (@JobScheduleTypeId IS NOT NULL AND @JobScheduleTypeId = [js].[JobScheduleTypeId])
	ORDER BY [js].[JobScheduleName]
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode <> 0) BEGIN
		RAISERROR('Error retrieving JobSchedule(s). Error code=%d. Grouping logic = OR.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END

RETURN 0

HANDLE_ERROR:
RETURN -1

