IF (Base.ProcedureExists('Service','GetJobScheduleTypes')=1)
	DROP PROCEDURE [Service].[GetJobScheduleTypes]

GO

/*---------------------------------------------------------------------------------------------------------------------
Returns results based on the criteria specified in the parameters.
The calling program is required to embed the proper single quotes into the paramenters.
Note: Specifying @GroupingLogic='OR' requires that at least one of the input arguments is not 'null'.
Create Date: 2023.07.01
Created By : Triadcore (ACB)
---------------------------------------------------------------------------------------------------------------------*/
CREATE PROCEDURE [Service].[GetJobScheduleTypes]
(
	@GroupingLogic VARCHAR(3) -- only 'AND' or 'OR'
	,@JobScheduleTypeId INT
	,@CreateUserId INT
	,@UpdateUserId INT
	,@Active BIT
	,@JobScheduleTypeNameCompareLogic VARCHAR(10)
	,@JobScheduleTypeName VARCHAR(100)
	,@DescriptionCompareLogic VARCHAR(10)
	,@Description VARCHAR(1000)
	,@InstanceDescriptionCompareLogic VARCHAR(10)
	,@InstanceDescription VARCHAR(1000)
	,@NoteCompareLogic VARCHAR(10)
	,@Note VARCHAR(1000)
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

	SELECT [jst].[JobScheduleTypeId]
			, [jst].[CreateDate], [jst].[CreateUserId], [usrs].[UserName] AS [CreateUserName], [jst].[UpdateDate], [jst].[UpdateUserId], [usrs1].[UserName] AS [UpdateUserName], [jst].[RecordComment], [jst].[Active]
			, [jst].[JobScheduleTypeName], [jst].[Description], [jst].[InstanceDescription], [jst].[Note]
	FROM [Service].[JobScheduleTypes] jst WITH (NOLOCK)
				LEFT OUTER JOIN [base].[Users] [usrs] WITH (NOLOCK) ON [jst].[CreateUserId]=[usrs].[UserId]
				LEFT OUTER JOIN [base].[Users] [usrs1] WITH (NOLOCK) ON [jst].[UpdateUserId]=[usrs1].[UserId]
	WHERE       ((@JobScheduleTypeId IS NULL) OR (@JobScheduleTypeId IS NOT NULL AND @JobScheduleTypeId = [jst].[JobScheduleTypeId]) )
	        AND ((@CreateUserId IS NULL) OR (@CreateUserId IS NOT NULL AND @CreateUserId = [jst].[CreateUserId]) )
			AND ((@UpdateUserId IS NULL) OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [jst].[UpdateUserId]) )
			AND ((@Active IS NULL) OR (@Active IS NOT NULL AND @Active = [jst].[Active]) )
			AND ((@JobScheduleTypeName IS NULL) OR ( @JobScheduleTypeName IS NOT NULL AND ((@JobScheduleTypeNameCompareLogic = '='        AND [jst].[JobScheduleTypeName] =  @JobScheduleTypeName)
																	OR (@JobScheduleTypeNameCompareLogic = '<>'       AND [jst].[JobScheduleTypeName] <> @JobScheduleTypeName)
																	OR (@JobScheduleTypeNameCompareLogic = 'LIKE'     AND [jst].[JobScheduleTypeName] LIKE @JobScheduleTypeName)
																	OR (@JobScheduleTypeNameCompareLogic = 'NOT LIKE' AND [jst].[JobScheduleTypeName] NOT LIKE @JobScheduleTypeName)
																	OR (@JobScheduleTypeNameCompareLogic = 'IN'       AND [jst].[JobScheduleTypeName] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleTypeName, '''', ''''''), ',', '''')))
																	OR (@JobScheduleTypeNameCompareLogic = 'NOT IN'   AND [jst].[JobScheduleTypeName] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleTypeName, '''', ''''''), ',', ''''))) )))
			AND ((@Description IS NULL) OR ( @Description IS NOT NULL AND ((@DescriptionCompareLogic = '='        AND [jst].[Description] =  @Description)
																	OR (@DescriptionCompareLogic = '<>'       AND [jst].[Description] <> @Description)
																	OR (@DescriptionCompareLogic = 'LIKE'     AND [jst].[Description] LIKE @Description)
																	OR (@DescriptionCompareLogic = 'NOT LIKE' AND [jst].[Description] NOT LIKE @Description)
																	OR (@DescriptionCompareLogic = 'IN'       AND [jst].[Description] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@Description, '''', ''''''), ',', '''')))
																	OR (@DescriptionCompareLogic = 'NOT IN'   AND [jst].[Description] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@Description, '''', ''''''), ',', ''''))) )))
			AND ((@InstanceDescription IS NULL) OR ( @InstanceDescription IS NOT NULL AND ((@InstanceDescriptionCompareLogic = '='        AND [jst].[InstanceDescription] =  @InstanceDescription)
																	OR (@InstanceDescriptionCompareLogic = '<>'       AND [jst].[InstanceDescription] <> @InstanceDescription)
																	OR (@InstanceDescriptionCompareLogic = 'LIKE'     AND [jst].[InstanceDescription] LIKE @InstanceDescription)
																	OR (@InstanceDescriptionCompareLogic = 'NOT LIKE' AND [jst].[InstanceDescription] NOT LIKE @InstanceDescription)
																	OR (@InstanceDescriptionCompareLogic = 'IN'       AND [jst].[InstanceDescription] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@InstanceDescription, '''', ''''''), ',', '''')))
																	OR (@InstanceDescriptionCompareLogic = 'NOT IN'   AND [jst].[InstanceDescription] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@InstanceDescription, '''', ''''''), ',', ''''))) )))
			AND ((@Note IS NULL) OR ( @Note IS NOT NULL AND ((@NoteCompareLogic = '='        AND [jst].[Note] =  @Note)
																	OR (@NoteCompareLogic = '<>'       AND [jst].[Note] <> @Note)
																	OR (@NoteCompareLogic = 'LIKE'     AND [jst].[Note] LIKE @Note)
																	OR (@NoteCompareLogic = 'NOT LIKE' AND [jst].[Note] NOT LIKE @Note)
																	OR (@NoteCompareLogic = 'IN'       AND [jst].[Note] IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@Note, '''', ''''''), ',', '''')))
																	OR (@NoteCompareLogic = 'NOT IN'   AND [jst].[Note] NOT IN (SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@Note, '''', ''''''), ',', ''''))) )))
	
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error retrieving JobScheduleType(s). Error code=%d. Grouping logic = AND.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END
ELSE BEGIN  -- 'OR' 

	SELECT [jst].[JobScheduleTypeId]
			, [jst].[CreateDate], [jst].[CreateUserId], [usrs].[UserName] AS [CreateUserName], [jst].[UpdateDate], [jst].[UpdateUserId], [usrs1].[UserName] AS [UpdateUserName], [jst].[RecordComment], [jst].[Active]
			, [jst].[JobScheduleTypeName], [jst].[Description], [jst].[InstanceDescription], [jst].[Note]
	FROM [Service].[JobScheduleTypes] jst WITH (NOLOCK)
				LEFT OUTER JOIN [base].[Users] [usrs] WITH (NOLOCK) ON [jst].[CreateUserId]=[usrs].[UserId]
				LEFT OUTER JOIN [base].[Users] [usrs1] WITH (NOLOCK) ON [jst].[UpdateUserId]=[usrs1].[UserId]
	WHERE      (@JobScheduleTypeId IS NOT NULL AND @JobScheduleTypeId = [jst].[JobScheduleTypeId])
	        OR (@CreateUserId IS NOT NULL AND @CreateUserId = [jst].[CreateUserId])
			OR (@UpdateUserId IS NOT NULL AND @UpdateUserId = [jst].[UpdateUserId])
			OR (@Active IS NOT NULL AND @Active = [jst].[Active])
			OR (@JobScheduleTypeName IS NOT NULL	AND ( (@JobScheduleTypeNameCompareLogic = '='        AND [jst].[JobScheduleTypeName] = @JobScheduleTypeName)
											OR (@JobScheduleTypeNameCompareLogic = '<>'       AND [jst].[JobScheduleTypeName] <> @JobScheduleTypeName)
											OR (@JobScheduleTypeNameCompareLogic = 'LIKE'     AND [jst].[JobScheduleTypeName] LIKE @JobScheduleTypeName)
											OR (@JobScheduleTypeNameCompareLogic = 'NOT LIKE' AND [jst].[JobScheduleTypeName] NOT LIKE @JobScheduleTypeName)
											OR (@JobScheduleTypeNameCompareLogic = 'IN'       AND [jst].[JobScheduleTypeName] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleTypeName, '''', ''''''), ',', '''')))
											OR (@JobScheduleTypeNameCompareLogic = 'NOT IN'   AND [jst].[JobScheduleTypeName] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@JobScheduleTypeName, '''', ''''''), ',', '''')) )))
			OR (@Description IS NOT NULL	AND ( (@DescriptionCompareLogic = '='        AND [jst].[Description] = @Description)
											OR (@DescriptionCompareLogic = '<>'       AND [jst].[Description] <> @Description)
											OR (@DescriptionCompareLogic = 'LIKE'     AND [jst].[Description] LIKE @Description)
											OR (@DescriptionCompareLogic = 'NOT LIKE' AND [jst].[Description] NOT LIKE @Description)
											OR (@DescriptionCompareLogic = 'IN'       AND [jst].[Description] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@Description, '''', ''''''), ',', '''')))
											OR (@DescriptionCompareLogic = 'NOT IN'   AND [jst].[Description] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@Description, '''', ''''''), ',', '''')) )))
			OR (@InstanceDescription IS NOT NULL	AND ( (@InstanceDescriptionCompareLogic = '='        AND [jst].[InstanceDescription] = @InstanceDescription)
											OR (@InstanceDescriptionCompareLogic = '<>'       AND [jst].[InstanceDescription] <> @InstanceDescription)
											OR (@InstanceDescriptionCompareLogic = 'LIKE'     AND [jst].[InstanceDescription] LIKE @InstanceDescription)
											OR (@InstanceDescriptionCompareLogic = 'NOT LIKE' AND [jst].[InstanceDescription] NOT LIKE @InstanceDescription)
											OR (@InstanceDescriptionCompareLogic = 'IN'       AND [jst].[InstanceDescription] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@InstanceDescription, '''', ''''''), ',', '''')))
											OR (@InstanceDescriptionCompareLogic = 'NOT IN'   AND [jst].[InstanceDescription] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@InstanceDescription, '''', ''''''), ',', '''')) )))
			OR (@Note IS NOT NULL	AND ( (@NoteCompareLogic = '='        AND [jst].[Note] = @Note)
											OR (@NoteCompareLogic = '<>'       AND [jst].[Note] <> @Note)
											OR (@NoteCompareLogic = 'LIKE'     AND [jst].[Note] LIKE @Note)
											OR (@NoteCompareLogic = 'NOT LIKE' AND [jst].[Note] NOT LIKE @Note)
											OR (@NoteCompareLogic = 'IN'       AND [jst].[Note] IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@Note, '''', ''''''), ',', '''')))
											OR (@NoteCompareLogic = 'NOT IN'   AND [jst].[Note] NOT IN(SELECT Val FROM Base.ParseDelimitedTextToTable(REPLACE(@Note, '''', ''''''), ',', '''')) )))
	
	SET @ErrorCode = @@ERROR
	IF (@ErrorCode<>0) BEGIN
		RAISERROR('Error retrieving JobScheduleType(s). Error code=%d. Grouping logic = OR.',18,1,@ErrorCode)
		GOTO HANDLE_ERROR
	END

END

RETURN 0

HANDLE_ERROR:
RETURN -1

