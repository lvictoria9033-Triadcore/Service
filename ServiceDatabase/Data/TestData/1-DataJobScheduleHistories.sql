--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- JobScheduleHistory test data insert
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- DELETE FROM [Service].[JobScheduleHistorys]; DBCC CHECKIDENT ('[Service].[JobScheduleHistorys]', RESEED, 0);

DECLARE @UpdateUserId INT = 1
DECLARE @UpdateUserName VARCHAR(MAX) = NULL -- AlternateToDataUid UpdateUserId
DECLARE @JobScheduleId INT = 1
DECLARE @ExecuteDateTimeStartCompareLogic VARCHAR(10) = NULL
DECLARE @ExecuteDateTimeStart DATETIME = GETDATE()
DECLARE @ExecuteDateTimeEndCompareLogic VARCHAR(10) = NULL
DECLARE @ExecuteDateTimeEnd DATETIME = GETDATE()
DECLARE @ExecuteUserNameCompareLogic VARCHAR(10) = NULL
DECLARE @ExecuteUserName VARCHAR(100) = ''
DECLARE @ExecuteParams VARCHAR(1000) = ''
DECLARE @ResultCode INT = 1
DECLARE @ResultTextCompareLogic VARCHAR(10) = NULL
DECLARE @ResultText VARCHAR(1000) = ''
DECLARE @Note VARCHAR(2000) = ''
DECLARE @UpdateUserId INT = 3


-------  1  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 5
SET @UpdateUserName = NULL -- Fkey alias to UpdateUserId
SET @JobScheduleId = 7
SET @ExecuteDateTimeStart = DATEADD(DAY, 117, GETDATE())
SET @ExecuteDateTimeEnd = DATEADD(DAY, 64, GETDATE())
SET @ExecuteUserName = ''
SET @ExecuteParams = ''
SET @ResultCode = 103
SET @ResultText = 'ResultText-157'
SET @Note = ''
	EXEC [Service].[UpdateJobScheduleHistory]
		  NULL --@JobScheduleHistoryId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @UpdateUserName -- @UpdateUserName (Fkey alt alias to UpdateUserId)
		, @JobScheduleId -- @JobScheduleId INT
		, @ExecuteDateTimeStart -- @ExecuteDateTimeStart DATETIME
		, @ExecuteDateTimeEnd -- @ExecuteDateTimeEnd DATETIME
		, @ExecuteUserName -- @ExecuteUserName VARCHAR(100)
		, @ExecuteParams -- @ExecuteParams VARCHAR(1000)
		, @ResultCode -- @ResultCode INT
		, @ResultText -- @ResultText VARCHAR(1000)
		, @Note -- @Note VARCHAR(2000)
		, @UpdateUserId -- @UpdateUserId INT


-------  2  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 5
SET @UpdateUserName = NULL -- Fkey alias to UpdateUserId
SET @JobScheduleId = 7
SET @ExecuteDateTimeStart = DATEADD(DAY, 117, GETDATE())
SET @ExecuteDateTimeEnd = DATEADD(DAY, 64, GETDATE())
SET @ExecuteUserName = ''
SET @ExecuteParams = ''
SET @ResultCode = NULL
SET @ResultText = NULL
SET @Note = NULL
	EXEC [Service].[UpdateJobScheduleHistory]
		  NULL --@JobScheduleHistoryId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @UpdateUserName -- @UpdateUserName (Fkey alt alias to UpdateUserId)
		, @JobScheduleId -- @JobScheduleId INT
		, @ExecuteDateTimeStart -- @ExecuteDateTimeStart DATETIME
		, @ExecuteDateTimeEnd -- @ExecuteDateTimeEnd DATETIME
		, @ExecuteUserName -- @ExecuteUserName VARCHAR(100)
		, @ExecuteParams -- @ExecuteParams VARCHAR(1000)
		, @ResultCode -- @ResultCode INT
		, @ResultText -- @ResultText VARCHAR(1000)
		, @Note -- @Note VARCHAR(2000)
		, @UpdateUserId -- @UpdateUserId INT


