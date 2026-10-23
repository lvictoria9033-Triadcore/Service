------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Builds an application with an initial sys admin user for JobScheduleHistory.
-- Create Date: 2026.10.23
-- Created By : Triadcore (ACB)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @AppName VARCHAR(100) = 'JobScheduleHistoryApi'
DECLARE @AppVersion VARCHAR(25) = '2019'
DECLARE @AppType VARCHAR(100) = 'WebApi'
DECLARE @ParentAppId INT = NULL
DECLARE @Desc VARCHAR(2000) = 'The web API for managing JobScheduleHistory{} data.'
DECLARE @BaseName VARCHAR(200) = 'JobScheduleHistory'
DECLARE @DispName VARCHAR(200) = 'Job Schedule Histories'
DECLARE @SortText VARCHAR(100) = '095-Service-JobScheduleHistoryApi'
DECLARE @AdminUser VARCHAR(100) = 'lvictoria'
DECLARE @UpdateUser VARCHAR(100) = 'default'


-- Get parent app ------------------------------------------
SELECT @ParentAppId = [ApplicationId]
FROM [App].[Applications] WITH (NOLOCK)
WHERE [ApplicationName] LIKE 'AdminService'
ORDER BY [ApplicationName]


-- Run app builder ------------------------------------------------------
EXEC [App].[BuildApplication]
      @AppName			-- @ApplicationName VARCHAR(100)
     ,NULL				-- @ApplicationId INT
     ,@AppVersion		-- @ApplicationVersion VARCHAR(25)
	 ,@Desc				-- @Description VARCHAR(2000)
	 ,@BaseName         -- @BaseName VARCHAR(200)
	 ,@DispName			-- @DisplayName VARCHAR(200)
     ,@AppType			-- @ApplicationTypeName VARCHAR(100)
     ,NULL				-- @ApplicationTypeId INT
	 ,@SortText			-- @SortText VARCHAR(200)
	 ,NULL				-- @SortPrefix VARCHAR(100)  (used to create [@SortPrefix]-JobScheduleHistory[@ApplicationName])
     ,NULL				-- @ParentApplicationName VARCHAR(100)
	 ,@ParentAppId		-- @ParentApplicationId INT
     ,@AdminUser		-- @SysAdminUserName VARCHAR(100)
     ,NULL				-- @SysAdminPassword VARCHAR(MAX)
     ,NULL				-- @SysAdminUserId INT
     ,@UpdateUser		-- @UpdateUserName VARCHAR(100)
     ,null				-- @UpdateUserId INT
	 ,1					-- @DisplayResults BIT


---------------------------------------------------------------------------
EXEC [App].[GetApplicationUserRoles]
	 null		--@GroupingLogic
	,null		--@ApplicationUserRoleId INT
	,null		--@CreateUserId INT
	,null		--@UpdateUserId INT
	,null		--@Active BIT
	,null		--@AppRoleId  -- [add param @ApplicationRoleId as a search criteria]
	,null		--@ActiveAppRole BIT
	,null		--@ApplicationId INT
	,null		--@ApplicationNameCompareLogic VARCHAR(10)
	,'JobScheduleHistoryApi'  --@ApplicationName VARCHAR(100)
	,null		--@ActiveApp BIT
	,null		--@UserId INT
	,null		--@UserNameCompareLogic VARCHAR(10)
	,@AdminUser --@UserName VARCHAR(100)
	,null		--@ActiveUser BIT
	,null		--@RoleId INT
	,null		--@RoleNameCompareLogic VARCHAR(10)
	,null		--@RoleName VARCHAR(100)
	,null		--@ActiveRole INT


---------------------------------------------------------------------------
SELECT *
FROM [App].[Applications] WITH (NOLOCK)
ORDER BY [ApplicationId] DESC
