/*
	Create schema
*/
IF SCHEMA_ID('web') IS NULL BEGIN	
	EXECUTE('CREATE SCHEMA [web]');
END
GO

CREATE LOGIN harish WITH PASSWORD = 'pass@123';
CREATE USER harish FOR LOGIN harish;  


/*
	Create user to be used in the sample API solution
*/
CREATE USER MyUser
WITH PASSWORD = 'pass@123';
GO


USE [MyDb]
GO
IF USER_ID('PythonWebApp') IS NULL BEGIN	
	CREATE USER [PythonWebApp] WITH PASSWORD = 'a987REALLY#$%TRONGpa44w0rd';	
END

/*
	Grant execute permission to created users
*/
GRANT EXECUTE ON SCHEMA::[web] TO [harish];
GRANT EXECUTE ON SCHEMA::[dbo] TO [harish];
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