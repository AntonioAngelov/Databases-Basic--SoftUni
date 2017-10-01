CREATE FUNCTION ufn_GetSalaryLevel(@salary MONEY)
RETURNS varchar(10)
AS
BEGIN
IF(@salary < 30000)
  BEGIN
    RETURN 'Low';
  END
ELSE IF(@salary > 50000)
  BEGIN
    RETURN 'High';
  END

    RETURN 'Average';
END