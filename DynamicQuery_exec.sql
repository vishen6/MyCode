DECLARE @supplierid INT			=2
DECLARE @query NVARCHAR(MAX)		='SELECT ProductName FROM [TSQL2012].[Production].[Products] where supplierid='+LTRIM(@supplierid)
EXEC (@query)
