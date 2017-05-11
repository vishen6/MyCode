DECLARE @str		VARCHAR(MAX)='ab,bc,qr'
	   ,@delim		VARCHAR(MAX)=','

DECLARE @commaPos	int=CHARINDEX(@delim,@str)
DECLARE @output Table(val VARCHAR(MAX))

SET		@str=@str+@delim

WHILE   @commaPos <>0
BEGIN 
	INSERT  INTO @output (val) Values(SUBSTRING(@str,1,@commaPos-1))
	SET		@str		=SUBSTRING(@str,@commaPos+1,Len(@str)-LEN(SUBSTRING(@str,1,@commaPos)))
	SET		@commaPos	=CHARINDEX(@delim,@str)
END

SELECT val from @output