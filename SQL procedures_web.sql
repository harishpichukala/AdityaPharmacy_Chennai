/*
	Create schema
*/
IF SCHEMA_ID('web') IS NULL BEGIN	
	EXECUTE('CREATE SCHEMA [web]');
END
GO


/*
	Return details on a specific customer
*/
CREATE OR ALTER PROCEDURE web.get_customer
@Json NVARCHAR(MAX)
AS
SET NOCOUNT ON;
DECLARE @Id INT = JSON_VALUE(@Json,'$.id');
SELECT 
[lastBillDate],
[LastBillAmount],
[LastBillNumber],
[TransactionType]
FROM 
	Harish_Test1
WHERE 
	[id] = @Id
FOR JSON PATH
GO


CREATE OR ALTER PROCEDURE web.get_customers
AS
SET NOCOUNT ON;
SELECT CAST((
	SELECT 
		[id], 
		[LastBillNumber]
	FROM 
		Harish_Test1
	FOR JSON PATH) AS NVARCHAR(MAX)) AS JsonResult
GO
