IF EXISTS (SELECT f.object_id FROM sys.objects f JOIN sys.schemas s ON f.schema_id=s.schema_id WHERE f.[type]='FN' AND f.name='GetJobScheduleNextRun' AND s.name='Service' ) BEGIN
	DROP FUNCTION [Service].GetJobScheduleNextRun
END

GO
	
CREATE FUNCTION [Service].GetJobScheduleNextRun
(
	@JobScheduleId INT
) 

RETURNS DATETIME

WITH EXECUTE AS CALLER

AS  
  
BEGIN

	DECLARE @CurrDate DATETIME = GETDATE()
	DECLARE @ResultDateTime DATETIME = CAST('9999-12-31' AS DATETIME)

	DECLARE @BaseDateTime DATETIME = NULL
	DECLARE @JobScheduleTypeId INT = NULL
	DECLARE @JobScheduleTypeName VARCHAR(100) = NULL
	DECLARE @Month INT = NULL
	DECLARE @Interval BIGINT = NULL
	DECLARE @DayIndex INT = NULL
	DECLARE @DayAbbrev VARCHAR(2) = NULL
	DECLARE @Date INT = NULL
	DECLARE @Time INT = NULL

	SELECT    @JobScheduleId       = js.JobScheduleId
			, @BaseDateTime        = js.BaseDateTime
			, @Month               = js.[Month]
			, @Interval            = js.Interval
			, @DayIndex            = js.[Day]
			, @Date                = js.[Date]
			, @Time                = js.[Time]
			, @JobScheduleTypeId   = jst.JobScheduleTypeId
			, @JobScheduleTypeName = jst.JobScheduleTypeName
	FROM [Service].JobSchedules js
			JOIN [Service].JobScheduleTypes jst ON js.JobScheduleTypeId=jst.JobScheduleTypeId
	WHERE js.JobScheduleId=@JobScheduleId

	SET @DayAbbrev = CASE
						WHEN @DayIndex=1 THEN 'SU'
						WHEN @DayIndex=2 THEN 'MO'
						WHEN @DayIndex=3 THEN 'TU'
						WHEN @DayIndex=4 THEN 'WE'
						WHEN @DayIndex=5 THEN 'TH'
						WHEN @DayIndex=6 THEN 'FR'
						WHEN @DayIndex=7 THEN 'SA'
						ELSE NULL
					 END

	SET @ResultDateTime  = CASE
							WHEN @JobScheduleTypeName='TimeInterval'      THEN DATEADD(MI, @Interval, DATEADD(MI, (DATEDIFF(MI, @BaseDateTime, @CurrDate)/@Interval)*@Interval, @BaseDateTime))
							WHEN @JobScheduleTypeName='DailyInterval'     THEN DATEADD(HH, 24, DATEADD(HH, (DATEDIFF(HH, @BaseDateTime, @CurrDate)/24)*24, @BaseDateTime))
							WHEN @JobScheduleTypeName='DayInterval'       THEN DATEADD(DD, ((DATEDIFF(DD, @BaseDateTime, @CurrDate)/7)+1)*7, @BaseDateTime)
							WHEN @JobScheduleTypeName='DayOccurrence'     THEN DATEADD(DD, DATEDIFF(DD, @BaseDateTime, Base.SequencedDowOfMonth(DATEADD(M, 1, @CurrDate), @Interval, @DayAbbrev)), @BaseDateTime)
							WHEN @JobScheduleTypeName='LastDayOccurrence' THEN DATEADD(DD, DATEDIFF(DD, @BaseDateTime, Base.LastDowOfMonth(DATEADD(M, 1, @CurrDate), @DayAbbrev)), @BaseDateTime)
							WHEN @JobScheduleTypeName='LastDayOfMonth'    THEN DATEADD(DD, DATEDIFF(DD, @BaseDateTime, Base.LastDateOfMonth(DATEADD(M, 1, @CurrDate))), @BaseDateTime)
							WHEN @JobScheduleTypeName='DateInterval'      THEN DATEADD(DD, DATEDIFF(DD, @BaseDateTime, DATEADD(M, 1, DATEADD(DD, @Date-1, DATEADD(DD, (DATEPART(DD, @CurrDate)*-1)+1, @CurrDate)))), @BaseDateTime)
							WHEN @JobScheduleTypeName='MonthInterval'     THEN DATEADD(DD, DATEDIFF(DD, @BaseDateTime, DATEADD(DD, @Date-1, DATEADD(MM, @Month-1, DATEADD(YY, 1, Base.FirstOfYear(@CurrDate))))), @BaseDateTime)
							WHEN @JobScheduleTypeName='MonthDayInterval'  THEN DATEADD(DD, DATEDIFF(DD, @BaseDateTime, Base.SequencedDowOfMonth(DATEADD(MM, @Month-1, Base.FirstOfYear(DATEADD(YY, 1, @CurrDate))), @Interval, @DayAbbrev)), @BaseDateTime)
							WHEN @JobScheduleTypeName='MonthDateInterval' THEN DATEADD(DD, DATEDIFF(DD, @BaseDateTime, DATEADD(DD, @Date-1, DATEADD(MM, DATEPART(MM, @CurrDate)-1, Base.FirstOfYear(DATEADD(YY, 1, @CurrDate))))), @BaseDateTime)
							ELSE CAST('9999-12-31' AS DATETIME)
				          END

	RETURN @ResultDateTime;
	
END;