-------  3  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 5
SET @UpdateUserName = NULL -- Fkey alias to UpdateUserId
SET @JobScheduleId = 7
SET @ExecuteDateTimeStart = DATEADD(DAY, 117, GETDATE())
SET @ExecuteDateTimeEnd = DATEADD(DAY, 64, GETDATE())
SET @ExecuteUserName = ''
SET @ExecuteParams = ''
SET @ResultCode = NULL
SET @ResultText = NULL
SET @Note = NULL
	EXEC [Service].[UpdateJobScheduleHistory]
		  NULL --@JobScheduleHistoryId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @UpdateUserName -- @UpdateUserName (Fkey alt alias to UpdateUserId)
		, @JobScheduleId -- @JobScheduleId INT
		, @ExecuteDateTimeStart -- @ExecuteDateTimeStart DATETIME
		, @ExecuteDateTimeEnd -- @ExecuteDateTimeEnd DATETIME
		, @ExecuteUserName -- @ExecuteUserName VARCHAR(100)
		, @ExecuteParams -- @ExecuteParams VARCHAR(1000)
		, @ResultCode -- @ResultCode INT
		, @ResultText -- @ResultText VARCHAR(1000)
		, @Note -- @Note VARCHAR(2000)
		, @UpdateUserId -- @UpdateUserId INT


-------  4  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 5
SET @UpdateUserName = NULL -- Fkey alias to UpdateUserId
SET @JobScheduleId = 7
SET @ExecuteDateTimeStart = DATEADD(DAY, 117, GETDATE())
SET @ExecuteDateTimeEnd = DATEADD(DAY, 64, GETDATE())
SET @ExecuteUserName = ''
SET @ExecuteParams = ''
SET @ResultCode = NULL
SET @ResultText = NULL
SET @Note = NULL
	EXEC [Service].[UpdateJobScheduleHistory]
		  NULL --@JobScheduleHistoryId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @UpdateUserName -- @UpdateUserName (Fkey alt alias to UpdateUserId)
		, @JobScheduleId -- @JobScheduleId INT
		, @ExecuteDateTimeStart -- @ExecuteDateTimeStart DATETIME
		, @ExecuteDateTimeEnd -- @ExecuteDateTimeEnd DATETIME
		, @ExecuteUserName -- @ExecuteUserName VARCHAR(100)
		, @ExecuteParams -- @ExecuteParams VARCHAR(1000)
		, @ResultCode -- @ResultCode INT
		, @ResultText -- @ResultText VARCHAR(1000)
		, @Note -- @Note VARCHAR(2000)
		, @UpdateUserId -- @UpdateUserId INT


-------  5  ---------------------------------------------------------------------------------------------------------
SET @UpdateUserId = 5
SET @UpdateUserName = NULL -- Fkey alias to UpdateUserId
SET @JobScheduleId = 7
SET @ExecuteDateTimeStart = DATEADD(DAY, 117, GETDATE())
SET @ExecuteDateTimeEnd = DATEADD(DAY, 64, GETDATE())
SET @ExecuteUserName = ''
SET @ExecuteParams = ''
SET @ResultCode = NULL
SET @ResultText = NULL
SET @Note = NULL
	EXEC [Service].[UpdateJobScheduleHistory]
		  NULL --@JobScheduleHistoryId INT
		, @UpdateUserId -- @UpdateUserId INT
		, @UpdateUserName -- @UpdateUserName (Fkey alt alias to UpdateUserId)
		, @JobScheduleId -- @JobScheduleId INT
		, @ExecuteDateTimeStart -- @ExecuteDateTimeStart DATETIME
		, @ExecuteDateTimeEnd -- @ExecuteDateTimeEnd DATETIME
		, @ExecuteUserName -- @ExecuteUserName VARCHAR(100)
		, @ExecuteParams -- @ExecuteParams VARCHAR(1000)
		, @ResultCode -- @ResultCode INT
		, @ResultText -- @ResultText VARCHAR(1000)
		, @Note -- @Note VARCHAR(2000)
		, @UpdateUserId -- @UpdateUserId INT


------------------------------------------------------------------------------------------------------------------------------------------------
SELECT * FROM [Service].[JobScheduleHistories] ORDER BY [JobScheduleHistoryId] DESC
