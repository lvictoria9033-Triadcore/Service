IF ( Base.TableExists('Service','Jobs')=1 ) BEGIN

	DECLARE @LoaderUserId INT = -1

	SELECT @LoaderUserId=UserId FROM Base.Users WHERE UserName='SysDataLoader'
	
	IF (SELECT COUNT(*) FROM [Service].Jobs)=0 BEGIN
		DBCC CHECKIDENT('[Service].Jobs', RESEED, 1)
	END

	------------------------------------------------------------------------------------------------------------------------------------
	/*
	IF ( NOT EXISTS(SELECT * FROM [Service].Jobs WHERE JobName='Test-Job') ) BEGIN
		EXEC [Service].UpdateJob null, 'Test-Job', '[Test Job]', 'Job for testing only.', '{BasePath}\Jobs', 'JobTest.exe', NULL, NULL, @LoaderUserId, NULL
	END
	*/

	------------------------------------------------------------------------------------------------------------------------------------
	UPDATE [Service].Jobs
	SET SortText = UPPER(JobName) WHERE ISNULL(SortText,'')=''

END

select * from [Service].Jobs order by SortText
