CREATE VIEW V_IoTHubLog AS
SELECT [id]
      ,DATEADD(hour,9,[EventEnqueuedUtcTime]) as LocalDateTime
      ,DATENAME(month,DATEADD(hour,9,[EventEnqueuedUtcTime])) as LocalMonth
	  ,DATENAME(day,DATEADD(hour,9,[EventEnqueuedUtcTime])) as LocalDay
      ,DATENAME(hour,DATEADD(hour,9,[EventEnqueuedUtcTime])) as LocalHour
      ,[IoTHub_ConnectionDeviceId]
      ,b.[DeviceType]
      ,[RBFX_MessageId]
      ,[visitor]
      ,[gender]
      ,[age]
      ,[nendai] = 
		CASE 
			WHEN [age] > 0   AND [age] < 20 THEN N'10代'
			WHEN [age] >= 20 AND [age] < 30 THEN N'20代'
			WHEN [age] >= 30 AND [age] < 40 THEN N'30代'
			WHEN [age] >= 40 AND [age] < 50 THEN N'40代'
			WHEN [age] >= 50 THEN N'50代以上'
		END
      ,[product]
	  ,[カテゴリ] as category
	  ,[カラー] as color
	  ,cast([単価] as float) as unit_price
      ,cast([quantity] as int) as quantity
	  ,(cast([単価] as float) * cast([quantity] as int)) as OrderPrice
      ,cast([stock] as int) as stock
      ,[result]
      ,CAST(1 as int) AS [counter]
  FROM [RBFX].[DeviceMaster] b, [RBApp].[IoTHubLog] a
  LEFT OUTER JOIN [RBApp].[Product] c
  ON a.[product] = c.[SKUID]
  WHERE a.[IoTHub_ConnectionDeviceId] = b.[DeviceId] 
