--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Job test data insert
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DELETE FROM [Service].[Jobs]; DBCC CHECKIDENT ('[Service].[Jobs]', RESEED, 0);

DECLARE @UpdateUserId INT = 1
DECLARE @SortText VARCHAR(100) = ''
DECLARE @JobNameCompareLogic VARCHAR(10) = NULL
DECLARE @JobName VARCHAR(50) = ''
DECLARE @JobFriendlyName VARCHAR(100) = ''
DECLARE @Description VARCHAR(200) = ''
DECLARE @ExecPath VARCHAR(2000) = ''
DECLARE @ExecFileCompareLogic VARCHAR(10) = NULL
DECLARE @ExecFile VARCHAR(200) = ''
DECLARE @ParamString VARCHAR(1000) = ''
DECLARE @LogStarts BIT = 1
DECLARE @LogFinishes BIT = 1
DECLARE @UpdateUserId INT = 3


-------  1  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @SortText = '____001-Job'
SET @JobName = 'JobName-83'
SET @JobFriendlyName = ''
SET @Description = ''
SET @ExecPath = 'ExecPath-62'
SET @ExecFile = 'ExecFile-61'
SET @ParamString = ''
SET @LogStarts = 0
SET @LogFinishes = 1
IF (NOT EXISTS(SELECT * FROM [Service].[Jobs] WHERE [JobName]=@JobName)) BEGIN
	EXEC [Service].[UpdateJob]
		  NULL --@JobId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @SortText -- @SortText VARCHAR(100)
		, @JobName -- @JobName VARCHAR(50)
		, @JobFriendlyName -- @JobFriendlyName VARCHAR(100)
		, @Description -- @Description VARCHAR(200)
		, @ExecPath -- @ExecPath VARCHAR(2000)
		, @ExecFile -- @ExecFile VARCHAR(200)
		, @ParamString -- @ParamString VARCHAR(1000)
		, @LogStarts -- @LogStarts BIT
		, @LogFinishes -- @LogFinishes BIT
		, @UpdateUserId -- @UpdateUserId INT
END


-------  2  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @SortText = '____002-Job'
SET @JobName = 'JobName-83'
SET @JobFriendlyName = ''
SET @Description = ''
SET @ExecPath = 'ExecPath-62'
SET @ExecFile = 'ExecFile-61'
SET @ParamString = ''
SET @LogStarts = 0
SET @LogFinishes = 1
IF (NOT EXISTS(SELECT * FROM [Service].[Jobs] WHERE [JobName]=@JobName)) BEGIN
	EXEC [Service].[UpdateJob]
		  NULL --@JobId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @SortText -- @SortText VARCHAR(100)
		, @JobName -- @JobName VARCHAR(50)
		, @JobFriendlyName -- @JobFriendlyName VARCHAR(100)
		, @Description -- @Description VARCHAR(200)
		, @ExecPath -- @ExecPath VARCHAR(2000)
		, @ExecFile -- @ExecFile VARCHAR(200)
		, @ParamString -- @ParamString VARCHAR(1000)
		, @LogStarts -- @LogStarts BIT
		, @LogFinishes -- @LogFinishes BIT
		, @UpdateUserId -- @UpdateUserId INT
END


-------  3  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @SortText = '____003-Job'
SET @JobName = 'JobName-83'
SET @JobFriendlyName = ''
SET @Description = ''
SET @ExecPath = 'ExecPath-62'
SET @ExecFile = 'ExecFile-61'
SET @ParamString = ''
SET @LogStarts = 0
SET @LogFinishes = 1
IF (NOT EXISTS(SELECT * FROM [Service].[Jobs] WHERE [JobName]=@JobName)) BEGIN
	EXEC [Service].[UpdateJob]
		  NULL --@JobId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @SortText -- @SortText VARCHAR(100)
		, @JobName -- @JobName VARCHAR(50)
		, @JobFriendlyName -- @JobFriendlyName VARCHAR(100)
		, @Description -- @Description VARCHAR(200)
		, @ExecPath -- @ExecPath VARCHAR(2000)
		, @ExecFile -- @ExecFile VARCHAR(200)
		, @ParamString -- @ParamString VARCHAR(1000)
		, @LogStarts -- @LogStarts BIT
		, @LogFinishes -- @LogFinishes BIT
		, @UpdateUserId -- @UpdateUserId INT
END


-------  4  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @SortText = '____004-Job'
SET @JobName = 'JobName-83'
SET @JobFriendlyName = ''
SET @Description = ''
SET @ExecPath = 'ExecPath-62'
SET @ExecFile = 'ExecFile-61'
SET @ParamString = ''
SET @LogStarts = 0
SET @LogFinishes = 1
IF (NOT EXISTS(SELECT * FROM [Service].[Jobs] WHERE [JobName]=@JobName)) BEGIN
	EXEC [Service].[UpdateJob]
		  NULL --@JobId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @SortText -- @SortText VARCHAR(100)
		, @JobName -- @JobName VARCHAR(50)
		, @JobFriendlyName -- @JobFriendlyName VARCHAR(100)
		, @Description -- @Description VARCHAR(200)
		, @ExecPath -- @ExecPath VARCHAR(2000)
		, @ExecFile -- @ExecFile VARCHAR(200)
		, @ParamString -- @ParamString VARCHAR(1000)
		, @LogStarts -- @LogStarts BIT
		, @LogFinishes -- @LogFinishes BIT
		, @UpdateUserId -- @UpdateUserId INT
END


-------  5  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 6
SET @SortText = '____005-Job'
SET @JobName = 'JobName-83'
SET @JobFriendlyName = ''
SET @Description = ''
SET @ExecPath = 'ExecPath-62'
SET @ExecFile = 'ExecFile-61'
SET @ParamString = ''
SET @LogStarts = 0
SET @LogFinishes = 1
IF (NOT EXISTS(SELECT * FROM [Service].[Jobs] WHERE [JobName]=@JobName)) BEGIN
	EXEC [Service].[UpdateJob]
		  NULL --@JobId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @SortText -- @SortText VARCHAR(100)
		, @JobName -- @JobName VARCHAR(50)
		, @JobFriendlyName -- @JobFriendlyName VARCHAR(100)
		, @Description -- @Description VARCHAR(200)
		, @ExecPath -- @ExecPath VARCHAR(2000)
		, @ExecFile -- @ExecFile VARCHAR(200)
		, @ParamString -- @ParamString VARCHAR(1000)
		, @LogStarts -- @LogStarts BIT
		, @LogFinishes -- @LogFinishes BIT
		, @UpdateUserId -- @UpdateUserId INT
END


------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM [Service].[Jobs] ORDER BY [JobId] DESC
