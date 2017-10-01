CREATE FUNCTION ufn_CalculateFutureValue (@Sum money, @InterestRate float, @Years int)
RETURNS money
AS
BEGIN

DECLARE @FV money;

SET @FV = @Sum * (power((1 + @InterestRate), @Years))

RETURN @FV;

END