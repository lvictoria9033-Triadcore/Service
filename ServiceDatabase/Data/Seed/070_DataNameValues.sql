IF ( Base.TableExists('Base','NameValues')=1 ) BEGIN

	DECLARE @BinId INT
	DECLARE @BitId INT
	DECLARE @CharId INT
	DECLARE @DTId INT
	DECLARE @DecId INT
	DECLARE @IntId INT
	DECLARE @StrId INT

	DECLARE @LoaderUserId INT
	SET @LoaderUserId=-1
	SELECT @LoaderUserId=UserId FROM Base.Users WHERE UserName='SysDataLoader'
	

	BEGIN TRANSACTION TranNameValuesSeed


		SELECT @BinId=DatatypeId FROM Base.DataTypes WHERE DatatypeName='Binary'
		SELECT @BitId=DatatypeId FROM Base.DataTypes WHERE DatatypeName='Bit'
		SELECT @CharId=DatatypeId FROM Base.DataTypes WHERE DatatypeName='Character'
		SELECT @DTId=DatatypeId FROM Base.DataTypes WHERE DatatypeName='DateTime'
		SELECT @DecId=DatatypeId FROM Base.DataTypes WHERE DatatypeName='Decimal'
		SELECT @IntId=DatatypeId FROM Base.DataTypes WHERE DatatypeName='Integer'
		SELECT @StrId=DatatypeId FROM Base.DataTypes WHERE DatatypeName='String'

		------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		IF ((SELECT COUNT(NameValueId) FROM Base.NameValues WHERE [Name]='JobScheduleHistoryPurgeDays')=0) BEGIN
			EXEC Base.UpdateNameValue null, 'JobScheduleHistoryPurgeDays', 'Job Schedule History Purge Day Range', 'System', '14', @IntId, '2019-01-01', null, 'The number of days, back, to purge the database job schedule history log.', null, @LoaderUserId, 'Created on DB auto-build.'
		END

		------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		IF ((SELECT COUNT(NameValueId) FROM Base.NameValues WHERE [Name]='JobBasePath')=0) BEGIN
			EXEC Base.UpdateNameValue null, 'JobBasePath', 'Automated Jobs Executable Location Path', 'System', 'E:\TriadcoreDesign\Triadcore', @StrId, '2019-01-01', null, 'The root path where automated jobs/process code are located.', null, @LoaderUserId, 'Created on DB auto-build.'
		END

		------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
		UPDATE Base.NameValues SET SortText=[Name] WHERE SortText=''
		
	COMMIT TRANSACTION TranNameValuesSeed
	
END

select * from Base.NameValues order by NameGroup, [Name]


