IF Object_ID('tempdb..#source') is Not null Drop table #source
IF Object_ID('tempdb..#target') is Not null Drop table #target
CREATE TABLE #source(
 id int
,name varchar(max)
)

CREATE TABLE #target(
 id int
,name varchar(max)
,[EffectiveStartDate] Datetime
,[EffectiveEndDate]	Datetime
,[IsActiveRecord]	int
)
Insert into #source(id,name)
Values(1,'shubham'),(2,'vishen'),(3,'chirag')

DECLARE @TodayDate datetime = getdate()

INSERT INTO #target
           (ID 
	  ,name
      ,[EffectiveStartDate]
      ,[EffectiveEndDate]
      ,[IsActiveRecord]
      )

SELECT 	ID 
	  ,name
      ,[EffectiveStartDate]
      ,[EffectiveEndDate]
      ,[IsActiveRecord]
	 
FROM

(
 MERGE #target TARGET
 USING
 (
 SELECT id,name from #source 
	   )Source 
 ON Source.id = Target.id
 AND TARGET.IsActiveRecord=1

 WHEN NOT MATCHED BY TARGET THEN
 INSERT (	
       ID 
	  ,name
      ,[EffectiveStartDate]
      ,[EffectiveEndDate]
      ,[IsActiveRecord])

VALUES (	 ID 
	  ,name
      ,@TodayDate
      ,NULL
      ,1
     )

WHEN NOT MATCHED BY SOURCE

THEN 
UPDATE
SET 
Target.IsActiveRecord = 0

WHEN MATCHED AND (
				Source.name									<> TARGET.name
				) THEN
UPDATE 
SET 
Target.EffectiveEndDate = @TodayDate-1,
Target.IsActiveRecord = 0

OUTPUT $Action AS Action,
	   Source.id
      ,Source.name
      ,@TodayDate AS EffectiveStartDate
      ,null	As EffectiveEndDate
      ,1	As IsActiveRecord
     
	  
) AS MergeOutput
WHERE Mergeoutput.Action = 'Update'


Select * from #target



