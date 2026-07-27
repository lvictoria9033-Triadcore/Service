/********************************************************************************************************************************************************************
Purpose: Implements updates to the table. 
		 These updates must run as a separate script as running in the same script that creates the table component (ie. column) results in SQL server not
		 recognizing create column instruction by the time it starts to run the script below.
		 Example: When attempting to run the command to set a column to blank ('') immediatetly after creating the column results in a "column not found" error.
Author : Leonard Victoria
Company: Triadcore Design, LLC.
History:
		2018.08.01 - Created.
********************************************************************************************************************************************************************/

-- Ensure table exists
IF ( Base.TableExists('Service','Jobs')=0 ) BEGIN
	RETURN;
END

-- ParamString  -- added as nullable AFTER the table was originally created
IF ( Base.ColumnExists('Service','Jobs','ParamString')=1 ) BEGIN
	-- Set null columns to default value
	UPDATE [Service].Jobs SET ParamString='' WHERE ParamString IS NULL
	-- Delete unique constraint because it depends on the column
	IF ( Base.UniqueConstraintExists('Service','Jobs','UNQ_Service_Jobs')=1) BEGIN
		ALTER TABLE [Service].Jobs DROP CONSTRAINT UNQ_Service_Jobs
	END
	-- Set column as NOT NULLABLE
	ALTER TABLE [Service].Jobs ALTER COLUMN ParamString VARCHAR(1000) NOT NULL
	-- Create column default constraint
	IF ( Base.ColumnDefaultExists('Service','Jobs','ParamString','DFLT_Service_Jobs_ParamString')=0 ) BEGIN
		ALTER TABLE [Service].Jobs ADD CONSTRAINT DFLT_Service_Jobs_ParamString DEFAULT ('') FOR [ParamString]
	END
	-- Create unique constraint
	IF (SELECT COUNT(JobId) FROM [Service].Jobs GROUP BY JobName HAVING COUNT(JobId)>1) IS NULL BEGIN -- ensure that there are no duplicates
		ALTER TABLE [Service].Jobs ADD CONSTRAINT UNQ_Service_Jobs UNIQUE (JobName, ExecFile, ParamString)
	END
	ELSE BEGIN
		RAISERROR ('Cannot create the Unique Constraint for the column [Service].[JobName], [Service].[ExecFile], and [Service].[ParamString].  The column combination contains non-unique values.',11,1) 
	END
END

select * from [Service].Jobs