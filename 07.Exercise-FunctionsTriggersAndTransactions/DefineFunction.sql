CREATE FUNCTION ufn_IsWordComprised(@setOfLetters varchar(100), @word varchar(100))
RETURNS bit
AS
BEGIN
DECLARE @iter int = 1

WHILE @iter <= LEN(@word)
BEGIN
  IF (CHARINDEX( SUBSTRING(@word, @iter, 1), @setOFLetters) = 0)
    BEGIN
	  RETURN 0;
    END
	SET @iter += 1
END

RETURN 1;
END