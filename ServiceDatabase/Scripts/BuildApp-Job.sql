------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Builds an application with an initial sys admin user for Job.
-- Create Date: 2026.07.28
-- Created By : Triadcore (ACB)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
DECLARE @AppName VARCHAR(100) = 'JobApi'
DECLARE @AppVersion VARCHAR(25) = '2019'
DECLARE @AppType VARCHAR(100) = 'WebApi'
DECLARE @ParentAppId INT = NULL
DECLARE @Desc VARCHAR(2000) = 'The web API for managing Job{} data.'
DECLARE @DispName VARCHAR(200) = 'Jobs'
DECLARE @SortText VARCHAR(100) = '095-Service-JobApi'
DECLARE @AdminUser VARCHAR(100) = 'lvictoria'
DECLARE @UpdateUser VARCHAR(100) = 'default'


-- Get parent app ------------------------------------------
SELECT @ParentAppId=[ApplicationId]
FROM [App].[Applications] WITH (NOLOCK)
WHERE [ApplicationName] LIKE 'AdminService'
ORDER BY [ApplicationName]


-- Run app builder ------------------------------------------------------
EXEC [App].[BuildApplication]
      @AppName			-- @ApplicationName VARCHAR(100)
     ,NULL				-- @ApplicationId INT
     ,@AppVersion		-- @ApplicationVersion VARCHAR(25)
	 ,@Desc				-- @Description VARCHAR(2000)
	 ,@DispName			-- @DisplayName VARCHAR(200)
     ,@AppType			-- @ApplicationTypeName VARCHAR(100)
     ,NULL				-- @ApplicationTypeId INT
	 ,@SortText			-- @SortText VARCHAR(200)
	 ,NULL				-- @SortPrefix VARCHAR(100)  (used to create [@SortPrefix]-Job[@ApplicationName])
     ,NULL				-- @ParentApplicationName VARCHAR(100)
	 ,@ParentAppId		-- @ParentApplicationId INT
     ,@AdminUser		-- @SysAdminUserName VARCHAR(100)
     ,NULL				-- @SysAdminPassword VARCHAR(MAX)
     ,NULL				-- @SysAdminUserId INT
     ,@UpdateUser		-- @UpdateUserName VARCHAR(100)
     ,null				-- @UpdateUserId INT
	 ,1					-- @DisplayResults BIT


---------------------------------------------------------------------------
EXEC App.GetApplicationUserRole
	 null		--@ApplicationUserRoleId INT
	,null		--@ApplicationId INT
	,'JobApi' --@ApplicationName VARCHAR(100)
	,null		--@UserId INT
	,@AdminUser			--@UserName VARCHAR(100)
	,null		--@RoleId INT
	,null		--@RoleName VARCHAR(100)
	,null		--@ApplicationRoleId
	,null		--@Active BIT
	,null		--@UpdateUserId INT
	,null		--@CreateUserId INT


---------------------------------------------------------------------------
SELECT *
FROM [App].[Applications] WITH (NOLOCK)
ORDER BY [ApplicationId] DESC
