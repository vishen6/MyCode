DECLARE @supplierid INT			=2
DECLARE @query NVARCHAR(MAX)
DECLARE @productname varchar(max)
SET @query='SELECT top 1 @productname=ProductName from [TSQL2012].[Production].[Products] where supplierid=@Supplierid'
Select @query
EXECUTE sp_executesql @query , N'@supplierid int,@productname nvarchar(max) OUTPUT',@supplierid=@supplierid,@productname=@productname OUTPUT
Select @productname as Productname